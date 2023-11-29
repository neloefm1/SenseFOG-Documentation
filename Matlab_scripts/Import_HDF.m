%%=====  Import_HDF.m ========================================%

%Date: January 2022
%Original author(s): Philipp Klocke, Moritz Löffler

%This script will import the original raw data of specified Inertial Motion
%Units (IMUs) and save the data to a pre-determined filepath. In subsequent
%steps, the data will be processed first and
%lastly, upsampled towards the same EEG sampling frequency. This will
%neccessitate the prior import of EEG data to get the sampling frequency.
