# Instructions

## Access to Data - Public Data Repository
To access and download data, click on the following link that will guide you to the Mendeley Data Repository. 
The file is called "SenseFOG-main".

Klocke, Philipp; Loeffler, Moritz; Weiss, Daniel (2024), 
“Pathological subthalamic activation and synchronization reflect antagonistic muscle activation failure and freezing of gait in Parkinson’s disease”, Mendeley Data, V1, doi: 10.17632/c9ckcvjxc7.1

- [ ] https://data.mendeley.com/datasets/c9ckcvjxc7/1 (DOI: 10.17632/c9ckcvjxc7.1)     

## Technical Prerequisites to access the data
For analysis, Matlab version 2022a was used. 
The following toolboxes were also acquired and will be needed to run the preprocessing and analysis scripts:
- [ ] Fieldtrip (version 1.0.1.0) (https://www.fieldtriptoolbox.org) 
- [ ] Matlab Wavelet Toolbox (version 6.1)
- [ ] Matlab Signal Processing Toolbox (version 9.0)

The following outline represents the order used for preprocessing the data:

## 1.0 Preprocessing
- [ ] Each matlab script requires the specification of the matlab search path so that the script can draw from raw or preprocessed data. As such, a pop-up window will appear at the beginning of most scripts where users can define the search path: 
Example: /Downloads/SenseFog-main/sub-01/ses-walk

<br />

>> Due to ECG-artefacts and their subsequenty removal, all LFP files of subject 10 (ses-sitting, ses-standing, ses-walk, ses-walkws and ses-walkint) have been pre-processed already and are stored under SenseFog-main/sub-10/ses-XX/ieeg. JSON (LFP) files of PD10 therefore should not be imported and (re-)processed to avoid files being overwritten. The original JSON files can still be accessed.

>> Owing to technical reasons, LFP files for sub-11/ses-sitting (sub-11-ses-sitting_lfpalg.mat) have already been created and do not need to imported/preprocessed.

>> Owing to technical reasons, LFP files for sub-17/ses-sitting (sub-17-ses-sitting_lfpalg.mat) have already been created and do not need to imported/preprocessed.

<br />
<br />

| Step | Preprocessing          |Comment                                                                                             |
|-----:| ---------------------------|------------------------------------------------------------------------------------------------|
| 1.1    | "sub-XX-datafile.m"  | Each subject has a dedicated datafile with hardcoded timepoints for walking, stops and FoG. Run this script only once for each subject.|
| 1.2    | "Import_BVA.m"       | Import raw EEG/EMG files. This script needs to be run for each subject and each file separately.   |
| 1.3    | "Import_JSON.m"      | Import raw JSON (LFP) files. This script needs to be run for each subject and each file separately.|
| 1.4    | "Import_HDF.m"       | Import raw HDF (IMU) files. This script needs to be run for each subject and each file separately. |
| 1.5    | "Data_Alignment.m"   | Based on pre-specified timepoints in the sub-XX-datafile.m, this script will align IMU, LFP and EEG timeseries based on the stimulation artefact set at the beginning of each recording                                                  |
| 1.6    | "Sub_GrandActivity_Log.m" | This script will create a sub-XX.dataevents.mat file which concatenates and stores all IMU, LFP and EEG/EMG information of all gait tasks under the sub-XX folder. Run this script for all gait tasks (ses-walk, ses-walkws, ses-walkint where available) that are relevant for each subject. Kinematic data (heelstrike, toe-off, etc.) have been processed for each subject and task already and are included in the SenseFog-main file.|

<br />
<br />

## 2.0 Data Analysis
| Step | Analysis              |Comment                                                                                         |
|-----:| ---------------------------|------------------------------------------------------------------------------------------------|
| 2.1.1   | "Baseline_Power.m"      | Computes the average LFP power (Continous morlet wavelet analysis) based on the standing dataset for each subject. The average power will later be used for baseline correction. This script requires that matlab script 1.6 "Sub_GrandActivity_Log.m" has been run in the steps prior to this one producing a sub-XX-dataevents.mat file for each subject. |
| 2.1.2   | "Select_Sitting_power.m"  | Computes the average power (Continous morlet wavelet analysis) based on the sitting dataset for each subject. This script requires that matlab script 1.6 "Sub_GrandActivity_Log.m" has been run in the steps prior to this one producing a sub-XX-dataevents.mat file for each subject..|
| 2.1.3   | "Baseline_Coherence.m"  | Computes the average magnitude squared coherence based on the standing LFP and EMG dataset for each subject. The average magnitude squared coherence will later be used for baseline correction when computing the coherence files. This script requires that matlab script 1.6 "Sub_GrandActivity_Log.m" has been run in the steps prior to this one producing a sub-XX-dataevents.mat file for each subject.. |

<br />
<br />

### 2.2 Power Analyses
| Step | Analysis              |Comment                                                                                         |
|-----:| ---------------------------|------------------------------------------------------------------------------------------------|
| 2.2.1   | "Select_Walking_power.m"    | Based on kinematic timepoints for heelstrikes, compute time-frequency spectra (continous morlet-wavelet transformation) for all gait cycles for each subject and tasks. The current analysis focuses on the disease-dominant STN. | 
| 2.2.2   | "Select_Stop_power.m"       | Based on kinematic/pre-specified timepoints, select epochs for Stopping using continous morlet-wavelet transformation. | 
| 2.2.3   | "Select_Freeze_power.m"     | Based on kinematic/pre-specified timepoints, select epochs for freezing using continous morlet-wavelet transformation.| 
| 2.2.4   | "Select_Pre_Stop_power.m"   | Select up to three gait cycles before onset of a Stop and compute time-frequency analysis on this epoch. | 
| 2.2.5   | "Select_Pre_Freeze_power.m" | Select up to three gait cycles before onset of Freezing and compute time-frequency analysis on this epoch. |

<br />
<br />

### 2.3 Coherence Analyses
| Step | Analysis              |Comment                                                                                         |
|-----:| ---------------------------|------------------------------------------------------------------------------------------------|
| 2.3.1   | "STN_EMG_Coherence_Walking.m"   | Based on the corresponding EMG and LFP data, magnitude squared coherence will be computed for each gait cycle of each subject and task. Only gait cycles corresponding to the disease dominant STN will be chosen. | 
| 2.3.2   | "STN_EMG_Coherence_Stop.m"       | Based on the corresponding EMG and LFP data, magnitude squared coherence will be computed for a selected epoch of Stopping. Only epochs corresponding to the disease dominant STN will be chosen. | 
| 2.3.3   | "STN_EMG_Coherence_Freeze.m"     | Based on the corresponding EMG and LFP data, magnitude squared coherence will be computed for a selected epoch of Freeuing. Only epochs corresponding to the disease dominant STN will be chosen. | 
| 2.3.4   | "STN_EMG_Coherence_Pre_Stop.m"   | Selects timepoints of up to three gait cycles before onset of a stop and computes the magnitude squared coherence for these gait cycles. | 
| 2.3.5   | "STN_EMG_Coherence_Pre_Freeze.m" | Selects timepoints of up to three gait cycles before onset of freezing and computes the magnitude squared coherence for these gait cycles. |  

<br />
<br />


### 3.0 Table & Figures
| Step | Table&Figures              |Comment                                                                                         |
|-----:| -------------------------------|---------------------------------------------------------------------------------------------|
| 3.1   | "Figure_1.m" | Creates the figure as depicted in the manuscript. |
| 3.2   | "Figure_2.m" | Creates the figure as depicted in the manuscript. |
| 3.3   | "Figure_3.m" | Creates the figure as depicted in the manuscript. |
| 3.4   | "Figure_4.m" | Creates the figure as depicted in the manuscript. |
| 3.5   | "Figure_5.m" | Creates the figure as depicted in the manuscript. |
| 3.6   | "Table_1.m"  | Creates the table as depicted in the manuscript.|
|_______|________________________________|__________________________________________________________________________________________|
