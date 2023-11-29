# Instructions

The following table represents the order used for preprocessing the data:

## 1.0 Preprocessing
- [ ]  1.1 "sub-XX-datafile"       --  Import subject file
- [ ]  1.2 "Import_BVA.m"          --  Import raw EEG/EMG files
- [ ]  1.3 "Import_JSON.m"         --  Import JSON (LFP) files
- [ ]  1.4 "Import_HDF.m"          --  Import inertial motion unit (IMU) files
- [ ]  1.5 "Data_Alignment.m"      --  Align all datasets in time using the stimulation artefact
- [ ]  1.6 "Detect_GaitEvents.m"   --  Compute gait cycles from all walking tasks


## 2.0 Data Analysis
- [ ]  2.1 "Baseline_Power.m"      -- Compute baseline power from standing
- [ ]  2.2 "Baseline_Coherence.m"  -- Compute baseline coherence from standing


## TEMPORARY NEED FIXING
- need to address the need for fieldtrip toolbox, direct users where to get it, current version?
- fir future, need to take off right and left LFP from data analyiss, also IMU cutoff...
