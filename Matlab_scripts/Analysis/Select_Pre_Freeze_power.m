%% =====  Select_Pre_Freeze_power.m  ========================================%

%Date: December 2023
%Original author(s): Philipp Klocke, Moritz Loeffler

%This script will first call all the timepoints for FOG events that
%were specified and stored in the Sub_GrandActivity_Log.m file. We will
%first compute the morlet wavelet spectra for the LFP time series and
%segment the time-frequency spectra according to gait cycles found before freeze onset.
%Then, we will use the standing baseline and normalize
%the power spectra yielding the mean %-change from standing.
%The current script will focus on data from the disease dominant STN.
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


%Update September 2023 - Gyroscope Data of PD20 is deg/s switch to rad/s 
if isfield(Subjects,"sub_20");       Subjects.sub_20.Walk.Gyroscope_LF = rad2deg(Subjects.sub_20.Walk.Gyroscope_LF);end
if isfield(Subjects,"sub_20");       Subjects.sub_20.Walk.Gyroscope_RF = rad2deg(Subjects.sub_20.Walk.Gyroscope_RF);end
if isfield(Subjects,"sub_20"); Subjects.sub_20.WalkINT.Gyroscope_LF = rad2deg(Subjects.sub_20.WalkINT.Gyroscope_LF);end
if isfield(Subjects,"sub_20"); Subjects.sub_20.WalkINT.Gyroscope_RF = rad2deg(Subjects.sub_20.WalkINT.Gyroscope_RF);end

%Update September 2023 - Remove Subject 15 WalkINT as data are compromised by artefacts
Subjects.sub_15 = rmfield(Subjects.sub_15, "WalkINT");

%August 2023: Remove subjects known not to have FOG (walk)
Subjects = rmfield(Subjects, {'sub_01','sub_05','sub_09','sub_11','sub_13','sub_18','sub_19'});
names    = fieldnames(Subjects);


%High Pass LFP Data ===================================================================================================
%Highpass LFP Data (1 Hz cutoff, Butterworth filter, filter order6, passed
%forward and backward) before applying continuous Morlet wavelet transformation
[b,a] = butter(6,1/(1000/2),'high');

task = {'Walk','WalkWS','WalkINT','WalkINT_new'};
for k = 1:length(names)
    for m = 1:length(task)
          if isfield(Subjects.(names{k}), task(m)) == 0; continue; end
          Subjects.(names{k}).(task{m}).LFP_signal_R = filter(b,a, Subjects.(names{k}).(task{m}).LFP_signal_R);
          Subjects.(names{k}).(task{m}).LFP_signal_L = filter(b,a, Subjects.(names{k}).(task{m}).LFP_signal_L); 
    end
end

clear a b k m task Files


%Apply Morlet Wavelet Transformation ===================================================================================
task = {'Walk','WalkWS','WalkINT','WalkINT_new'};
fs      = 1000; %Sampling Frequency
for k = 1:length(names)
    for m = 1:length(task)
        if isfield(Subjects.(names{k}), task(m)) == 0; continue; end
       
        %Left FOOT ===
        MFF = 4*pi/(6+sqrt(2+6^2));                                                                                 % Morlet-Fourier-Factor
        R_cwtstruct          = cwtft({Subjects.(names{k}).(task{m}).LFP_signal_R,1/fs},'wavelet', 'morl','scales',1./([1:1:100]*MFF)); 
        Subjects.(names{k}).(task{m}).R_wt                 = abs(R_cwtstruct.cfs);
        Subjects.(names{k}).(task{m}).f                    = R_cwtstruct.frequencies;

        %Right FOOT ===
        MFF = 4*pi/(6+sqrt(2+6^2));                                                                                 % Morlet-Fourier-Factor
        L_cwtstruct          = cwtft({Subjects.(names{k}).(task{m}).LFP_signal_L,1/fs},'wavelet', 'morl','scales',1./([1:1:100]*MFF)); 
        Subjects.(names{k}).(task{m}).L_wt                 = abs(L_cwtstruct.cfs);
        Subjects.(names{k}).(task{m}).f                    = L_cwtstruct.frequencies;
    end
