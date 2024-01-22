# Instructions

## Access to Data - Public Data Repository
To access and download data, click on the following link that will guide you to the Mendeley Data Repository. 
The file is called "SenseFOG-main".

Klocke, Philipp; Loeffler, Moritz; Weiss, Daniel (2024), 
“Pathological subthalamic activation and synchronization reflect antagonistic muscle activation failure and freezing of gait in Parkinson’s disease”, Mendeley Data, V1, doi: 10.17632/c9ckcvjxc7.1

- [ ] https://data.mendeley.com/datasets/c9ckcvjxc7/1      

## Technical Prerequisites to access the data
For analysis, Matlab version 2022a was used. 
The following toolboxes were also acquired and will be needed to run the preprocessing and analysis scripts:
- [ ] Fieldtrip (version 1.0.1.0) (https://www.fieldtriptoolbox.org) 
- [ ] Matlab Wavelet Toolbox (version 6.1)
- [ ] Matlab Signal Processing Toolbox (version 9.0)

The following outline represents the order used for preprocessing the data:

## 1.0 Preprocessing
>> Each matlab script requires the specification of the matlab search path so that the script can draw from raw or preprocessed data.
>> As such, a pop-up window will appear at the beginning of most scripts where users can define the search path: 
Example: /Downloads/SenseFog-main/sub-01/ses-walk

>> Due to ECG-artefacts and their subsequenty removal, all LFP files of subject 10 (ses-sitting, ses-standing, ses-walk, ses-walkws and ses-walkint) have been pre-processed already and are stored under SenseFog-main/sub-10/ses-XX/ieeg. JSON (LFP) files of PD10 therefore should not be imported and (re-)processed to avoid files being overwritten. The original JSON files can still be accessed. 


| Step | Preprocessing          |Comment                                                                                             |
|-----:| -----------------------|----------------------------------------------------------------------------------------------------|
| 1.1    | "sub-XX-datafile.m"  | Each subject has a dedicated datafile with hardcoded timepoints for walking, stops and FoG. Run this script only once for each subject.|
| 1.2    | "Import_BVA.m"       | Import raw EEG/EMG files. This script needs to be run for each subject and each file separately.   |
| 1.3    | "Import_JSON.m"      | Import raw JSON (LFP) files. This script needs to be run for each subject and each file separately.|
| 1.4    | "Import_HDF.m"       | Import raw HDF (IMU) files. This script needs to be run for each subject and each file separately. |
| 1.5    | "Data_Alignment.m"   | Based on pre-specified timepoints in the sub-XX-datafile.m, this script will align IMU, LFP and EEG timeseries based on the stimulation artefact set at the beginning of each recording                                                  |
| 1.6    | "Sub_GrandActivity_Log.m" | This script will create a sub-XX.dataevents.mat file which concatenates and stores all IMU, LFP and EEG/EMG information of all gait tasks under the sub-XX folder. Run this script for all gait tasks (ses-walk, ses-walkws, ses-walkint where available) that are relevant for each subject. Kinematic data (heelstrike, toe-off, etc.) have been processed for each subject and task already and are included in the SenseFog-main file.|



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
