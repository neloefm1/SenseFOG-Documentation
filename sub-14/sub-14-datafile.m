%% sub-14-datafile.m ====================================================
% +------------------------------------------------------+
% |  Subject: SUB-14                                     |
% |                                                      |
% | Author: Philipp Klocke,Moritz Löffler                | 
% +------------------------------------------------------+

% This script will serve as the main directory matlab file for sub-14

% Chose the pathway for the SenseFOG-main folder after downloading
subjectdata.generalpath     = uigetdir;                                                                                         % Target file should be the SenseFOG-main file after download
subjectdata.filedir         = 'sub-14';
subjectdata.subjectnr       = '14';
subjectdata.subject_dir     = 'sub-14';
path                        = append(subjectdata.generalpath, '/', subjectdata.filedir);
cd(path)


% SIT - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Sit = [];
subjectdata.signalpoint.Sit.EEG_signal          = 16184;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Sit.LFP_signal          = 12703;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Sit.LFP_signal > subjectdata.signalpoint.Sit.EEG_signal;                                             % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Sit.delay = subjectdata.signalpoint.Sit.LFP_signal - subjectdata.signalpoint.Sit.EEG_signal;         % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Sit.EEG_signal > subjectdata.signalpoint.Sit.LFP_signal;                                           % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Sit.delay = subjectdata.signalpoint.Sit.EEG_signal - subjectdata.signalpoint.Sit.LFP_signal;       % Find time-delay between both EEG and LFP
end 


% STAND - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Stand = [];
subjectdata.signalpoint.Stand.EEG_signal        = 15090;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Stand.LFP_signal        = 12264;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Stand.LFP_signal > subjectdata.signalpoint.Stand.EEG_signal;                                         % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Stand.delay = subjectdata.signalpoint.Stand.LFP_signal - subjectdata.signalpoint.Stand.EEG_signal;   % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Stand.EEG_signal > subjectdata.signalpoint.Stand.LFP_signal;                                       % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Stand.delay = subjectdata.signalpoint.Stand.EEG_signal - subjectdata.signalpoint.Stand.LFP_signal; % Find time-delay between both EEG and LFP
end 

% WALK - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Walk = [];
subjectdata.signalpoint.Walk.EEG_signal         = [];                                                                           % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Walk.LFP_signal         = [];                                                                           % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Walk.LFP_signal > subjectdata.signalpoint.Walk.EEG_signal;                                           % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Walk.delay = subjectdata.signalpoint.Walk.LFP_signal - subjectdata.signalpoint.Walk.EEG_signal;      % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Walk.EEG_signal > subjectdata.signalpoint.Walk.LFP_signal;                                         % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Walk.delay = subjectdata.signalpoint.Walk.EEG_signal - subjectdata.signalpoint.Walk.LFP_signal;    % Find time-delay between both EEG and LFP
end

% WALK WITH STOPS - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.WalkWS = [];
subjectdata.signalpoint.WalkWS.EEG_signal       = 11904;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.WalkWS.LFP_signal       = 10230;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.WalkWS.LFP_signal > subjectdata.signalpoint.WalkWS.EEG_signal;                                       % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.WalkWS.delay = subjectdata.signalpoint.WalkWS.LFP_signal - subjectdata.signalpoint.WalkWS.EEG_signal;% Find time-delay between both EEG and LFP
else subjectdata.signalpoint.WalkWS.EEG_signal > subjectdata.signalpoint.WalkWS.LFP_signal;                                     % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.WalkWS.delay = subjectdata.signalpoint.WalkWS.EEG_signal - subjectdata.signalpoint.WalkWS.LFP_signal;% Find time-delay between both EEG and LFP
end 


% INTERFERENCE - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Interf = [];
subjectdata.signalpoint.Interf.EEG_signal       = 13379;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Interf.LFP_signal       = 10723;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Interf.LFP_signal > subjectdata.signalpoint.Interf.EEG_signal;                                       % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Interf.delay = subjectdata.signalpoint.Interf.LFP_signal - subjectdata.signalpoint.Interf.EEG_signal;% find time-delay between both EEG and LFP
else subjectdata.signalpoint.Interf.EEG_signal > subjectdata.signalpoint.Interf.LFP_signal;                                     % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Interf.delay = subjectdata.signalpoint.Interf.EEG_signal - subjectdata.signalpoint.Interf.LFP_signal;% Find time-delay between both EEG and LFP
end 


