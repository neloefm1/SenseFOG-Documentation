# SenseFOG

# README

## Details related to access to the data
- [ ] Data user agreement

If the dataset requires a data user agreement, link to the relevant information.

## Contact Person: 
For additional queries, contact: Philipp Klocke; philipp.klocke@uni-tuebingen.de 


- [ ] Practical information to access the data

## Overview

- [ ] Project name: SenseFOG (study start date: XX - 31.12.2024)
- [ ] Year(s) that the project ran
- [ ] Brief overview of the tasks in the experiment
- [ ] Description of the contents of the dataset
- [ ] Independent variables
- [ ] Dependent variables
- [ ] Control variables
- [ ] Quality assessment of the data

## Methods

### Subjects
12 patients with idiopathi Parkinson's disease who had previously undergone bilateral STN-DBS surgery and 
were implanted with the Medtronic Percept impulse generator were studied.

Inclusion Criteria:
-	Patients aged 18-85 years
-	Patients diagnosed with idiopathic PD according to the UK Parkinson Disease Brain Bank criteria
-	Patients must be implanted with bilateral DBS whose DBS-electrodes conform to Medtronic lead models 3389, 3387 or Sensight™ and who currently are implanted with the Percept™ impulse generator
-	Electrode contacts reside within the STN
-	Implantation of DBS electrodes occurred no prior than 6 months before enrolment

Exclusion Criteria:
-	Competing orthopaedic or neurological conditions rendering patients unable to walk unaided
-	Marked cognitive impairment (Montreal Cognitive assessment [MoCA]) < 17 points
-	Patients with current moderate to severe depression (Beck Depression Inventory [BDI]) ≥ 24 points
-	Patients with current psychotic symptoms and/or suicidality


### Apparatus
To record local field potentials (LFP), sensing abilities of the Medtronic Percept were used. Data was recorded and saved in a .json file.
Additionally, we recorded EEG/EMG data (Brain products, MES Electronics, Gilching, Germany), data being saved in a .bva file. 
Lastly, gait kinematics were recorded using three lightweight inertial kinematic sensors (Opal, APDM Inc., Portland, OR USA) attached to both left and right ankles and lumbar spine (L5). All kinematic data were exported in hierarchical data format (HDF) and saved in a .h5 file. 
A summary of the equipment and environment setup for the
experiment. For example, was the experiment performed in a shielded room
with the subject seated in a fixed position.
All experimental sessions were videotapeed for later offline-analysis. 

### Initial setup
A summary of what setup was performed when a subject arrived.

### Task organization
Patient first underwent baseline clinical assessment after overnight withdrawal of all dopaminergic medication (>12 hours). 
Recording sessions were the following: 
  - Sitting (eyes open): 120 seconds
  - Standing (eyes open): 120 seconds
  - Walking through a naroow corridor as mono task (approx. 240 seconds duration)
  - Walking being unterrupted by internally generated voluntary stops (approx. 240 seconds duration)
  - Walking under dual task conditions (serial subtraction task) (approx. 240 seconds duration)

All recordings took place in Med OFF and Stim OFF. 

How the tasks were organized for a session.
This is particularly important because BIDS datasets usually have task data
separated into different files.)

- [ ] Was task order counter-balanced?
- [ ] What other activities were interspersed between tasks?
- [ ] In what order were the tasks and other activities performed?

### Task details
As much detail as possible about the task and the events that were recorded.

### Additional data acquired
A brief indication of data other than the
imaging data that was acquired as part of this experiment. In addition
to data from other modalities and behavioral data, this might include
questionnaires and surveys, swabs, and clinical information. Indicate
the availability of this data.

This is especially relevant if the data are not included in a `phenotype` folder.
https://bids-specification.readthedocs.io/en/stable/03-modality-agnostic-files.html#phenotypic-and-assessment-data

### Experimental location
This should include any additional information regarding the
the geographical location and facility that cannot be included
in the relevant json files.

### Missing data
Mention something if some participants are missing some aspects of the data.
This can take the form of a processing log and/or abnormalities about the dataset.

Some examples:
- A brain lesion or defect only present in one participant
- Some experimental conditions missing on a given run for a participant because
  of some technical issue.
- Any noticeable feature of the data for certain participants
- Differences (even slight) in protocol for certain participants.

