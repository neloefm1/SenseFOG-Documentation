%%=====  Demo.m ========================================%

%Date: Decemebter 2023
%Original author(s): Philipp Klocke, Moritz Loeffler

%This script will create time-frequency information based on the first 
%60 seconds of regular walking in subject 10. The script will make use of
%pre-specified time points for heelstrikes of the left and right leg furing
%walking and use these information to segment the time-frequency matrix
%(CWT) after continuous wavelet transformation. Make sure that the
%toolboxed as outlined in the README file on github have been installed
%prior to running this script. 
%===================================================================%


%Load in the data by specifying the path for the demo file listed in the %Sensefog-main file
subjectdata.generalpath                 = uigetdir;                                                                 % Example: Downloads/SenseFOG-main/Demo
cd(subjectdata.generalpath)

file                = load("sub-10-dataevents.mat"); 
LFP_Events          = file.LFP_Events.Walk; clear file

signal_R            = LFP_Events.LFP_signal_R;                      % Right STN 
signal_L            = LFP_Events.LFP_signal_L;                      % Left STN 
time                = (1/1000):(1/1000):(length(signal_R)/1000);
time_imu            = (1/1000):(1/1000):(length(LFP_Events.Gyroscope_RF)/1000);
fs                  = 1000;                                         % Sampling rate


%MORLET WAVELET TRANSFORMATION
MFF                 = 4*pi/(6+sqrt(2+6^2));                         % Morlet-Fourier-Factor
cwtstruct_R         = cwtft({signal_R,1/fs},'wavelet', 'morl','scales',1./([1:0.5:100]*MFF)); 
cwtstruct_L         = cwtft({signal_L,1/fs},'wavelet', 'morl','scales',1./([1:0.5:100]*MFF)); 
wt_R                = abs(cwtstruct_R.cfs);
wt_L                = abs(cwtstruct_L.cfs);
f                   = cwtstruct_R.frequencies;


%COMPUTE AVERAGE GAIT CYCLE (HS to HS)
GaitCycle = struct; 

%LEFT GAIT CYCLE - RIGHT STN
for i = 1:length(LFP_Events.Walking_Left_HS)
    start                           = single(abs(LFP_Events.Walking_Left_HS(i).start* fs)); 
    stop                            = single(abs(LFP_Events.Walking_Left_HS(i).end * fs));
    GaitCycle.LFP_data_R(i).GC      = wt_R(:,[start:stop]);
    GaitCycle.LFP_data_L(i).GC      = wt_L(:,[start:stop]);
    GaitCycle.LFP_rawdata_R(i).dat  = signal_R(:,[start:stop]);
    GaitCycle.IMU_data(i).LF_dat    = LFP_Events.Gyroscope_LF([start:stop],2);
    GaitCycle.IMU_data(i).RF_dat    = LFP_Events.Gyroscope_RF([start:stop],2);
end
clear i start stop MFF cwtstruct_L cwtstruct_R

%RESAMPLE Time-Frequency Information on GAITCYCLES to equal length
%To avoid edge artifacts, use a reflection method during resampling
input = {'LFP_data_R'; 'LFP_data_L'};
for t = 1:length(input)
    for i = 1:length(GaitCycle.(input{t}))
         tf = zeros(height(GaitCycle.(input{t})(i).GC),1000);
         for k = 1:height(tf)
                pp = [flip(GaitCycle.(input{t})(i).GC(k,:)) GaitCycle.(input{t})(i).GC(k,:) flip(GaitCycle.(input{t})(i).GC(k,:))];
                qq = resample(pp,3000,length(pp));
                tf(k,:) = qq(:,1001:2000);
         end
         GaitCycle.(input{t})(i).GC_rs = tf; tf = [];
    end
end
clear pp qq tf t k i 

%RESAMPLE IMU Information on GAITCYCLES to equal length
%To avoid edge artifacts, use a reflection method during resampling
input = {'RF_dat'; 'LF_dat'};
for t = 1:length(input)
    for i = 1:length(GaitCycle.IMU_data)
         tf = zeros(1,length(GaitCycle.IMU_data(i).(input{t})));
         pp = [flip(GaitCycle.IMU_data(i).(input{t})); GaitCycle.IMU_data(i).(input{t}); flip(GaitCycle.IMU_data(i).(input{t}))]';
         qq = resample(pp,3000,length(pp));
         tf = qq(:,1001:2000);
         
         filename = string((sprintf("%s_rs",char(input(t)))));
         GaitCycle.IMU_data(i).(filename) = normalize(tf); tf = [];
    end
end
clear pp qq tf t k i C filename input