% INTERFERENCE 2 - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Interf_new = [];
subjectdata.signalpoint.Interf_new.EEG_signal       = 10136;                                                                      % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Interf_new.LFP_signal       = 8012;                                                                       % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Interf_new.LFP_signal > subjectdata.signalpoint.Interf_new.EEG_signal;                                 % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Interf_new.delay = subjectdata.signalpoint.Interf_new.LFP_signal - subjectdata.signalpoint.Interf_new.EEG_signal;% find time-delay between both EEG and LFP
else subjectdata.signalpoint.Interf_new.EEG_signal > subjectdata.signalpoint.Interf_new.LFP_signal;                               % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Interf_new.delay = subjectdata.signalpoint.Interf_new.EEG_signal - subjectdata.signalpoint.Interf_new.LFP_signal;% Find time-delay between both EEG and LFP
end 


%=== FILTERED GAIT EVENTS FOR WALK ONLY ===
% Manual input for filtered gait events based on exact timings of heelstrikes (not shown here)
subjectdata.events_filt.Walk = struct;

%Walk 1
subjectdata.events_filt.Walk(1).start = 19.8060000000000; 
subjectdata.events_filt.Walk(1).task = 'Walk';
subjectdata.events_filt.Walk(1).end = 31.8730000000000;

%Turn 1
subjectdata.events_filt.Walk(2).start =  32.5220000000000;
subjectdata.events_filt.Walk(2).task = 'Turn';
subjectdata.events_filt.Walk(2).end = 37.6980000000000;

%Walk 2
subjectdata.events_filt.Walk(3).start = 38.3500000000000; 
subjectdata.events_filt.Walk(3).task = 'Walk';
subjectdata.events_filt.Walk(3).end = 47.6590000000000;

%Turn 2
subjectdata.events_filt.Walk(4).start = 48.2560000000000; 
subjectdata.events_filt.Walk(4).task = 'Turn';
subjectdata.events_filt.Walk(4).end = 52.4530000000000;

%Walk 3
subjectdata.events_filt.Walk(5).start = 53.8070000000000; 
subjectdata.events_filt.Walk(5).task = 'Walk';
subjectdata.events_filt.Walk(5).end = 62.6610000000000;

%Turn 3
subjectdata.events_filt.Walk(6).start = 63.3270000000000; 
subjectdata.events_filt.Walk(6).task = 'Turn';
subjectdata.events_filt.Walk(6).end = 67.2660000000000;

%Walk 4
subjectdata.events_filt.Walk(7).start = 68.3700000000000; 
subjectdata.events_filt.Walk(7).task = 'Walk';
subjectdata.events_filt.Walk(7).end = 76.0950000000000;

%TUrn 4
subjectdata.events_filt.Walk(8).start = 77.3910000000000; 
subjectdata.events_filt.Walk(8).task = 'Turn';
subjectdata.events_filt.Walk(8).end = 81.9140000000000;

%Walk 5
subjectdata.events_filt.Walk(9).start = 82.8010000000000; 
subjectdata.events_filt.Walk(9).task = 'Walk';
subjectdata.events_filt.Walk(9).end = 91.6000000000000;

%Turn 5
subjectdata.events_filt.Walk(10).start = 92.1920000000000; 
subjectdata.events_filt.Walk(10).task = 'Turn';
subjectdata.events_filt.Walk(10).end = 95.9370000000000;

%Walk 6
subjectdata.events_filt.Walk(11).start = 96.5160000000000; 
subjectdata.events_filt.Walk(11).task = 'Walk';
subjectdata.events_filt.Walk(11).end = 105.722000000000;

