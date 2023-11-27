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

A brief sentence about the subject pool in this experiment.

Remember that `Control` or `Patient` status should be defined in the `participants.tsv`
using a group column.
- [ ] Information about the recruitment procedure
- [ ] Subject inclusion criteria (if relevant)
- [ ] Subject exclusion criteria (if relevant)

### Apparatus
A summary of the equipment and environment setup for the
experiment. For example, was the experiment performed in a shielded room
with the subject seated in a fixed position.

### Initial setup
A summary of what setup was performed when a subject arrived.

### Task organization
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

