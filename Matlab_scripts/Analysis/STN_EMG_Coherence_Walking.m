%% =====  STN_EMG_Coherence_Walking.m  ========================================%

%Date: December 2023
%Original author(s): Philipp Klocke, Moritz Loeffler

%This script will first call all the timepoints for walking activity that
%were specified and stored in the Sub_GrandActivity_Log.m file. We will
%first insert both EMG and LFP timeseries into fieldtrip and compute the
%wavelet coherence between both signals. Second, we will use the standing
%coherence as our baseline and normalize coherence spectra. Coherence
%spectra will be computed for the tibialis anterior (TA) and gastrocnemius
%muscles (GA) yielding the subthalamo-muscular coherence. Only the disease
%dominant STN will be focus of the current analysis. 
%===========================================================================%


subjectdata.generalpath                 = uigetdir;                                                                 % Example: Call the SenseFOG-main file
cd(subjectdata.generalpath)
names                                   = cellstr(strsplit(sprintf('sub-%02d ',1:20)));                             % Create a list of sub-names

for i = 1:20
    if ~isfolder(names{i}) == 1                                                                                     % Check if general folder exists for sub-XX
        fprintf(2," \n Missing Folder for %s ", names{i}); continue
    elseif isfolder(names{i}) == 1
        fprintf("\n Existing Folder for %s ", names{i})
        full_filename = append(subjectdata.generalpath, "/", names{i},"/", names{i}, "-dataevents.mat");            % Search for the dataevents.mat file in each subfile
        if isfile(full_filename); 
            Files(i).File = load(full_filename);             
            Files(i).name = sprintf('sub_%02d',i);
        elseif ~isfile(full_filename); fprintf(2," \n Missing Dataevents File for %s ", names{i}); continue
        end
    end
end
clear i full_filename

%Clear Files that have no content
idx     = find(cellfun(@isempty,{Files.File})); Files(idx) = []; clear idx
names   = {Files.name}';                                                                                             % Create a new names list

Subjects = struct; 
for i = 1:length(Files)
    Subjects.(names{i}) = Files(i).File.LFP_Events;
end

if isfield(Subjects, "sub_20")
    %Update September 2023 - Gyroscope Data of PD20 is deg/s switch to rad/s as we will switch back to deg/s later
    Subjects.PD20.Walk.Gyroscope_LF     = rad2deg(Subjects.PD20.Walk.Gyroscope_LF);
    Subjects.PD20.Walk.Gyroscope_RF     = rad2deg(Subjects.PD20.Walk.Gyroscope_RF);
    Subjects.PD20.WalkINT.Gyroscope_LF  = rad2deg(Subjects.PD20.WalkINT.Gyroscope_LF);
    Subjects.PD20.WalkINT.Gyroscope_RF  = rad2deg(Subjects.PD20.WalkINT.Gyroscope_RF);
end

%Re-compute gait cycles and add features such as toe-off, midswing etc. 
task    = {'Walk'; 'WalkWS'; 'WalkINT'; 'WalkINT_new'};
site    = {'Walking_Right_HS'; 'Walking_Left_HS'};
IMU     = {'Accelerometer_RF','Gyroscope_RF'; 'Accelerometer_LF','Gyroscope_LF'};
fs      = 1000; 


