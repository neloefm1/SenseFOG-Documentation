%%=====  Data_Alignment.m ========================================%

%Date: November 2023
%Original author(s): Philipp Klocke, Moritz Löffler

%This script will help align both EEG and LFP and IMU data according to a mutual
%beginning. As such, the M1 sequence will be traced in the EEG signal which is the
%mutual timepoint where IMU and EEG data are synchronized. We will first cut 
%the overlapping EEG signal.In a second step we will manually identify the 
%stimulation artefact which is set at the beginning of each recording. The 
%exact time point of the stimulation artefact that will be used to align the data and 
%the information is stored in a sub-XX-datafile.m script. The files will be aligned
%according to the artefact and overlapping traces cut out. The data will be stored in a pre-specified
%filepath.
%===================================================================%

%Load EEG and LFP data and IMU data by specifying subject and session of interes
subjectdata.generalpath                 = uigetdir;                                                         % Example: SenseFOG-main/sub-XX/ses-standing
subjectdata.fs_eeg                      = 1000;                                                             % EEG sampling rate is 1000 Hz per default
cd(subjectdata.generalpath)
filename                                = extractAfter(subjectdata.generalpath,"-main/");                   % Create the specified filename
filename                                = extractBefore(filename,"/ses-");                                  % Create the specified taskname
taskname                                = extractAfter(subjectdata.generalpath,"/ses-");                    % Create the specified taskname
taskname                                = append("ses-", taskname);                                         % Create the specified taskname

fullname = append(subjectdata.generalpath, "/ieeg/",filename, "-", taskname, "_raw.mat"); load(fullname)    % LOAD JSON [LFP] FILE
fullname = append(subjectdata.generalpath, "/eeg/",filename, "-", taskname, "_raw.mat"); load(fullname)     % LOAD BVA [EEG] FILE
fullname = append(subjectdata.generalpath, "/motion/",filename, "-", taskname, "_raw.mat"); load(fullname)  % LOAD HDF [IMU] FILE


%=====LFP DATA =========================================================================
%Specify time range for display using min and max values
%Make sure the Stimulation artefact is present and that the artefact is aligned in both LFP traces 

minx     = 0; %arbitrary value
maxx     = 40000; %arbitrary value

clc
figure(1);
    ax3 = subplot(2,1,1);
    plot(1:length(LFP.interp_LFP_right),LFP.interp_LFP_right, 'LineWidth',1,'Color','r')
    xlim([minx maxx])
    xlabel('Samples')
    ylabel('Amplitude [a.u.]')
    legend('Right LFP')
    

    ax4 = subplot(2,1,2);
    plot(1:length(LFP.interp_LFP_left),LFP.interp_LFP_left, 'LineWidth',1,'Color','b')
    xlim([minx maxx])
    xlabel('Samples')
    ylabel('Amplitude [a.u.]')
    legend('Left LFP')
    set(gcf,'color','white')
    linkaxes([ax3,ax4],'xy');
    sgtitle({'LFP Datasets'; sprintf('Trial: %s ', EEG_File.eeg)})
    clc
    
%=== CLEAN-UP ====
clear ans ax1 ax2 ax3 ax4 minx maxx

%==== EEG DATA =========================================================================
%Finding the M1-Sequence of the IMU Dataset that appears in the EEG dataset
%The M1 Sequence represents the start of IMU recording in the EEG dataset
M1                      = struct2table(EEG_File.vmrk);
index_M1                = find(strcmp('M  1',(M1{:,2}))); %Finding the index of where M  1 appears
sample_M1               = table2array(M1(index_M1,"sample"));


%Plot EEG Raw Data (single channels):
figure(2);
    plot(1:length(EEG_File.dat.dataset), EEG_File.dat.dataset(end,:),'-v','MarkerIndices',[sample_M1(1)],'MarkerFaceColor','red')
    text(sample_M1(1,1),1000,'M1')
    xlabel('Samples'); ylabel('arbitrary unit')
    xline(sample_M1(1), '--r', 'LineWidth',2)
    xlim([0 10000])
    set(gcf,'color','white')
    title('Finding M1 Sequence')

%=== CLEAN-UP ====
clear numTrial index_M1 M1 


%==== ALIGNING EEG AND IMU DATA =============================================================================
%Next, we will align EEG and IMU data accoring to the M1-Sequence
EEG_pre_signal          = EEG_File.dat.dataset(:,(sample_M1(1,1):end));
EEG_File.eegtime_new    = (1/subjectdata.fs_eeg):(1/subjectdata.fs_eeg):(length(EEG_pre_signal)/subjectdata.fs_eeg);


% === Visualizing NOT-ALIGNED signals for demonstration purposes ===
figure(3)
    ax1 = subplot(3,1,1)
    plot(1:length(LFP.interp_LFP_right),LFP.interp_LFP_right, 'LineWidth',1,'Color','r')
    xlabel('Samples'); xlim([0 20000])
    title('Right LFP Signal')

    ax2 = subplot(3,1,2)
    plot(1:length(EEG_pre_signal), EEG_pre_signal(end,:))
    xlabel('Samples')
    xlim([0 20000]); ylim([-100 5000])
    title('EEG Data - IPG')
    
    ax3 = subplot(3,1,3)
    plot(1:length(EEG_pre_signal), EEG_pre_signal(14,:))
    xlim([0 20000])
    title('EEG Data - C4')
    linkaxes([ax2, ax3],'x')
    set(gcf,'color','white')
    sgtitle('Non-Aligned Datasets')













