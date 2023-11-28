# SenseFOG README

## Details related to access to the data
- [ ] Data user agreement

## Contact Person: 
For additional queries, contact: 
      Philipp Klocke;  philipp.klocke@uni-tuebingen.de
      Moritz Loeffler; moritz.loeffler@uni-tuebingen.de

## Overview

- [ ] Project name: SenseFOG (study start date: 16.09.2020)
- [ ] Years of subject and data recruitment: 2020-2023
- [ ] Overall study goal:
      We set out to study the neuronal and neuromuscular basis of freezing of gait (FoG) events in Parkinson's disease (PD) patients while walking by taking advantage
      of subthalamic sensing technology and ambulatory EMG recordings. To differentiate these from events of voluntary stopping, we also recoding stopping events in PD patients.  


## Methods
### Subjects
12 patients with idiopathi Parkinson's disease who had previously undergone bilateral STN-DBS surgery and 
were implanted with the Medtronic Percept impulse generator were studied.

Inclusion Criteria:
- [ ] Patients aged 18-85 years
- [ ]	Patients diagnosed with idiopathic PD according to the UK Parkinson Disease Brain Bank criteria
- [ ] Patients must be implanted with bilateral DBS whose DBS-electrodes conform to Medtronic lead models 3389, 3387 or Sensight™ and who currently are implanted with the Percept™ impulse generator
- [ ] Electrode contacts reside within the STN
- [ ] Implantation of DBS electrodes occurred no prior than 6 months before enrolment

Exclusion Criteria:
- [ ]	Competing orthopaedic or neurological conditions rendering patients unable to walk unaided
- [ ]	Marked cognitive impairment (Montreal Cognitive assessment [MoCA]) < 17 points
- [ ]	Patients with current moderate to severe depression (Beck Depression Inventory [BDI]) ≥ 24 points
- [ ] Patients with current psychotic symptoms and/or suicidality

### Apparatus
To record local field potentials (LFP), sensing abilities of the Medtronic Percept were used. Data was recorded and saved in a .json file.
Additionally, we recorded EEG/EMG data (Brain products, MES Electronics, Gilching, Germany), data being saved in a .bva file. 
Lastly, gait kinematics were recorded using three lightweight inertial kinematic sensors (Opal, APDM Inc., Portland, OR USA) attached to both left and right ankles and lumbar spine (L5). All kinematic data were exported in hierarchical data format (HDF) and saved in a .h5 file. 
All experimental sessions were videotapeed for later offline-analysis. 

### Task organization
Patient first underwent baseline clinical assessment after overnight withdrawal of all dopaminergic medication (>12 hours). 
Recording sessions were the following: 
- [ ] Sitting (eyes open): 120 seconds
- [ ] Standing (eyes open): 120 seconds
- [ ] Walking through a naroow corridor as mono task (approx. 240 seconds duration)
- [ ] Walking being unterrupted by internally generated voluntary stops (approx. 240 seconds duration)
- [ ] Walking under dual task conditions (serial subtraction task) (approx. 240 seconds duration)
All recordings took place in Med OFF and Stim OFF. 


### Task details
Based on the provided videofiles and kinematic data, we have created start and end time points for the following events:
- [ ] Walking (straight walking, no freezing of gait detected)
- [ ] Turning (start and and end time points)
- [ ] Self-Selected Stops
- [ ] Freezing of Gait [Walking]
- [ ] Freezing of Gait [Turning]
- [ ] Freezing of Gait [Walk Initiation]

For walking, we included time series both while walking straight ahead as mono task and walking with interference (dual-task).
We rejected all time segments including turning, FoG, or stops. Further, we excluded a three-second time segment from the transition periods 
(Pre-FoG or Pre-Stop) and the first step before and after a turn to exclude acceleration and deceleration of walking. 

In the current work, we restricted analyes to FoG occuring during walking, thereby excluding FoG during turning or at gait initiation. 
We segmented FoG-events beginnign with the last regular heelstrike contralateral to the leg displaying freezing and ending with the first heel strike
after a FoG-event when regular walking was resumed. Only FoG episodes lasting ≥1000 ms were selected.

Self-Selected Stops were identified in the video recordings and segmented based on the kinematic time series. 
Their start was defined as the time point of the heel strike of the leg initiating stance phase before full termination of walking activity. 
Toe-off of the left resuming walking-activity was used to define the offset of a voluntary stop. Only stops lasting ≥1000 ms were included. 

To study the transition phases from walking to FoG (termed Pre-FoG) or voluntary stops (termed Pre-Stop), we chose the last three gait cycles before each event. In case of slow walking, gait cycles occurring more than 3000 ms before FoG/Stop onset were excluded. 

### Computation of Gait Cycle
During offline analysis, gait cycles were identified using the accelerometer signal in the anterior-posterior plane (x-axis) and the gyroscope signal in the medial-lateral direction (y-axis) with angular velocity expressed in the sagittal plane. We characterized each gait cycle by identifying the midswing, defined by the gyroscope’s peak-angular velocity exceeding a threshold of 50°/s. Using a time window of 500 ms before and after each midswing, the preceding toe-offs and the succeeding heel strikes were identified. Toe off was marked as the minimum acceleration in the anterior-posterior plane and heel strike as the minimum angular velocity in the sagittal plane before maximum anterior-posterior acceleration, respectively. A 100% full stride encompassed the timespan between two consecutive heel strikes of the same leg. Gait cycles exceeding a duration of > 2.5 s were discarded. Temporal and spatial gait parameters from these regular gait cycles (referred to as “walking” in the following”) were computed for each subject and gait condition.

### Assessment of disease laterality
We obtained further clinical characteristics by recording motor symptoms (MDS-UPDRS part III in medication off / stimulation off and medication on / stimulation on) including evaluation of the MDS-UPDRS III hemibody scores to determine disease-lateralization (calculated as sum of the rigidity (item 3.3), akinesia (items 3.4-3.8), and tremor (items 3.15-3.17) scores for one side, ranging from 0 to 44). The hemibody ranking highest on the MDS-UPDRS sum score was chosen as disease dominant side and the contralateral STN chosen as disease dominant STN.

### Additional data acquired
A brief indication of data other than the
imaging data that was acquired as part of this experiment. In addition
to data from other modalities and behavioral data, this might include
questionnaires and surveys, swabs, and clinical information. Indicate
the availability of this data.

This is especially relevant if the data are not included in a `phenotype` folder.
https://bids-specification.readthedocs.io/en/stable/03-modality-agnostic-files.html#phenotypic-and-assessment-data

### Experimental location
Recordings took place on the premises of the University Hospital Medical Center Tübingen, Department of Neurology.
The walking took place in a 15 x 2.5 m hallway. Two chairs narrowing the corridor were positioned (1 m width) to help provoke FoG events under laboratory conditions.

### Ethics
The study was approved by the Ethics Committee of Tübingen University (166/2020BO1), and all patients provided written informed consent.


### Other