%Concatenate all Gait Cycles together
GaitCycle.mean_LFP_R_GC = mean(cat(3,GaitCycle.LFP_data_R.GC_rs),3);
GaitCycle.mean_LFP_L_GC = mean(cat(3,GaitCycle.LFP_data_L.GC_rs),3);
GaitCycle.mean_IMU_L_GC = -mean(cat(3,GaitCycle.IMU_data.LF_dat_rs),3);
GaitCycle.mean_IMU_R_GC = -mean(cat(3,GaitCycle.IMU_data.RF_dat_rs),3);
GaitCycle.std_IMU_L_GC  = std(cat(1,GaitCycle.IMU_data.LF_dat_rs),1);
GaitCycle.std_IMU_R_GC  = std(cat(1,GaitCycle.IMU_data.RF_dat_rs),1);


%Subtract the mean from each TF-Matrix
mean_TF_Left    = 10*log10(GaitCycle.mean_LFP_L_GC ./ mean(GaitCycle.mean_LFP_L_GC,2));
mean_TF_Right   = 10*log10(GaitCycle.mean_LFP_R_GC ./ mean(GaitCycle.mean_LFP_R_GC,2));


%% PLOT Data
Morlets                 = [1:0.5:100]; 
idx                     = Morlets >= 2.5 & Morlets <= 100;
frex                    = Morlets(idx); 
nfrq                    = 100;
fs                      = 1000; 
time                    = linspace(0,100,1000);


figure
p1 = subplot(3,1,1)
    ax1 = plot(time, GaitCycle.mean_IMU_L_GC, "-r", "LineWidth",1.5, "DisplayName", "Left Foot Gyroscope")
    patch([time flip(time)],[(GaitCycle.mean_IMU_L_GC + GaitCycle.std_IMU_L_GC) flip(GaitCycle.mean_IMU_L_GC - GaitCycle.std_IMU_L_GC)], 'r','FaceAlpha',0.1, 'EdgeColor', 'none');
    hold on 
    ax2 = plot(time, GaitCycle.mean_IMU_R_GC, "-b", "LineWidth", 1.5, "DisplayName", "Right Foot Gyroscope")
    patch([time flip(time)],[(GaitCycle.mean_IMU_R_GC + GaitCycle.std_IMU_R_GC) flip(GaitCycle.mean_IMU_R_GC - GaitCycle.std_IMU_R_GC)], 'b','FaceAlpha',0.1, 'EdgeColor', 'none');
    set(gca,'ytick',[]); set(gca,'xtick',[]); legend([ax1 ax2], "Location", "southoutside","NumColumns",2, 'Box','off'); ylabel('Gyroscope [deg/s]')
    c = colorbar; c.Visible = "off";
    legend([ax1, ax2])
    title({sprintf('Gyroscope')},'FontWeight', 'normal')
    box off; set(gca,'xtick',[]); p1.XAxis.Visible = 'off';

p2 = subplot(3,1,2)
    contourf(time,frex,mean_TF_Right(idx,:), nfrq, 'linecolor', 'none')
    colormap(jet); caxis([-1 1]);  
    c = colorbar; c.Label.String = 'Power [dB]'; c.Limits = [-1 1];
    xline([50],'--', 'LineWidth',1.5)
    ylabel('Frequency [Hz]'); set(gca,'xtick',[])
    set(gca, 'YTick', [0:20:100]); box off; p2.XAxis.Visible = 'off';
    set(gca,'YScale','linear'); 
    set(gca,'YLim', [2.5 100])
    title({sprintf('Left Foot Gait Cycle - Right STN')},'FontWeight', 'normal')
    
p3 = subplot(3,1,3)
    contourf(time,frex,mean_TF_Left(idx,:), nfrq, 'linecolor', 'none')
    colormap(jet); caxis([-1 1]); 
    c = colorbar; c.Label.String = 'Power [dB]'; c.Limits = [-1 1]; 
    box off; 
    ylabel('Frequency [Hz]'); xlabel('Left Foot Gait Cycle [%]');
    xline([50],'--', 'LineWidth',1.5)
    set(gca, 'YTick', [0:20:100]); 
    set(gca,'YScale','linear'); 
    set(gca,'YLim', [2.5 100])
    title({sprintf('Left Foot Gait Cycle - Left STN')},'FontWeight', 'normal')
    set(gcf,'color','w');
    linkaxes([p1 p2 p3], 'x')
    sgtitle('Left Foot Gait Cycle - Subject 10')

    a = annotation('textbox',[0.03 0.76 .2 .2],'String','a ','EdgeColor','none'); a.FontSize = 18; a.FontWeight = "bold";
    b = annotation('textbox',[0.03 0.46 .2 .2],'String','b','EdgeColor','none');  b.FontSize = 18; b.FontWeight = "bold";
    c = annotation('textbox',[0.03 0.18 .2 .2],'String','c','EdgeColor','none');  c.FontSize = 18; c.FontWeight = "bold";
   
   clear a b b ax1 ax2 c frex fs time idx p1 p2 p3 nfrq Morlets 
% *********************** END OF SCRIPT ************************************************************************************************************************