for k = 1:length(names)
    for m = 1:length(task)
         if isfield(Subjects.(names{k}), task(m)) == 0; continue; end
         for t = 1:length(site)
             if isfield(Subjects.(names{k}).(task{m}),site(t)) == 0; continue; end

             datafile                        = Subjects.(names{k}).(task{m});
             Accelerometer                   = datafile.(IMU{t,1})(:,3);                        %Defines Accelerometer in Anterior-Posterior plane
             Gyroscope                       = rad2deg(datafile.(IMU{t,2})(:,2));               %Defines Gyroscope in Saggital Plane and converts from rad/s to degrees/s
             IMU_time                        =  (1/fs):(1/fs):(length(Accelerometer)/fs);

             GaitParameter                   = struct;
             for i = 1:length(datafile.(site{t}))
                 %FIND HEELSTRIKE 1 ==============================================================
                x1                          = single(datafile.(site{t})(i).start*fs);
                temp_time                   = IMU_time(:,[x1-500:x1]);                          %Find preceding midswing within 500 ms range
                temp_gyr                    = Gyroscope([x1-500:x1],:);                         %Find preceding midswing within 500 ms range
                [MS_pks, MS_locs]           = findpeaks(-temp_gyr,temp_time, "SortStr","descend");
                MS_locs                     = MS_locs(1); MS_pks = MS_pks(1);                   %Make sure sign (+/-) is right
            
                %Once the Midswing is identified, find the Heelstrike in the time interval after MS as the min. value of angular velocity in the sagittal plane before the maximum anterior–posterior acceleration
                temp_time                   = IMU_time(:, [single(MS_locs * fs):single(MS_locs * fs)+500]);
                temp_accl                   = Accelerometer([single(MS_locs * fs):single(MS_locs * fs)+500],:); 
                [pks, locs]                 = findpeaks(temp_accl,temp_time,'SortStr','descend');
                locs                        = locs(1);
            
                %Having found the Midswing and the maximum anterior–posterior acceleration, identify the minimum value of angular velocity 
                temp_time                   = IMU_time(:, [single(MS_locs*fs):single(locs*fs)]); 
                temp_gyr                    = Gyroscope([single(MS_locs*fs):single(locs*fs)],:);
                [HS_pks, HS_locs]           = findpeaks(temp_gyr,temp_time, 'SortStr','descend');
                if isempty(HS_locs) == 1;     HS_locs = locs; HS_pks = Gyroscope(single(HS_locs*fs),:); end     %Make sure the peak is the same unit as the gyroscope 
                GaitParameter(i).HS_locs_1  = HS_locs(1); 
               
                clear x1 temp_time temp_gyr temp_accl MS_pks MS_locs pks locs HS_pks HS_locs

                %Find HEELSTRIKE 2 ==============================================================
                x2                          = single(datafile.(site{t})(i).end*fs);
                temp_time                   = IMU_time(:,[x2-500:x2]);                          %Find preceding midswing within 500 ms range
                temp_gyr                    = Gyroscope([x2-500:x2],:);                         %Find preceding midswing within 500 ms range
                [MS_pks, MS_locs]           = findpeaks(-temp_gyr,temp_time, "SortStr","descend");
                MS_locs                     = MS_locs(1); MS_pks = -MS_pks(1);                  %Make sure sign (+/-) is right
                GaitParameter(i).MS_locs    = MS_locs; 
               
                %Once the Midswing is identified, find the preceding Toe-OFF as minimum anterior–posterior acceleration 
                temp_time                   = IMU_time(:, [single(MS_locs * fs)-500:single(MS_locs * fs)]);
                temp_accl                   = Accelerometer([single(MS_locs * fs)-500:single(MS_locs * fs)],:); 
                [TO_pks, TO_locs]           = findpeaks(-temp_accl, temp_time,'SortStr','descend');
                GaitParameter(i).TO_locs    = TO_locs(1); 
               
                %Once the Midswing is identified, find the Heelstrike in the time interval after MS as the min. value of angular velocity in the sagittal plane before the maximum anterior–posterior acceleration
                temp_time                   = IMU_time(:, [single(MS_locs * fs):single(MS_locs * fs)+500]);
                temp_accl                   = Accelerometer([single(MS_locs * fs):single(MS_locs * fs)+500],:); 
                [pks, locs]                 = findpeaks(temp_accl,temp_time,'SortStr','descend');
                locs                        = locs(1);
            
                %Having found the Midswing and the maximum anterior–posterior acceleration, identify the minimum value of angular velocity 
                temp_time                   = IMU_time(:, [single(locs*fs)-100:single(locs*fs)]); 
                temp_gyr                    = Gyroscope([single(locs*fs)-100:single(locs*fs)],:);
                [HS_pks, HS_locs]           = findpeaks(temp_gyr,temp_time, 'SortStr','descend');
                if isempty(HS_locs) == 1;     HS_locs = locs; HS_pks = Gyroscope(single(HS_locs*fs),:); end     %Make sure the peak is the same unit as the gyroscope 
                GaitParameter(i).HS_locs_2  = HS_locs(1); 
                GaitParameter(i).GC_duration= GaitParameter(i).HS_locs_2 - GaitParameter(i).HS_locs_1;

                %Compute relative timepoints for TO and MS
                GaitParameter(i).TO_rel     = (GaitParameter(i).TO_locs - GaitParameter(i).HS_locs_1) / GaitParameter(i).GC_duration * 100;
                GaitParameter(i).MS_rel     = (GaitParameter(i).MS_locs - GaitParameter(i).HS_locs_1) / GaitParameter(i).GC_duration * 100;
                
                clear temp_time temp_gyr temp_accl MS_pks MS_locs pks locs HS_pks HS_locs TO_pks TO_locs x2 
             end
             
             %Store GaitParameters back into the Subject File
             Subjects.(names{k}).(task{m}).(site{t}) = GaitParameter;
         end
    end
