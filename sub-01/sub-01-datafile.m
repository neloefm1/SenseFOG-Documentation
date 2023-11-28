%% sub-01-datafile.m 
% +------------------------------------------------------+
% |  Subject: SUB-01                                     |
% |                                                      |
% | Author: Philipp Klocke,Moritz Löffler                | 
% +------------------------------------------------------+

% This script will serve as the main directory matlab file for sub-01

% Chose the pathway for the SenseFOG-main folder after downloading
subjectdata.generalpath     = uigetdir;
subjectdata.filedir         = 'sub-01';
subjectdata.subjectnr       = '01';
subjectdata.subject_dir     = 'sub-01';
path                        = append(subjectdata.generalpath, '/', subjectdata.filedir);
cd(path)

% Import the EEG File for 