end
clear MFF R_cwtstruct L_cwtstruct k m task


%Find Right- and Left Foot Heelstrikes for each Freezing Activity
task    = {'Walk'; 'WalkWS'; 'WalkINT'; 'WalkINT_new'};
field   = {'Walking_Freeze'};
Pre_FOG = struct; 

for k = 1:length(names)
    for m = 1:length(task)
        if  isfield(Subjects.(names{k}), task(m)) == 0; continue; end
            if isfield(Subjects.(names{k}).(task{m}), field) == 0; continue; end
            
            datafile = Subjects.(names{k}).(task{m}).(field{1});
                for i = 1:length(datafile)

                    freeze_start    = datafile(i).start;
                    RF_events       = sort(Subjects.(names{k}).(task{m}).rf_events.Heelstrike_Loc);                 % Sort in ascending order
                    RF_events       = RF_events(RF_events <= freeze_start);                                         % Only choose events that occur at or before stop
                    LF_events       = sort(Subjects.(names{k}).(task{m}).lf_events.Heelstrike_Loc);                 % Sort in ascending order
                    LF_events       = LF_events(LF_events <= freeze_start);                                         % Only choose events that occur at or before stop
                    DD_STN          = Subjects.(names{k}).Baseline_Power.STN_dominance;                             % Choose disease dominant STN
         
                    %Use the foot that corresponds to the disease dominant STN
                    if Subjects.(names{k}).Baseline_Power.STN_dominance == "Right"; foot = "Left";
                    
                        %Find Left Foot Heelstrikes occurring before freeze onset
                        [minDis,idxGC3] = min(abs(LF_events-freeze_start));
                       
                        %GC1
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).start             = LF_events(idxGC3-1);          % Choose the HS Loc before FOG onset
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).end               = LF_events(idxGC3);            % Start with FOG Onset
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).duration          = LF_events(idxGC3) -LF_events(idxGC3-1); %Compute Difference
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).foot              = "Left";  
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).DD_STN            = DD_STN;
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).distance_FoG      = Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).duration + minDis;  
                        
                        %GC2
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).start             = LF_events(idxGC3-2);          % Choose the HS that occurs before the end
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).end               = LF_events(idxGC3-1);          % Choose one HS Loc before FOG onset
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).duration          = LF_events(idxGC3-1) -LF_events(idxGC3-2); %Compute Difference
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).foot              = "Left";  
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).DD_STN            = DD_STN;
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).distance_FoG      = Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).distance_FoG + Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).duration;
           
                        %GC3
                        if idxGC3 > 3
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).start         = LF_events(idxGC3-3);          % Choose the HS that occurs before the end
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).end           = LF_events(idxGC3-2);          % Choose two HS Loc before FOG onset
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).duration      = LF_events(idxGC3-2) -LF_events(idxGC3-3); %Compute Difference
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).foot          = "Left";
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).DD_STN        = DD_STN;
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).distance_FoG  = Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).distance_FoG + Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).duration;
                        end
                        clear foot 

                        
                    elseif Subjects.(names{k}).Baseline_Power.STN_dominance == "Left"; foot = "Right";
                        
                       %Find Right Foot Heelstrikes occurring before freezeonset
                        [minDis,idxGC3] = min( abs( RF_events-freeze_start));

                        %GC3
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).start             = RF_events(idxGC3-1);          % Choose the HS Loc before FOG onset
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).end               = RF_events(idxGC3);            % Start with FOG Onset
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).duration          = RF_events(idxGC3) - RF_events(idxGC3-1); %Compute Difference
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).foot              = "Right";
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).DD_STN            = DD_STN;
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).distance_FoG      = Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).duration + minDis;  
                                              
                        %GC2
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).start             = RF_events(idxGC3-2);          % Choose the HS that occurs before the end
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).end               = RF_events(idxGC3-1);          % Choose one HS Loc before FOG onset
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).duration          = RF_events(idxGC3-1) - RF_events(idxGC3-2); %Compute Difference
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).foot              = "Right";  
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).DD_STN            = DD_STN;
                        Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).distance_FoG      = Pre_FOG.(names{k}).(task{m})(i).Pre_GC(1).distance_FoG + Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).duration;
                                             
                        %GC3
                        if idxGC3 > 3
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).start         = RF_events(idxGC3-3);          % Choose the HS that occurs before the end
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).end           = RF_events(idxGC3-2);          % Choose two HS Loc before FOG onset
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).duration      = RF_events(idxGC3-2) - RF_events(idxGC3-3); %Compute Difference
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).foot          = "Right";
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).DD_STN        = DD_STN;
                            Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).distance_FoG  = Pre_FOG.(names{k}).(task{m})(i).Pre_GC(2).distance_FoG + Pre_FOG.(names{k}).(task{m})(i).Pre_GC(3).duration;
                        end
           
                        clear foot

                    else foot = "Error";
                    end   

                    clear LF_events RF_events freeze_start  idxGC3 DD_STN
                end
    end
