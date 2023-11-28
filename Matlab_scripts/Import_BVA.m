%%=====  Import_BVA.m ========================================%
%Original author(s): Philipp Klocke, Moritz Loeffler

%This script will import the original raw data of specified EEG data and save the data to a pre-determined filepath. 


%==============================================================================
close all

EEG_File            = struct;                                            % Create a file structure
[EEG_file,file]     = uigetfile('*.eeg');                                % Choose the desired EEG File
EEG_File.filename   = strrep(EEG_file,'.eeg','');                        % Creates the filename by cutting off the suffix (.eeg or .vmrk or .vhdr)
EEG_File.eeg        = [EEG_File.filename,'.eeg'];                        % Read the data, header, and marker file.
EEG_File.vhdr       = ft_read_header([EEG_File.filename,'.vhdr']);
EEG_File.vmrk       = ft_read_event([EEG_File.filename,'.vmrk']);
EEG_File.fs_eeg     = EEG_File.vhdr.Fs;
dat.dataset         = ft_read_data(EEG_File.eeg,'header', EEG_File.vhdr);
dat.label           = EEG_File.vhdr.label;