%omit freezing after discussion as Freze is right in front of a turn
%subjectdata.events_filt.Walk(12).start = 107.099000000000; 
%subjectdata.events_filt.Walk(12).task = 'Freezing_walk';
%subjectdata.events_filt.Walk(12).end = 108.999000000000;

%Walk 7
subjectdata.events_filt.Walk(13).start = 133.393000000000; 
subjectdata.events_filt.Walk(13).task = 'Walk';
subjectdata.events_filt.Walk(13).end = 139.913000000000;

%TUrn 7
subjectdata.events_filt.Walk(14).start = 141.185000000000; 
subjectdata.events_filt.Walk(14).task = 'Turn';
subjectdata.events_filt.Walk(14).end = 144.694000000000;

%Walk 8
subjectdata.events_filt.Walk(15).start = 145.710000000000; 
subjectdata.events_filt.Walk(15).task = 'Walk';
subjectdata.events_filt.Walk(15).end = 154.288000000000;

%Turn 8
subjectdata.events_filt.Walk(16).start = 154.899000000000; 
subjectdata.events_filt.Walk(16).task = 'Turn';
subjectdata.events_filt.Walk(16).end = 158.830000000000;

%Walk 9
subjectdata.events_filt.Walk(17).start = 159.700000000000; 
subjectdata.events_filt.Walk(17).task = 'Walk';
subjectdata.events_filt.Walk(17).end = 167.032000000000;

%Turn 9
subjectdata.events_filt.Walk(18).start = 168.292000000000; 
subjectdata.events_filt.Walk(18).task = 'Turn';
subjectdata.events_filt.Walk(18).end = 171.973000000000;

%Walk 10
subjectdata.events_filt.Walk(19).start = 173.192000000000; 
subjectdata.events_filt.Walk(19).task = 'Walk';
subjectdata.events_filt.Walk(19).end = 181.734000000000;

%Turn 10
subjectdata.events_filt.Walk(20).start = 182.368000000000; 
subjectdata.events_filt.Walk(20).task = 'Turn';
subjectdata.events_filt.Walk(20).end = 186.179000000000;

%Walk 11
subjectdata.events_filt.Walk(21).start = 186.728000000000; 
subjectdata.events_filt.Walk(21).task = 'Walk';
subjectdata.events_filt.Walk(21).end = 195.417000000000;

%Turn 11
subjectdata.events_filt.Walk(22).start = 197.199000000000; 
subjectdata.events_filt.Walk(22).task = 'Turn';
subjectdata.events_filt.Walk(22).end = 200.496000000000;

%Walk 12
subjectdata.events_filt.Walk(23).start = 201.117000000000; 
subjectdata.events_filt.Walk(23).task = 'Walk';
subjectdata.events_filt.Walk(23).end = 207.765000000000;

%Turn 12
subjectdata.events_filt.Walk(24).start = 209.458000000000; 
subjectdata.events_filt.Walk(24).task = 'Turn';
subjectdata.events_filt.Walk(24).end = 216.281000000000;

%Freezing while turning, omit after discussion
%subjectdata.events_filt.Walk(25).start = 211.267000000000; 
%subjectdata.events_filt.Walk(25).task = 'Freezing_turn';
%subjectdata.events_filt.Walk(25).end = 213.311000000000;

%Walk 13
subjectdata.events_filt.Walk(26).start = 217.700000000000; 
subjectdata.events_filt.Walk(26).task = 'Walk';
subjectdata.events_filt.Walk(26).end = 223.592000000000;

%Turn 13
subjectdata.events_filt.Walk(27).start = 224.736000000000; 
subjectdata.events_filt.Walk(27).task = 'Turn';
subjectdata.events_filt.Walk(27).end = 227.764000000000;

%Walk 14
subjectdata.events_filt.Walk(28).start = 228.390000000000; 
subjectdata.events_filt.Walk(28).task = 'Walk';
subjectdata.events_filt.Walk(28).end = 236.823000000000;

%Turn 14
subjectdata.events_filt.Walk(29).start = 237.437000000000; 
subjectdata.events_filt.Walk(29).task = 'Turn';
subjectdata.events_filt.Walk(29).end = 241.965000000000;