end

%Clean-UP
clear Accelerometer datafile GaitParameter Gyroscope IMU_time IMU k m site t task Files i

%***********************************************************************************************************************
%Make Manual Adjustments after careful REVIEW of each GaitCycle
%if isfield(Subjects.sub_01.Walk, 'Walking_Right_HS')
%    Subjects.sub_01.Walk.Walking_Right_HS.HS_locs_1         = XX; 
%end
%***********************************************************************************************************************

%PRE-PROCESS LFP DATA
task        = {'Walk'; 'WalkWS'; 'WalkINT'; 'WalkINT_new'};
site        = {'LFP_signal_L', 'Walking_Right_HS' , 'STN'; 'LFP_signal_R', 'Walking_Left_HS', 'STN'}; 
foot        = {'Accelerometer_RF', 'Gyroscope_RF'; 'Accelerometer_LF', 'Gyroscope_LF'};
Coherence   = struct; 

for k = 1:length(names)
    for m = 1:length(task)
        if isfield(Subjects.(names{k}), task(m)) == 0; continue; end
        for t = 1:size(site,1)
            if isfield(Subjects.(names{k}).(task{m}), site(t,2)) == 0; continue; end
            %LOAD LFP Data ============================================================
            cfg                 = [];
            datafile.trial{1}   = [Subjects.(names{k}).(task{m}).(site{t,1})];
            datafile.time{1}    = (1/fs):(1/fs):(length(datafile.trial{1})/ fs);
            datafile.label      = site(t,3); 
            datafile.fsample    = fs;  

            cfg.trl             = [];     % Keep empty so the entire dataset is used
            cfg.continuous      = 'yes';
            cfg.demean          = 'no';   
            cfg.dftfilter       = 'no';   % De-activate 50 Hz (default) notch-filter
            cfg.channel         = 'all';
            cfg.hpfilter        = 'yes';  % Higphass filter at 1 Hz
            cfg.hpfreq          =  1;     % Higphass filter at 1 Hz
            cfg.rectify         = 'no';   % No rectifying of signal
            LFP                 = ft_preprocessing(cfg, datafile);
            LFP.events          = Subjects.(names{k}).(task{m}).(site{t,2});

            clear x1 x2 store datafile cfg  e

            %LOAD EMG Data ===============================================================
            datafile.trial{1}   = [Subjects.(names{k}).(task{m}).EEG.EEG_signal];             % Assign the EEG/EMG Data to the configuration structure
            datafile.time{1}    = [Subjects.(names{k}).(task{m}).EEG.EEG_time];               % Assign time to the configuration structure
            datafile.label      = table2cell(Subjects.(names{k}).(task{m}).EEG.EEG_channels); % Assign the EEG labels to the configuration structure
            datafile.fsample    = fs;                                                         % Assign the correct sampling rate to the configuration structure

            channellist.Walking_Right_HS    = {'TA_R1', 'TA_R2' 'TA';'GA_R1' 'GA_R2' 'GA'};
            channellist.Walking_Left_HS     = {'TA_L1', 'TA_L2' 'TA';'GA_L1' 'GA_L2' 'GA'};

             for i = 1:height(channellist.Walking_Right_HS)
                cfg                      = [];
                cfg.channel              = channellist.(site{t,2})(i,[1 2]);    % Use assigned channels
                cfg.reref                = 'yes';                               % Re-Reference
                cfg.refmethod            = 'bipolar';                           % Choose Bipolar Channels
                cfg.refchannel           = channellist.(site{t,2})(i,:);
                cfg.continuous           = 'yes';
                cfg.demean               = 'no';
                cfg.bpfilter             = 'yes';                               % Activate Band-Pass Filter
                cfg.bpfreq               = [10 300];                            % Bandpass frequency range, specified as [lowFreq highFreq] in Hz
                cfg.dftfilter            = 'yes';                               % Activate 50 Hz (default) Notch-Filter
                cfg.rectify              = 'yes';                               % Rectify Channels 'no' or 'yes' (default = 'no')
                data_avg                 = ft_preprocessing(cfg, datafile);     % Re-Reference Channels    
                store(i).trial           = data_avg.trial{1};                   % Store Re-Referenced Channels
                store(i).location        = channellist.(site{t,2})(i,3);        % Assign Name to the Channels    
                store(i).time            = data_avg.time{1};
                store(i).sampleinfo      = data_avg.sampleinfo;
                store(i).cfg             = data_avg.cfg;
                store(i).fsample         = fs; 
             end

            %Concatenate arrays
            temp_store.trial            = {cat(1,store.trial)};
            temp_store.label            = [store.location]';
            temp_store.time             = {store(1).time};
            temp_store.sampleinfo       = store(1).sampleinfo; 
            temp_store.fsample          = store(1).fsample;
            temp_store.cfg              = store(1).cfg; 

            EMG  = temp_store;

            %Make sure that EMG and LFP files are of the same length
            if length(EMG.trial{1}(1,:)) > length(LFP.trial{1}(1,:))
               EMG.trial{1}      = EMG.trial{1}(:,1:size(LFP.trial{1}(1,:),2));
               EMG.time(:,1)     = LFP.time;
               EMG.sampleinfo    = LFP.sampleinfo;

            elseif length(EMG.trial{1}(1,:)) < length(LFP.trial{1}(1,:))
               LFP.trial{1}      = LFP.trial{1}(:,1:size(EMG.trial{1}(1,:),2));
               LFP.time          = {EMG.time{1}(1,:)};
               LFP.sampleinfo    = EMG.sampleinfo;
            end
            Coherence.(names{k}).(task{m}).(site{t,2})                      = ft_appenddata([], LFP, EMG);
            Coherence.(names{k}).(task{m}).(site{t,2}).events               = LFP.events;
            Coherence.(names{k}).(task{m}).(site{t,2}).Accelerometer        = Subjects.(names{k}).(task{m}).(foot{t,1})(:,3); %Anterior Posterior Plane Accelerometer
            Coherence.(names{k}).(task{m}).(site{t,2}).Gyroscope            = rad2deg(Subjects.(names{k}).(task{m}).(foot{t,2})(:,2)); %Saggital PLane Gyroscope
            clear LFP EMG
        end
    end
