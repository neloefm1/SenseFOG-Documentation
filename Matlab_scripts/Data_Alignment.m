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