%Walk 15
subjectdata.events_filt.Walk(30).start = 242.520000000000; 
subjectdata.events_filt.Walk(30).task = 'Walk';
subjectdata.events_filt.Walk(30).end = 249.955000000000;

%Turn 15
subjectdata.events_filt.Walk(31).start = 251.181000000000; 
subjectdata.events_filt.Walk(31).task = 'Turn';
subjectdata.events_filt.Walk(31).end = 255.542000000000;

%Walk 16
subjectdata.events_filt.Walk(32).start = 257.054000000000; 
subjectdata.events_filt.Walk(32).task = 'Walk';
subjectdata.events_filt.Walk(32).end = 264.366000000000;




%=== FILTERED GAIT EVENTS FOR WALK WITH STOPS ONLY ===
%Manual Input for Filtered Gait Events based on the exact timings of heelstrike events (not shown here)
subjectdata.events_filt.WalkWS = struct;

%Walk 1
subjectdata.events_filt.WalkWS(1).task = 'Walk'; 
subjectdata.events_filt.WalkWS(1).start = 14.9830000000000;
subjectdata.events_filt.WalkWS(1).end = 17.4490000000000;

%Selected_stop 1
subjectdata.events_filt.WalkWS(2).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(2).start = 18.4220000000000;
subjectdata.events_filt.WalkWS(2).end = 20.954;

%Walk 2
subjectdata.events_filt.WalkWS(3).task = 'Walk'; 
subjectdata.events_filt.WalkWS(3).start = 22.4530000000000;
subjectdata.events_filt.WalkWS(3).end = 24.8400000000000;

%Selected_stop 2
subjectdata.events_filt.WalkWS(4).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(4).start = 26.3050000000000;
subjectdata.events_filt.WalkWS(4).end = 29.823;

%Turn 1
subjectdata.events_filt.WalkWS(5).task = 'Turn'; 
subjectdata.events_filt.WalkWS(5).start = 32.2710000000000;
subjectdata.events_filt.WalkWS(5).end = 36.2120000000000;

%Walk 3
subjectdata.events_filt.WalkWS(6).task = 'Walk'; 
subjectdata.events_filt.WalkWS(6).start = 36.7480000000000;
subjectdata.events_filt.WalkWS(6).end = 37.9330000000000;

%Selected stop 3 %Include after review 07/23
subjectdata.events_filt.WalkWS(7).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(7).start = 39.5960000000000;
subjectdata.events_filt.WalkWS(7).end = 40.819000;

%Walk 4
subjectdata.events_filt.WalkWS(8).task = 'Walk'; 
subjectdata.events_filt.WalkWS(8).start = 42.0130000000000;
subjectdata.events_filt.WalkWS(8).end = 45.6570000000000;

%Selected_stop 4
subjectdata.events_filt.WalkWS(9).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(9).start = 46.8060000000000;
subjectdata.events_filt.WalkWS(9).end = 49.425;

%Walk 5
subjectdata.events_filt.WalkWS(10).task = 'Walk'; 
subjectdata.events_filt.WalkWS(10).start = 50.4750000000000;
subjectdata.events_filt.WalkWS(10).end = 51.7020000000000;

%Turn, omit after discussion
%subjectdata.events_filt.WalkWS(11).task = 'Turn'; 
%subjectdata.events_filt.WalkWS(11).start = 52.2910000000000;
%subjectdata.events_filt.WalkWS(11).end = 59.4510000000000;

%Freezing while turning, omit after discussion
%subjectdata.events_filt.WalkWS(12).task = 'Freezing_turn'; 
%subjectdata.events_filt.WalkWS(12).start = 55.1670000000000;
%subjectdata.events_filt.WalkWS(12).end = 59.4510000000000;

%Selected Stop
subjectdata.events_filt.WalkWS(13).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(13).start = 61.8100000000000;
subjectdata.events_filt.WalkWS(13).end = 64.782;