end


%Check if any gait cycle durations are "off-limit"
for k = 1:length(names)
    for m = 1:length(task)
        if  isfield(Pre_FOG.(names{k}), task(m)) == 0; continue; end
            for i = 1:length(Pre_FOG.(names{k}).(task{m}))
                index_del = [];
                for t = 1:length(Pre_FOG.(names{k}).(task{m})(i).Pre_GC)
                    if Pre_FOG.(names{k}).(task{m})(i).Pre_GC(t).duration > 2.5                                     % If Gaitcycle lasts >2.5s, delete
                        index_del(length(index_del)+1,1) = t; 
                    end
                end
                Pre_FOG.(names{k}).(task{m})(i).Pre_GC(index_del:end) = [];
                index_del = [];
                for t = 1:length(Pre_FOG.(names{k}).(task{m})(i).Pre_GC)
                   if Pre_FOG.(names{k}).(task{m})(i).Pre_GC(t).distance_FoG > 3                                    % If GaitCycle is >3s away from FOG, delete
                        index_del(length(index_del)+1,1) = t;
                    end
                end
                Pre_FOG.(names{k}).(task{m})(i).Pre_GC(index_del:end) = [];
            end
    end
end

%Clear Files that have no content
idx = find(cellfun(@isempty,{Pre_FOG.(names{k}).(task{m}).Pre_GC}));  Pre_FOG.(names{k}).(task{m})(idx) = []; clear idx
clear i index_del k m t index minDis datafile


%Extract Time Frequency Data
pre_names   = fieldnames(Pre_FOG);