end
    
%Clear-UP
clear cfg channellist data_avg datafile fs i k m site store t task  temp_store trl


%Compute Wavelet Coherence
%CAVE:THIS WILL LIKELY TAKE UP A LOT OF STORAGE SPACE AND BE TIME CONSUMING
task    = {'Walk'; 'WalkWS'; 'WalkINT'; 'WalkINT_new'};
site    = {'Walking_Right_HS' ; 'Walking_Left_HS'};
modes   = {'STN_TA', 'STN_TA_rs'; 'STN_GA', 'STN_GA_rs'; 'TA_GA', 'TA_GA_rs'}; 
fs      = 1000;  
names   = fieldnames(Coherence); 

for k = 1:length(names)
    for m = 1:length(task)
        if isfield(Coherence.(names{k}), task(m)) == 0; continue; end
        for t = 1:size(site,1)
            if isfield(Coherence.(names{k}).(task{m}), site(t,1)) == 0; continue; end

            datafile = Coherence.(names{k}).(task{m}).(site{t});

            wavelet_coh = struct;
            wavelet_coh(1).name  = "STN_TA"; [wavelet_coh(1).coh, ~, f] = wcoherence(datafile.trial{1}(1,:),datafile.trial{1}(2,:), fs, 'FrequencyLimits',[1 40]); %1 = STN
            wavelet_coh(2).name  = "STN_GA"; [wavelet_coh(2).coh, ~, f] = wcoherence(datafile.trial{1}(1,:),datafile.trial{1}(3,:), fs, 'FrequencyLimits',[1 40]); %2 = TA
            wavelet_coh(3).name  = "TA_GA" ; [wavelet_coh(3).coh, ~, f, ~, wavelet_coh(3).wtTA, wavelet_coh(3).wtGA] = wcoherence(datafile.trial{1}(2,:),datafile.trial{1}(3,:), fs, 'FrequencyLimits',[1 40]); %3 = GA
             
            %Rawfiles
            TA_raw = datafile.trial{1}(2,:); %TA
            GA_raw = datafile.trial{1}(3,:); %GA

            %Use a 4th order 6 Hz Lowpass Butterworth Filter to create an EMG envelope (This will be used to create cocontraction index)
            fc      = 6;
            fs      = 1000;
            [b,a]   = butter(4,fc/(fs/2));
            TA_env  = filter(b,a,TA_raw);
            GA_env  = filter(b,a,GA_raw); 


            %Create RMS TA/GA Files =====
            TA_rms_raw = sqrt(movmean(TA_raw .^2, 10));    
            GA_rms_raw = sqrt(movmean(GA_raw .^2, 10));    

           
           %Extract TF-information based on timepoints
           dataset = []; 
           for i = 1:length(datafile.events)
               dataset(i).start             = datafile.events(i).HS_locs_1; 
               dataset(i).stop              = datafile.events(i).HS_locs_2; 
               dataset(i).diff              = datafile.events(i).GC_duration;
               dataset(i).TO_rel            = datafile.events(i).TO_rel; 
               dataset(i).MS_rel            = datafile.events(i).MS_rel; 
               dataset(i).name              = names(k); 
               dataset(i).STN_TA            = wavelet_coh(1).coh(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]); 
               dataset(i).STN_GA            = wavelet_coh(2).coh(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]); 
               dataset(i).TA_GA             = wavelet_coh(3).coh(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]);    
               dataset(i).wt_TA             = wavelet_coh(3).wtTA(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]);
               dataset(i).wt_GA             = wavelet_coh(3).wtGA(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]);
               dataset(i).TA_raw            = TA_raw(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]);                     %TA Raw Signal
               dataset(i).GA_raw            = GA_raw(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]);                     %GA Raw Signal
               dataset(i).TA_rms_raw        = TA_rms_raw(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]);                 %TA Raw RMS Signal
               dataset(i).GA_rms_raw        = GA_rms_raw(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]);                 %GA Raw RMS Signal
               dataset(i).TA_env            = TA_env(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]);                     %TA Envelope
               dataset(i).GA_env            = GA_env(:, [single(1000*dataset(i).start): single(1000*dataset(i).stop)]);                     %GA Envelope
               dataset(i).Accelerometer     = datafile.Accelerometer([single(1000*dataset(i).start): single(1000*dataset(i).stop)],:)';     %IMU signal  
               dataset(i).Gyroscope         = datafile.Gyroscope([single(1000*dataset(i).start): single(1000*dataset(i).stop)],:)';         %IMU signal  
           end
           Coherence.(names{k}).(task{m}).(site{t}).coh_files = dataset;
           clear datafile dataset
        end
    end