%Walk 6
subjectdata.events_filt.WalkWS(14).task = 'Walk'; 
subjectdata.events_filt.WalkWS(14).start = 65.8890000000000;
subjectdata.events_filt.WalkWS(14).end = 69.5330000000000;

%Selected stop
subjectdata.events_filt.WalkWS(15).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(15).start = 71.2280000000000;
subjectdata.events_filt.WalkWS(15).end = 74.714;

%Walk 7
subjectdata.events_filt.WalkWS(16).task = 'Walk'; 
subjectdata.events_filt.WalkWS(16).start = 75.9970000000000;
subjectdata.events_filt.WalkWS(16).end = 77.2780000000000;

%Turn, omit after discussion
%subjectdata.events_filt.WalkWS(17).task = 'Turn'; 
%subjectdata.events_filt.WalkWS(17).start = 77.8090000000000;
%subjectdata.events_filt.WalkWS(17).end = 81.9020000000000;

%Walk 8
subjectdata.events_filt.WalkWS(18).task = 'Walk'; 
subjectdata.events_filt.WalkWS(18).start = 83.1420000000000;
subjectdata.events_filt.WalkWS(18).end = 84.3690000000000;

%Selected stop
subjectdata.events_filt.WalkWS(19).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(19).start = 86.0570000000000;
subjectdata.events_filt.WalkWS(19).end = 89.470;

%Walk 9
subjectdata.events_filt.WalkWS(20).task = 'Walk'; 
subjectdata.events_filt.WalkWS(20).start = 90.5880000000000;
subjectdata.events_filt.WalkWS(20).end = 95.2630000000000;

%Selected stop
subjectdata.events_filt.WalkWS(21).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(21).start = 96.4450000000000;
subjectdata.events_filt.WalkWS(21).end = 100.064;

%Walk 10
subjectdata.events_filt.WalkWS(22).task = 'Walk'; 
subjectdata.events_filt.WalkWS(22).start = 101.213000000000;
subjectdata.events_filt.WalkWS(22).end = 102.360000000000;

%Turn
subjectdata.events_filt.WalkWS(23).task = 'Turn'; 
subjectdata.events_filt.WalkWS(23).start = 102.971000000000;
subjectdata.events_filt.WalkWS(23).end = 107.909000000000;

%Walk 11
subjectdata.events_filt.WalkWS(24).task = 'Walk'; 
subjectdata.events_filt.WalkWS(24).start = 109.134000000000;
subjectdata.events_filt.WalkWS(24).end = 111.475000000000;

%Selected stop
subjectdata.events_filt.WalkWS(25).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(25).start = 113.064000000000;
subjectdata.events_filt.WalkWS(25).end = 115.064;

%Walk 12
subjectdata.events_filt.WalkWS(26).task = 'Walk'; 
subjectdata.events_filt.WalkWS(26).start = 116.732000000000;
subjectdata.events_filt.WalkWS(26).end = 119.146000000000;

%Turn
subjectdata.events_filt.WalkWS(27).task = 'Turn'; 
subjectdata.events_filt.WalkWS(27).start = 127.145000000000;
subjectdata.events_filt.WalkWS(27).end = 132.582000000000;

%Freezing turn
subjectdata.events_filt.WalkWS(28).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkWS(28).start = 128.788000000000;
subjectdata.events_filt.WalkWS(28).end = 132.582000000000;

%Selected stop
subjectdata.events_filt.WalkWS(29).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(29).start = 121.863000000000;
subjectdata.events_filt.WalkWS(29).end = 124.909;

%Walk 13
subjectdata.events_filt.WalkWS(30).task = 'Walk'; 
subjectdata.events_filt.WalkWS(30).start = 133.226000000000;
subjectdata.events_filt.WalkWS(30).end = 135.556000000000;

%Selected stop
subjectdata.events_filt.WalkWS(31).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(31).start = 137.923000000000;
subjectdata.events_filt.WalkWS(31).end = 139.772;

%Walk 14
subjectdata.events_filt.WalkWS(32).task = 'Walk'; 
subjectdata.events_filt.WalkWS(32).start = 140.837000000000;
subjectdata.events_filt.WalkWS(32).end = 143.174000000000;