for k = 1:length(pre_names)
    for m = 1:length(task)
        if isfield(Pre_FOG.(pre_names{k}),task(m)) == 0; continue; end

        for i = 1:length(Pre_FOG.(pre_names{k}).(task{m}))
            for t = 1:length(Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC)

                if Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(1).foot == "Right"
                    IMU_file            = rad2deg(Subjects.(pre_names{k}).(task{m}).Gyroscope_RF(:,2))';
                    LFP_file            = Subjects.(pre_names{k}).(task{m}).L_wt;       
                    baseline_standing   = Subjects.(pre_names{k}).Baseline_Power.baseline_pwr_L;                    % Find corresponding Standing Baseline
                elseif Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(1).foot == "Left"
                    IMU_file            = rad2deg(Subjects.(pre_names{k}).(task{m}).Gyroscope_LF(:,2))';
                    LFP_file = Subjects.(pre_names{k}).(task{m}).R_wt;                  
                    baseline_standing   = Subjects.(pre_names{k}).Baseline_Power.baseline_pwr_R;                    % Find corresponding Standing Baseline
                end


            xstart  = single(Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).start * fs);
            xend    = single(Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).end * fs);
             
            %Basline Standing [unfiltered, filtered]
            Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).baseline_stand_org = baseline_standing';
            sumFD       = sum(Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).baseline_stand_org(:,[10:33, 37:48, 52:90])); 
            Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).baseline_pwr_stand = baseline_standing ./ sumFD;

            %Frequency Domain [unfiltered]
            Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).frequency_org = mean(LFP_file(:, [xstart:xend]),2)';

            %Frequency Domain [filtered] - %excluding low frequencies (up to 10 Hz) and other frequencies with possible technical artifact contamination related to the sensing equipment (33–37 Hz, 48–52 Hz, 90+ Hz)
            sum_FD      = sum(Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).frequency_org(:,[10:33, 37:48, 52:90])); 
            Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).frequency_domain = (Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).frequency_org ./ sum_FD);
         
            %Time-Frequency Domain [original]
            Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).wt_org = LFP_file(:, [xstart:xend]);

            %IMU-SIGNAL [original]
            Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).IMU_signal = IMU_file(:, [xstart:xend]);

            %Resample IMU_data to same length (e.g. 1000 datapoints)
            pp = [flip(Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).IMU_signal) Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).IMU_signal flip(Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).IMU_signal)]; 
            qq = resample(pp,3000,length(pp));
            Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).IMU_signal = qq(:,1001:2000);
      

            %Resample TF-Data to same length (e.g. 1000 datapoints)
            for h = 1:height(Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).wt_org)
                   pp = [flip(Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).wt_org(h,:)) Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).wt_org(h,:) flip(Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).wt_org(h,:))]; 
                   qq = resample(pp,3000,length(pp));
                   Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).wt_rs(h,:) = qq(:,1001:2000);
            end

            %Time-Frequency Domain [Standing Baseline subtracted]
            Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).wt_standing = ((Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC(t).wt_rs - baseline_standing) ./ baseline_standing) * 100;
            end

            clear h i input LFP_file  p pp qq t xend xstart sum_FD sumFD baseline_standing  
        end
    end
end

clear k m q A ans index minDis task IMU_file


% Average over all gaitcycles within a given pre-freeze event
task        = {'Walk'; 'WalkWS'; 'WalkINT'; 'WalkINT_new'};
field       = {'Walking_Freeze'};
labels      = {'wt_rs'; 'wt_standing'; 'IMU_signal'};
All_FOGs    = [];

pre_names = fieldnames(Pre_FOG);

for k = 1:length(pre_names)
    for m = 1:length(task)
         if isfield(Pre_FOG.(pre_names{k}),task(m)) == 0; continue; end
    
        %Average for each Freezing Episode
        for i = 1:length(Pre_FOG.(pre_names{k}).(task{m}))
            for q = 1:length(labels)
                A = cat(3, Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC.(labels{q}));
                Pre_FOG.(pre_names{k}).(task{m})(i).(labels{q}) = mean(A,3);
            end

            Pre_FOG.(pre_names{k}).(task{m})(i).frequency_domain    = mean(cell2mat({Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC.frequency_domain}'),1,"omitnan");
            Pre_FOG.(pre_names{k}).(task{m})(i).baseline_stand_org  = mean(cell2mat({Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC.baseline_stand_org}'),1,"omitnan");            
            Pre_FOG.(pre_names{k}).(task{m})(i).baseline_stand      = mean(cell2mat({Pre_FOG.(pre_names{k}).(task{m})(i).Pre_GC.baseline_pwr_stand}),2,"omitnan")';
            Pre_FOG.(pre_names{k}).(task{m})(i).name                = (pre_names{k});
        end 
    end
     
    for t = 1:length(task)
        if isfield(Pre_FOG.(pre_names{k}), task(t))
            All_FOGs =   cat(2,All_FOGs, Pre_FOG.(pre_names{k}).(task{t})); 
        end
    end
end

clear A 

Pre_Freezing_Files.frequencies         = Subjects.(names{1}).(task{1}).f;
Pre_Freezing_Files.Pre_Fogs            = All_FOGs;

clear lables idx idx_del index_del k m nfrq q time field A i  c  C baseline_standing condition_labels datafile labels task num_freq num_time store_file store_temp pre_names 

%SAVE DATA
%save([subjectdata.generalpath filesep  'Pre_Freezing_Files.mat'], 'Pre_Freezing_Files', '-mat')
% *********************** END OF SCRIPT ************************************************************************************************************************
