# Instructions

## Access to Data - Public Data Repository
To access and download data, click on the following link that will guide you to the Mendeley Data Repository. 
The file is called "SenseFOG-main".

Klocke, Philipp; Loeffler, Moritz; Weiss, Daniel (2023), 
“Pathological subthalamic activation and synchronization reflect antagonistic muscle activation failure and freezing of gait in Parkinson’s disease”, 
Mendeley Data, V1, doi: 10.17632/c9ckcvjxc7.1

>>COPY URL to MENDELEY DATA REPOSITORY HERE<<

## Technical Prerequisites to access the data
For analysis, Matlab version 2022a was used. 
The following toolboxes were also acquired and will be needed to run the preprocessing and analysis scripts:
- [ ] Fieldtrip (version 1.0.1.0)
- [ ] Matlab Wavelet Toolbox (version 6.1)
- [ ] Matlab Signal Processing Toolbox (version 9.0)



The following table represents the order used for preprocessing the data:

## 1.0 Preprocessing
- [ ]  1.1 "sub-XX-datafile"           --  Run the Subject-Files > sub-XX-datafile.m for each subjects
- [ ]  1.2 "Import_BVA.m"              --  Import raw EEG/EMG files
- [ ]  1.3 "Import_JSON.m"             --  Import JSON (LFP) files
- [ ]  1.4 "Import_HDF.m"              --  Import inertial motion unit (IMU) files
- [ ]  1.5 "Data_Alignment.m"          --  Align all datasets in time using the stimulation artefact
- [ ]  1.6 "Detect_GaitEvents.m"       --  Compute gait cycles from all walking tasks
- [ ]  1.7 "Sub_GrandActivity_Log.m"   --  Based on predefined time points, collect all activities (walking, turning, stops etc.)


## 2.0 Data Analysis
- [ ]  2.1 "Baseline_Power.m"          -- Compute baseline power from standing
- [ ]  2.2 "Baseline_Coherence.m"      -- Compute baseline coherence from standing


## TEMPORARY NEED FIXING
- need to address the need for fieldtrip toolbox, direct users where to get it, current version?
- for future, need to take off right and left LFP from data analyiss, also IMU cutoff...
- Check PD17 Sitting
- Check WalkINT2 in scripts