end

%CLEAN-UP
clear a b fc foot GA_env GA_raw GA_rms_raw i k m modes t TA_env TA_raw TA_rms_raw wavelet_coh


modes   = {'STN_TA', 'STN_TA_rs'; 'STN_GA', 'STN_GA_rs'; 'TA_GA', 'TA_GA_rs'; 'TA_rms_raw', 'TA_rms_raw_rs'; 'GA_rms_raw', 'GA_rms_raw_rs'; 'TA_env' , 'TA_env_rs'; 'GA_env', 'GA_env_rs'}; 
fs      = 1000;  
names   = fieldnames(Coherence); 

COHERENCE.Walking_Right_HS = []; COHERENCE.Walking_Left_HS = [];

for k = 1:length(names)
    for m = 1:length(task)
        if isfield(Coherence.(names{k}), task(m)) == 0; continue; end
        for t = 1:size(site,1)
            if isfield(Coherence.(names{k}).(task{m}), site(t,1)) == 0; continue; end
            if isfield(Coherence.(names{k}).(task{m}).(site{t}), 'coh_files') == 0; continue; end
              COHERENCE.(site{t}) = [ COHERENCE.(site{t}), Coherence.(names{k}).(task{m}).(site{t}).coh_files];
        end
    end
end

%Find STN-DOMINANCE
bsl_names = fieldnames(Baseline_Stand);
for i = 1:length(bsl_names)
    stn_dominance(i).name = bsl_names(i);
    stn_dominance(i).site = Baseline_Stand.(bsl_names{i}).STN_dominance;
end

