# Instructions

## Access to Data - Public Data Repository
To access and download data, click on the following link that will guide you to the Mendeley Data Repository. 
The file is called "SenseFOG-main".

Klocke, Philipp; Loeffler, Moritz; Weiss, Daniel (2023), 
“Pathological subthalamic activation and synchronization reflect antagonistic muscle activation failure and freezing of gait in Parkinson’s disease”, 
Mendeley Data, V1, doi: 10.17632/c9ckcvjxc7.1

- [ ] https://data.mendeley.com/datasets/c9ckcvjxc7/1      

## Technical Prerequisites to access the data
For analysis, Matlab version 2022a was used. 
The following toolboxes were also acquired and will be needed to run the preprocessing and analysis scripts:
- [ ] Fieldtrip (version 1.0.1.0) (https://www.fieldtriptoolbox.org) 
- [ ] Matlab Wavelet Toolbox (version 6.1)
- [ ] Matlab Signal Processing Toolbox (version 9.0)



The following table represents the order used for preprocessing the data:

## 1.0 Preprocessing
Explain here what is to be expected to be done, interations of code and expected output of the codes.
- [ ]  1.1 "sub-XX-datafile"                   --  Run the Subject-Files > sub-XX-datafile.m for each subjects
- [ ]  1.2 "Import_BVA.m"                      --  Import raw EEG/EMG files
- [ ]  1.3 "Import_JSON.m"                     --  Import JSON (LFP) files
- [ ]  1.4 "Import_HDF.m"                      --  Import inertial motion unit (IMU) files
- [ ]  1.5 "Data_Alignment.m"                  --  Align all datasets in time using the stimulation artefact
- [ ]  1.6 "Detect_GaitEvents.m"               --  Compute gait cycles from all walking tasks
- [ ]  1.8 "Control_GaitEvents.m"              --  Adjustments to the exact timepoints of gait events are made where the algorithm was not able to 
- [ ]  1.9 "Sub_GrandActivity_Log.m"           --  Based on predefined time points, collect all activities (walking, turning, stops etc.)

## 2.0 Data Analysis
Explain here what is to be expected to be done, interations of code and expected output of the codes.
- [ ]  2.1.2 "Baseline_Power.m"                  -- Compute baseline power from standing
- [ ]  2.1.2 "Select_Sitting_power.m"            -- Computes the average power for sitting
- [ ]  2.2   "Baseline_Coherence.m"              -- Compute baseline coherence from standing

### 2.3 Power Analyses
Explain here what is to be expected to be done, interations of code and expected output of the codes.
- [ ]  2.3.1 "Select_Walking_power.m"          -- Compute power spectra for each gait cycle (Walking)
- [ ]  2.3.2 "Select_Stop_power.m"             -- Compute power spectra for self-selected stops
- [ ]  2.3.3 "Select_Freeze_power.m"           -- Compute power spectra for freezing-of-gait (during walking)
- [ ]  2.3.4 "Select_Pre_Stop_power.m"         -- Compute power spectra for pre-stop gait cycles
- [ ]  2.3.5 "Select_Pre_Freeze_power.m"       -- Compute power spectra for pre-fog gait cycles

### 2.4 Coherence Analyses
Explain here what is to be expected to be done, interations of code and expected output of the codes.
- [ ]  2.4.1 "STN_EMG_Coherence_Walking.m"    -- Compute subthalamo-muscular coherence spectra for each gait cycle (Walking)
- [ ]  2.4.2 "STN_EMG_Coherence_Stop.m"       -- Compute subthalamo-muscular coherence for self-selected stops
- [ ]  2.4.3 "STN_EMG_Coherence_Freeze.m"     -- Compute subthalamo-muscular coherence for freezing-of-gait (during walking)
- [ ]  2.4.4 "STN_EMG_Coherence_Pre_Stop.m"   -- Compute subthalamo-muscular coherence for pre-stop gait cycles
- [ ]  2.4.5 "STN_EMG_Coherence_Pre_Freeze.m" -- Compute subthalamo-muscular coherence for pre-fog gait cycles



## TEMPORARY NEED FIXING
- for future, need to take off right and left LFP from data analyiss, also IMU cutoff...
- check if decelleration and acceleration, as well as gait cycles before and after turn are excluded?
- On Mendely, PD18 Walk JSON needs to be updated
- Provide detailed explanation of the code and the associated output
- Update the titles of the repository on GitHub and Mendely Data
- For PD05, only use WalkWS and leave out all other files from PD05 (auf USB rausgenommen)
- REMOVE Data from Subj 14 Walk as not usable (auf USB rausgenommen)
- PD18 WALKWS Rausnehmen, da Kameraversatz (auf USB rausgenommen)
- PD19 WALKINT Datenversatz, rausnehmen? (auf USB rausgenommen)
- in Subjectfiles am Anfang die rausgenommenen Subfiles streichen (auf GitHub bereits gemacht, aktuellen subjectfiles nun komplett auf GitHub)
- Auf USB file/Mendeley DR sollten die subjectfiles rausgenomemn werden ..
- Sitting LFP Files für Subject 11 und 17 müssen noch ins DataRepository aufgenommen werden, da diese fehlen in den Rohdaten, in GitHub sollte hierzu eine erklärung folgen!
- Take out all WalkINT Subject 15 Walking Files, Freezes
- Vermutlich EEG Aligned files zusammen mit den LFPs von SUb10 schon in datarepository machen und in GitHub darauf verweisen