%Selected stop
subjectdata.events_filt.WalkWS(33).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(33).start = 144.625000000000;
subjectdata.events_filt.WalkWS(33).end = 146.970;

%Walk 15
subjectdata.events_filt.WalkWS(34).task = 'Walk'; 
subjectdata.events_filt.WalkWS(34).start = 148.539000000000;
subjectdata.events_filt.WalkWS(34).end = 149.577000000000;

%Walk 16
subjectdata.events_filt.WalkWS(35).task = 'Walk'; 
subjectdata.events_filt.WalkWS(35).start = 161.382000000000;
subjectdata.events_filt.WalkWS(35).end = 163.868000000000;

%Selected stop
subjectdata.events_filt.WalkWS(36).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(36).start = 166.367000000000;
subjectdata.events_filt.WalkWS(36).end = 168.696;

%Walk
subjectdata.events_filt.WalkWS(37).task = 'Walk'; 
subjectdata.events_filt.WalkWS(37).start = 169.915000000000;
subjectdata.events_filt.WalkWS(37).end = 172.382000000000;

%Selected stop
subjectdata.events_filt.WalkWS(38).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(38).start = 174.499;
subjectdata.events_filt.WalkWS(38).end = 177.929;

%Walk
subjectdata.events_filt.WalkWS(39).task = 'Walk'; 
subjectdata.events_filt.WalkWS(39).start = 178.917000000000;
subjectdata.events_filt.WalkWS(39).end = 180.085000000000;

%Turn
subjectdata.events_filt.WalkWS(40).task = 'Turn'; 
subjectdata.events_filt.WalkWS(40).start = 180.608000000000;
subjectdata.events_filt.WalkWS(40).end = 184.401000000000;

%Selected stop %Include after review 07/23 as duration >1000 ms
subjectdata.events_filt.WalkWS(41).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(41).start = 188.499000000000;
subjectdata.events_filt.WalkWS(41).end = 189.8750;

%Walk
subjectdata.events_filt.WalkWS(42).task = 'Walk'; 
subjectdata.events_filt.WalkWS(42).start = 185.633000000000;
subjectdata.events_filt.WalkWS(42).end = 186.856000000000;

%Walk
subjectdata.events_filt.WalkWS(43).task = 'Walk'; 
subjectdata.events_filt.WalkWS(43).start = 190.180000000000;
subjectdata.events_filt.WalkWS(43).end = 194.881000000000;

%Selected stop
subjectdata.events_filt.WalkWS(44).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(44).start = 196.484000000000;
subjectdata.events_filt.WalkWS(44).end = 198.868;




%=== FILTERED GAIT EVENTS FOR WALK WITH INTERFERENCE ONLY ===
%Manual Input for Filtered Gait Events based on the exact timings of heelstrike events (not shown here)
subjectdata.events_filt.WalkINT = struct;

%Walk 1
%subjectdata.events_filt.WalkINT(1).task = 'Walk';  %No meaningful data with 3 GCs
%subjectdata.events_filt.WalkINT(1).start = 27.5720000000000;
%subjectdata.events_filt.WalkINT(1).end = 29.9410000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT(2).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(2).start = 32.7710000000000;
subjectdata.events_filt.WalkINT(2).end = 45.2970000000000;

%Freezing while walking %After review 04/23 decided to omit due to no FI increase
%subjectdata.events_filt.WalkINT(3).task = 'Freezing_walk'; 
%subjectdata.events_filt.WalkINT(3).start = 77.9250000000000;
%subjectdata.events_filt.WalkINT(3).end = 82.9870000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT(4).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(4).start = 111.17500000;
subjectdata.events_filt.WalkINT(4).end = 123.024000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT(5).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(5).start = 134.051000000000;
subjectdata.events_filt.WalkINT(5).end = 139.251000000000;

%Turn
%subjectdata.events_filt.WalkINT(6).task = 'Turn'; %Decided to take turn off
%subjectdata.events_filt.WalkINT(6).start = 143.641000000000;
%subjectdata.events_filt.WalkINT(6).end = 151.448000000000;