%PLACE FILES INTO DOMINANT AND NON-DOMINANT CATEGORIES
COHERENCE.DOMINANT_STN = []; COHERENCE.NON_DOMINANT_STN = [];
for i = 1:length(COHERENCE.Walking_Left_HS)
    name_idx        = COHERENCE.Walking_Left_HS(i).name;
    stn_dominance   = Subjects.(name_idx{1}).Baseline_Coherence.STN_dominance;  
    if stn_dominance == "Left"
        COHERENCE.NON_DOMINANT_STN = [COHERENCE.NON_DOMINANT_STN, COHERENCE.Walking_Left_HS(i)];
    elseif stn_dominance == "Right"
         COHERENCE.DOMINANT_STN = [COHERENCE.DOMINANT_STN, COHERENCE.Walking_Left_HS(i)];
    end
end

for i = 1:length(COHERENCE.Walking_Right_HS)
   name_idx        = COHERENCE.Walking_Right_HS(i).name;
   stn_dominance   = Subjects.(name_idx{1}).Baseline_Coherence.STN_dominance;  
    if stn_dominance == "Right"
        COHERENCE.NON_DOMINANT_STN = [COHERENCE.NON_DOMINANT_STN, COHERENCE.Walking_Right_HS(i)];
    elseif stn_dominance == "Left"
         COHERENCE.DOMINANT_STN = [COHERENCE.DOMINANT_STN, COHERENCE.Walking_Right_HS(i)];
    end
end

%REMOVE EXCESSIVE DATA
COHERENCE = rmfield(COHERENCE, {'Walking_Right_HS', 'Walking_Left_HS'});

%RESAMPLE TF-MATRICES TO SAME LENGTH [e.g. 1000]
sites    = {'DOMINANT_STN'};
modes    = {'STN_TA', 'STN_TA_rs'; 'STN_GA', 'STN_GA_rs'; 'TA_GA', 'TA_GA_rs'; 'wt_TA', 'wt_TA_rs'; 'wt_GA', 'wt_GA_rs'; 'TA_raw', 'TA_raw_rs'; 'GA_raw', 'GA_raw_rs'; 'TA_rms_raw', 'TA_rms_raw_rs'; 'GA_rms_raw', 'GA_rms_raw_rs';'TA_env', 'TA_env_rs'; 'GA_env', 'GA_env_rs'; 'Accelerometer', 'Accelerometer_rs'; 'Gyroscope', 'Gyroscope_rs'}; 

for t = 1:length(sites)
    for l = 1:length(modes)
       for i = 1:length(COHERENCE.(sites{t}))
            for z = 1:height(COHERENCE.(sites{t})(i).(modes{l,1}))
                pp = [flip(COHERENCE.(sites{t})(i).(modes{l,1})(z,:)) COHERENCE.(sites{t})(i).(modes{l,1})(z,:) flip(COHERENCE.(sites{t})(i).(modes{l,1})(z,:))]; 
                qq = resample(pp,3000,length(pp));
                COHERENCE.(sites{t})(i).(modes{l,2})(z,:) = qq(:,1001:2000);
            end
        end
    end
end
         
COHERENCE.DOMINANT_STN                  = rmfield(COHERENCE.DOMINANT_STN, {'STN_TA', 'STN_GA', 'TA_GA', 'wt_TA', 'wt_GA', 'GA_raw', 'TA_raw', 'TA_rms_raw', 'GA_rms_raw', 'TA_env', 'GA_env', 'Accelerometer', 'Gyroscope'});
COHERENCE.NON_DOMINANT_STN              = rmfield(COHERENCE.NON_DOMINANT_STN, {'STN_TA', 'STN_GA', 'TA_GA', 'wt_TA', 'wt_GA', 'GA_raw', 'TA_raw','TA_rms_raw', 'GA_rms_raw','TA_env', 'GA_env', 'Accelerometer', 'Gyroscope'});
STN_EMG_COHERENCE.Regular_Gait          = COHERENCE.DOMINANT_STN;
STN_EMG_COHERENCE.f                     = f; 
NON_DOMINANT_STN_COHERENCE.Regular_Gait = COHERENCE.NON_DOMINANT_STN;
NON_DOMINANT_STN_COHERENCE.f            = f; 

%Clean-UP
clear bsl_names filepath fs i idx k l modes pp qq site sites stn_dominance t task wavelet_coh z f m 
clear GA_raw TA_raw foot name_idx Coherence


%SAVE DATA
%save([subjectdata.generalpath filesep 'STN_EMG_Coherence_Walking_Files.mat'], 'STN_EMG_COHERENCE', '-mat')

% *********************** END OF SCRIPT ************************************************************************************************************************
