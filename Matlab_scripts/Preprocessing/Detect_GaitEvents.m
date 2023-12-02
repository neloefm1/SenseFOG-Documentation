%%=====  Detect_GaitEvents.m ========================================%

%Date: November 2023
%Original author(s): Philipp Klocke, Moritz Löffler

%The script will compute full gait cycles based
%on accelerometer and gyroscope data for each leg. Gait cycles will be
%stored under the motion subfile for each subject individually. At this
%point, all gait cycles detected will be computed regardless of turning,
%freezing or other activity. 
%===================================================================%

%Load in the data by specifying the subject and session of interest
subjectdata.generalpath                 = uigetdir;                                                                 % Example: SenseFOG-main/sub-XX/ses-standing
cd(subjectdata.generalpath)
filename                                = extractBefore(extractAfter(subjectdata.generalpath,"-main/"),"/ses-");    % Create the specified filename
taskname                                = append("ses-",extractAfter(subjectdata.generalpath,"/ses-"));             % Create the specified taskname
subjectdata.filepath                    = extractBefore(subjectdata.generalpath, "/ses");                           % Create the specified filepath

fullname                                = append(subjectdata.generalpath, "/motion/",filename, "-", taskname, "_gaitalg.mat"); load(fullname)      % Load HDF [IMU] FILE (alligned dataset)

site     = {'Right_Foot', 'rf_events'; 'Left_Foot','lf_events'};                                                                             %1 = Right Foot; 2 = Left Foot
fs       = 1000;
for t = 1:length(site)
    
    Accelerometer = IMU_data.interp_accelerometer(t).Sensor(:,3);                                                   % Defines Accelerometer in Anterior-Posterior plane                                                                                                                    
    Gyroscope     = rad2deg(IMU_data.interp_gyroscope(t).Sensor(:,2));                                              % Defines Gyroscope in Saggital Plane and converts from rad/s to degrees/s
    IMU_time      =  IMU_data.imutime;


    %Find Midswings defined as peaks > 50° ====================================================
    [ms_pks,ms_locs] = findpeaks(-Gyroscope, IMU_time, "MinPeakHeight",50, "MinPeakDistance",0.25);

    %Find Toe-Off defined as minimum anteropr posterior acceleration before midswing
    for i = 1:length(ms_locs)-1
        
        %Once the Midswing is identified, find the Heelstrike [preliminary] in the time interval after MS as the min. value of angular velocity in the sagittal plane before the maximum anterior–posterior acceleration
        x1                          = round(ms_locs(i)*fs);
        temp_time                   = IMU_time(:,[x1:x1+750]);     
        temp_accl                   = Accelerometer([x1:x1+750],:);     
        [pks, locs]                 = findpeaks(temp_accl,temp_time,'SortStr','descend');
        locs                        = locs(1); 

        %Having found the Midswing, find the maximum anterior–posterior acceleration [after Midswing] 
        temp_time                   = IMU_time(:, [single(ms_locs(i)*fs):single(locs*fs)]); 
        temp_gyr                    = Gyroscope([(single(ms_locs(i)*fs)):single(locs*fs)],:);
        [HS_pks, HS_locs]           = findpeaks(temp_gyr,temp_time,"MinPeakHeight",mean(Gyroscope), 'SortStr','descend');
        if isempty(HS_locs) == 1;  HS_locs = locs; HS_pks = Gyroscope(single(HS_locs*fs),:); end                    %Make sure the peak is the same unit as the gyroscope 
        HS_locs_1                   = HS_locs(1); 
        HS_pks_1                    = HS_pks(1);                                                                    %Make sure sign (+/-) is right

        %Once the Midswing is identified, find the preceding Toe-OFF as minimum anterior–posterior acceleration 
        temp_time                   = IMU_time(:, [single(ms_locs(i) * fs)-500:single(ms_locs(i) * fs)-200]);
        temp_accl                   = Accelerometer([single(ms_locs(i) * fs)-500:single(ms_locs(i) * fs)-200],:); 
        [TO_pks, TO_locs]           = findpeaks(-temp_accl, temp_time,'SortStr','descend');
        TO_locs                     = TO_locs(1); 
        TO_pks                      = -TO_pks(1);                                                                   %Make sure sign (+/-) is right

        GaitEvents.(site{t,2})(i).Midswing_Loc     = ms_locs(i);
        GaitEvents.(site{t,2})(i).Midswing_Peak    = ms_pks(i);
        GaitEvents.(site{t,2})(i).Toe_Off_Loc      = TO_locs;
        GaitEvents.(site{t,2})(i).Toe_Off_Peak     = TO_pks;
        GaitEvents.(site{t,2})(i).Heelstrike_Loc   = HS_locs_1;
        GaitEvents.(site{t,2})(i).Heelstrike_Peak  = HS_pks_1;
        clear locs pks temp_time temp_accl temp_gyr HS_pks HS_locs HS_locs_1 HS_pks_1 TO_pks TO_locs x1 
    end
end

%Clean-UP
clear Accelerometer Gyroscope i ms_locs ms_pks t 

%% CONTROL GAIT PARAMETERS ========================
%Indicate Chosen Foot (t = 1 Right Foot; t = 2 Left Foot)
t             = 1; 
Accelerometer = IMU_data.interp_accelerometer(t).Sensor(:,3);                                                   % Defines Accelerometer in Anterior-Posterior plane                                                                                                                    
Gyroscope     = rad2deg(IMU_data.interp_gyroscope(t).Sensor(:,2));                                              % Defines Gyroscope in Saggital Plane and converts from rad/s to degrees/s
 

figure
ax1 = subplot(2,1,1)
    plot(IMU_time, Gyroscope, 'b-' )
    hold on 
    plot(cat(1,GaitEvents.(site{t,2}).Midswing_Loc), -cat(1,GaitEvents.(site{t,2}).Midswing_Peak), 'v','Color', 'r','MarkerFaceColor','r','MarkerEdgeColor','r')
    plot(cat(1,GaitEvents.(site{t,2}).Heelstrike_Loc),cat(1,GaitEvents.(site{t,2}).Heelstrike_Peak),'d', 'Color', 'g','MarkerFaceColor','g','MarkerEdgeColor','g')
    xline(cat(1,GaitEvents.(site{t,2}).Heelstrike_Loc),'--')
    xline(cat(1,GaitEvents.(site{t,2}).Toe_Off_Loc),'--')
    xlabel('Time [s]'); ylabel('Gyroscope')

ax2 = subplot(2,1,2)
    plot(IMU_time, Accelerometer,'-r')
    hold on 
    plot(cat(1,GaitEvents.(site{t,2}).Toe_Off_Loc),cat(1,GaitEvents.(site{t,2}).Toe_Off_Peak),'s', 'Color', 'g','MarkerFaceColor','g','MarkerEdgeColor','g')
    xline(cat(1,GaitEvents.(site{t,2}).Heelstrike_Loc),'--')
    xline(cat(1,GaitEvents.(site{t,2}).Toe_Off_Loc),'--')
    linkaxes([ax1 ax2],'x')
    xlabel('Time [s]');ylabel('Accelerometer'); xlim([5 10])
    set(gcf,'Color', 'white')
    sgtitle({sprintf('Trial: %s ', IMU_data.filename); sprintf('%s',char(site(t,1)));})
    clear p1 p2 ax1 ax2 t site

%% SAVE DATA
save([subjectdata.filepath filesep char(taskname) filesep 'motion' filesep filename '-' char(taskname) '_gaitfilt.mat'], 'GaitEvents', '-mat')
% *********************** END OF SCRIPT ************************************************************************************************************************