%Freezing while walking &Clinically confirmed but no FI increase
subjectdata.events_filt.WalkINT(7).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(7).start = 157.75400000000;
subjectdata.events_filt.WalkINT(7).end = 171.82200000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT(8).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(8).start = 204.511000000000;
subjectdata.events_filt.WalkINT(8).end = 207.641000000000;

%=== FILTERED GAIT EVENTS FOR WALK WITH INTERFERENCE 2 ONLY ===
%Manual Input for Filtered Gait Events based on the exact timings of heelstrike events (not shown here)
subjectdata.events_filt.WalkINT_new = struct;

%Walk 1
subjectdata.events_filt.WalkINT_new(1).task = 'Walk'; 
subjectdata.events_filt.WalkINT_new(1).start = 13.6550000000000;
subjectdata.events_filt.WalkINT_new(1).end = 29.8730000000000;

%Turn 1
subjectdata.events_filt.WalkINT_new(2).task = 'Turn'; 
subjectdata.events_filt.WalkINT_new(2).start = 34.8630000000000;
subjectdata.events_filt.WalkINT_new(2).end = 48.9650000000000;

%Freezing while walking 1
subjectdata.events_filt.WalkINT_new(3).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT_new(3).start = 37.0940000000000;
subjectdata.events_filt.WalkINT_new(3).end = 48.9650000000000;

%Walk 
subjectdata.events_filt.WalkINT_new(4).task = 'Walk'; 
subjectdata.events_filt.WalkINT_new(4).start = 50.9250000000000;
subjectdata.events_filt.WalkINT_new(4).end = 55.3770000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT_new(5).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT_new(5).start = 56.3630000000000;
subjectdata.events_filt.WalkINT_new(5).end = 69.1280000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT_new(6).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT_new(6).start = 75.65500000000;
subjectdata.events_filt.WalkINT_new(6).end = 79.270000000000;

%Freezing while waling
subjectdata.events_filt.WalkINT_new(7).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT_new(7).start = 85.063000000000;
subjectdata.events_filt.WalkINT_new(7).end = 90.2420000000000;

%Turn
%subjectdata.events_filt.WalkINT_new(8).task = 'Turn'; %Deleted as previous
%freeze activity occurs before the turn is initiated
%subjectdata.events_filt.WalkINT_new(8).start = 89.6810000000000;
%subjectdata.events_filt.WalkINT_new(8).end = 94.4450000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT_new(9).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT_new(9).start = 97.4450000000000;
subjectdata.events_filt.WalkINT_new(9).end = 109.025000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT_new(10).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT_new(10).start = 116.4670000000;
subjectdata.events_filt.WalkINT_new(10).end = 120.870000000000;

%Walk
subjectdata.events_filt.WalkINT_new(11).task = 'Walk'; 
subjectdata.events_filt.WalkINT_new(11).start = 130.856000000000;
subjectdata.events_filt.WalkINT_new(11).end = 136.981000000000;

%Turn
subjectdata.events_filt.WalkINT_new(12).task = 'Turn'; 
subjectdata.events_filt.WalkINT_new(12).start = 138.413000000000;
subjectdata.events_filt.WalkINT_new(12).end = 157.13300000000;

%Freezing while turning
subjectdata.events_filt.WalkINT_new(13).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT_new(13).start = 139.243000000000;
subjectdata.events_filt.WalkINT_new(13).end = 157.133000000000;

%Walk
subjectdata.events_filt.WalkINT_new(14).task = 'Walk'; 
subjectdata.events_filt.WalkINT_new(14).start = 158.944000000000;
subjectdata.events_filt.WalkINT_new(14).end = 162.927000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT_new(15).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT_new(15).start = 163.410000000000;
subjectdata.events_filt.WalkINT_new(15).end = 169.210000000000;


% ===== Save DATA ====================================================================================================
save([path filesep subjectdata.subject_dir '_datafile.mat'], 'subjectdata', '-mat')

% *********************** END OF SCRIPT *******************************************************************************************************************
