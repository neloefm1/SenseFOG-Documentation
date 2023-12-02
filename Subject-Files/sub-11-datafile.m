%% sub-11-datafile.m ====================================================
% +------------------------------------------------------+
% |  Subject: SUB-11                                     |
% |                                                      |
% | Author: Philipp Klocke,Moritz Loeffler               | 
% +------------------------------------------------------+

% This script will serve as the main directory matlab file for sub-11

% Chose the pathway for the SenseFOG-main folder after downloading
subjectdata.generalpath     = uigetdir;                                                                                         % Target file should be the SenseFOG-main file after download
subjectdata.filedir         = 'sub-11';
subjectdata.subjectnr       = '11';
subjectdata.subject_dir     = 'sub-11';
path                        = append(subjectdata.generalpath, '/', subjectdata.filedir);
cd(path)


% SIT - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Sit = [];
subjectdata.signalpoint.Sit.EEG_signal          = [];                                                                           % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Sit.LFP_signal          = [];                                                                           % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Sit.LFP_signal > subjectdata.signalpoint.Sit.EEG_signal;                                             % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Sit.delay = subjectdata.signalpoint.Sit.LFP_signal - subjectdata.signalpoint.Sit.EEG_signal;         % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Sit.EEG_signal > subjectdata.signalpoint.Sit.LFP_signal;                                           % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Sit.delay = subjectdata.signalpoint.Sit.EEG_signal - subjectdata.signalpoint.Sit.LFP_signal;       % Find time-delay between both EEG and LFP
end 


% STAND - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Stand = [];
subjectdata.signalpoint.Stand.EEG_signal        = 20374;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Stand.LFP_signal        = 15895;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Stand.LFP_signal > subjectdata.signalpoint.Stand.EEG_signal;                                         % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Stand.delay = subjectdata.signalpoint.Stand.LFP_signal - subjectdata.signalpoint.Stand.EEG_signal;   % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Stand.EEG_signal > subjectdata.signalpoint.Stand.LFP_signal;                                       % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Stand.delay = subjectdata.signalpoint.Stand.EEG_signal - subjectdata.signalpoint.Stand.LFP_signal; % Find time-delay between both EEG and LFP
end 

% WALK - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Walk = [];
subjectdata.signalpoint.Walk.EEG_signal         = 21735;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Walk.LFP_signal         = 16344;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Walk.LFP_signal > subjectdata.signalpoint.Walk.EEG_signal;                                           % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Walk.delay = subjectdata.signalpoint.Walk.LFP_signal - subjectdata.signalpoint.Walk.EEG_signal;      % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Walk.EEG_signal > subjectdata.signalpoint.Walk.LFP_signal;                                         % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Walk.delay = subjectdata.signalpoint.Walk.EEG_signal - subjectdata.signalpoint.Walk.LFP_signal;    % Find time-delay between both EEG and LFP
end

% WALK WITH STOPS - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.WalkWS = [];
subjectdata.signalpoint.WalkWS.EEG_signal       = 19943;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.WalkWS.LFP_signal       = 14826;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.WalkWS.LFP_signal > subjectdata.signalpoint.WalkWS.EEG_signal;                                       % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.WalkWS.delay = subjectdata.signalpoint.WalkWS.LFP_signal - subjectdata.signalpoint.WalkWS.EEG_signal;% Find time-delay between both EEG and LFP
else subjectdata.signalpoint.WalkWS.EEG_signal > subjectdata.signalpoint.WalkWS.LFP_signal;                                     % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.WalkWS.delay = subjectdata.signalpoint.WalkWS.EEG_signal - subjectdata.signalpoint.WalkWS.LFP_signal;% Find time-delay between both EEG and LFP
end 


% INTERFERENCE - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Interf = [];
subjectdata.signalpoint.Interf.EEG_signal   = [];                                                                               % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Interf.LFP_signal   = [];                                                                               % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Interf.LFP_signal > subjectdata.signalpoint.Interf.EEG_signal;                                       % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Interf.delay = subjectdata.signalpoint.Interf.LFP_signal - subjectdata.signalpoint.Interf.EEG_signal;% find time-delay between both EEG and LFP
else subjectdata.signalpoint.Interf.EEG_signal > subjectdata.signalpoint.Interf.LFP_signal;                                     % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Interf.delay = subjectdata.signalpoint.Interf.EEG_signal - subjectdata.signalpoint.Interf.LFP_signal;% Find time-delay between both EEG and LFP
end 


%=== FILTERED GAIT EVENTS FOR WALK ONLY ===
% Manual input for filtered gait events based on exact timings of heelstrikes (not shown here)
subjectdata.events_filt.Walk = struct;

%Walk 1
subjectdata.events_filt.Walk(1).start = 26.2660000000000; 
subjectdata.events_filt.Walk(1).task = 'Walk';
subjectdata.events_filt.Walk(1).end = 45.2200000000000;

%Turn 1
subjectdata.events_filt.Walk(2).start =  48.289;
subjectdata.events_filt.Walk(2).task = 'Turn';
subjectdata.events_filt.Walk(2).end = 55.4970000000000;

%Walk 2
subjectdata.events_filt.Walk(3).start = 60.1140000000000; 
subjectdata.events_filt.Walk(3).task = 'Walk';
subjectdata.events_filt.Walk(3).end = 70.4580000000000;

%Turn 2
subjectdata.events_filt.Walk(4).start =  72.5980000000000;
subjectdata.events_filt.Walk(4).task = 'Turn';
subjectdata.events_filt.Walk(4).end = 78.5060000000000;

%Walk 3
subjectdata.events_filt.Walk(5).start = 80.4720000000000; 
subjectdata.events_filt.Walk(5).task = 'Walk';
subjectdata.events_filt.Walk(5).end = 90.2460000000000;

%Turn 3
subjectdata.events_filt.Walk(6).start =  92.2880000000000;
subjectdata.events_filt.Walk(6).task = 'Turn';
subjectdata.events_filt.Walk(6).end = 99.6120000000000;

%Walk 4
subjectdata.events_filt.Walk(7).start = 101.442000000000; 
subjectdata.events_filt.Walk(7).task = 'Walk';
subjectdata.events_filt.Walk(7).end = 109.106000000000;

%turn 4
subjectdata.events_filt.Walk(8).start =  112.853;
subjectdata.events_filt.Walk(8).task = 'Turn';
subjectdata.events_filt.Walk(8).end = 118.811000000000;

%Walk 5
subjectdata.events_filt.Walk(9).start = 120.603000000000; 
subjectdata.events_filt.Walk(9).task = 'Walk';
subjectdata.events_filt.Walk(9).end = 131.944000000000;

%Turn 5
subjectdata.events_filt.Walk(10).start =  133.907000000000;
subjectdata.events_filt.Walk(10).task = 'Turn';
subjectdata.events_filt.Walk(10).end = 141.454000000000;

%Walk 6
subjectdata.events_filt.Walk(11).start = 143.567000000000; 
subjectdata.events_filt.Walk(11).task = 'Walk';
subjectdata.events_filt.Walk(11).end = 155.844000000000;

%Turn 6
subjectdata.events_filt.Walk(12).start =  157.939000000000;
subjectdata.events_filt.Walk(12).task = 'Turn';
subjectdata.events_filt.Walk(12).end = 164.103000000000;

%Walk 7
subjectdata.events_filt.Walk(13).start = 166.059000000000; 
subjectdata.events_filt.Walk(13).task = 'Walk';
subjectdata.events_filt.Walk(13).end = 176.194000000000;

%Turn 7
subjectdata.events_filt.Walk(14).start =  178.047000000000;
subjectdata.events_filt.Walk(14).task = 'Turn';
subjectdata.events_filt.Walk(14).end = 185.407000000000;

%Walk 8
subjectdata.events_filt.Walk(15).start = 187.453000000000; 
subjectdata.events_filt.Walk(15).task = 'Walk';
subjectdata.events_filt.Walk(15).end = 197.155000000000;

%Turn 8
subjectdata.events_filt.Walk(16).start =  199.054000000000;
subjectdata.events_filt.Walk(16).task = 'Turn';
subjectdata.events_filt.Walk(16).end = 204.606000000000;

%Walk 9
subjectdata.events_filt.Walk(17).start = 206.428000000000; 
subjectdata.events_filt.Walk(17).task = 'Walk';
subjectdata.events_filt.Walk(17).end = 215.981000000000;

%Turn 9
subjectdata.events_filt.Walk(18).start =  217.879000000000;
subjectdata.events_filt.Walk(18).task = 'Turn';
subjectdata.events_filt.Walk(18).end = 224.005;

%Walk 10
subjectdata.events_filt.Walk(19).start = 225.010000000000; 
subjectdata.events_filt.Walk(19).task = 'Walk';
subjectdata.events_filt.Walk(19).end = 234.419000000000;

%Turn 11
subjectdata.events_filt.Walk(20).start =  236.528000000000;
subjectdata.events_filt.Walk(20).task = 'Turn';
subjectdata.events_filt.Walk(20).end = 242.255000000000;

%Walk 11
subjectdata.events_filt.Walk(21).start = 243.839000000000; 
subjectdata.events_filt.Walk(21).task = 'Walk';
subjectdata.events_filt.Walk(21).end = 251.306000000000;

%Turn 12
subjectdata.events_filt.Walk(22).start =  255.083;
subjectdata.events_filt.Walk(22).task = 'Turn';
subjectdata.events_filt.Walk(22).end = 260.464000000000;

%Walk 12
subjectdata.events_filt.Walk(23).start = 262.402000000000; 
subjectdata.events_filt.Walk(23).task = 'Walk';
subjectdata.events_filt.Walk(23).end = 271.407000000000;

%Turn 12
subjectdata.events_filt.Walk(24).start =  273.256000000000;
subjectdata.events_filt.Walk(24).task = 'Turn';
subjectdata.events_filt.Walk(24).end = 279.0190;

%Walk 13
subjectdata.events_filt.Walk(25).start = 280.832000000000; 
subjectdata.events_filt.Walk(25).task = 'Walk';
subjectdata.events_filt.Walk(25).end = 291.167000000000;

%Turn 13
subjectdata.events_filt.Walk(26).start =  293.145000000000;
subjectdata.events_filt.Walk(26).task = 'Turn';
subjectdata.events_filt.Walk(26).end = 299.815;

%Walk 14
subjectdata.events_filt.Walk(27).start = 300.838000000000; 
subjectdata.events_filt.Walk(27).task = 'Walk';
subjectdata.events_filt.Walk(27).end = 312.623000000000;

%Turn 14
subjectdata.events_filt.Walk(28).start =  314.592000000000;
subjectdata.events_filt.Walk(28).task = 'Turn';
subjectdata.events_filt.Walk(28).end = 320.208000000000;

%Walk 15
subjectdata.events_filt.Walk(29).start = 322.089000000000; 
subjectdata.events_filt.Walk(29).task = 'Walk';
subjectdata.events_filt.Walk(29).end = 331.497000000000;

%Turn 15
subjectdata.events_filt.Walk(30).start =  333.462000000000;
subjectdata.events_filt.Walk(30).task = 'Turn';
subjectdata.events_filt.Walk(30).end = 339.165;

%Walk 16
subjectdata.events_filt.Walk(31).start = 340.158000000000; 
subjectdata.events_filt.Walk(31).task = 'Walk';
subjectdata.events_filt.Walk(31).end = 349.938000000000;

%Turn 16
subjectdata.events_filt.Walk(32).start =  351.897000000000;
subjectdata.events_filt.Walk(32).task = 'Turn';
subjectdata.events_filt.Walk(32).end = 357.546000000000;

%Walk 17 
subjectdata.events_filt.Walk(33).start = 359.497000000000; 
subjectdata.events_filt.Walk(33).task = 'Walk';
subjectdata.events_filt.Walk(33).end = 369.224000000000;

%Turn 17
subjectdata.events_filt.Walk(34).start =  371.164000000000;
subjectdata.events_filt.Walk(34).task = 'Turn';
subjectdata.events_filt.Walk(34).end = 376.627000000000;

%Walk 18
subjectdata.events_filt.Walk(35).start = 378.457000000000; 
subjectdata.events_filt.Walk(35).task = 'Walk';
subjectdata.events_filt.Walk(35).end = 387.603000000000;



%=== FILTERED GAIT EVENTS FOR WALK WITH STOPS ONLY ===
%Manual Input for Filtered Gait Events based on the exact timings of heelstrike events (not shown here)
subjectdata.events_filt.WalkWS = struct;

%Walk 1
subjectdata.events_filt.WalkWS(1).task = 'Walk'; 
subjectdata.events_filt.WalkWS(1).start = 25.6070000000000;
subjectdata.events_filt.WalkWS(1).end = 27.9580000000000;

%Selected stop 1
subjectdata.events_filt.WalkWS(2).task = 'Selected_stop_start'; 
subjectdata.events_filt.WalkWS(2).start = 32.5080000000000;
subjectdata.events_filt.WalkWS(2).end = 34.508;

%Walk 2
subjectdata.events_filt.WalkWS(3).task = 'Walk'; 
subjectdata.events_filt.WalkWS(3).start = 36.3170000000000;
subjectdata.events_filt.WalkWS(3).end = 46.3110000000000;

%Turn 2
subjectdata.events_filt.WalkWS(4).task = 'Turn'; 
subjectdata.events_filt.WalkWS(4).start = 47.3130000000000;
subjectdata.events_filt.WalkWS(4).end = 54.398;

%Selected stop 2
subjectdata.events_filt.WalkWS(5).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(5).start = 57.1570000000000;
subjectdata.events_filt.WalkWS(5).end = 59.59;

%Walk 3
subjectdata.events_filt.WalkWS(6).task = 'Walk'; 
subjectdata.events_filt.WalkWS(6).start = 60.1120000000000;
subjectdata.events_filt.WalkWS(6).end = 67.7690000000000;

%Turn 
subjectdata.events_filt.WalkWS(7).task = 'Turn'; 
subjectdata.events_filt.WalkWS(7).start = 71.806;
subjectdata.events_filt.WalkWS(7).end = 78.283;

%Walk 
subjectdata.events_filt.WalkWS(8).task = 'Walk'; 
subjectdata.events_filt.WalkWS(8).start = 79.1110000000000;
subjectdata.events_filt.WalkWS(8).end = 80.8790000000000;

%Selected stop
subjectdata.events_filt.WalkWS(9).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(9).start = 83.4840000000000;
subjectdata.events_filt.WalkWS(9).end = 86.993;

%Walk 
subjectdata.events_filt.WalkWS(10).task = 'Walk'; 
subjectdata.events_filt.WalkWS(10).start = 87.5060000000000;
subjectdata.events_filt.WalkWS(10).end = 93.3260000000000;

%Turn 
subjectdata.events_filt.WalkWS(11).task = 'Turn'; 
subjectdata.events_filt.WalkWS(11).start = 97.091 ;
subjectdata.events_filt.WalkWS(11).end = 103.584;

%Selected stop
subjectdata.events_filt.WalkWS(12).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(12).start = 106.329000000000;
subjectdata.events_filt.WalkWS(12).end = 109.093;

%Walk
subjectdata.events_filt.WalkWS(13).task = 'Walk'; 
subjectdata.events_filt.WalkWS(13).start = 109.543000000000;
subjectdata.events_filt.WalkWS(13).end = 117.134000000000;

%Turn
subjectdata.events_filt.WalkWS(14).task = 'Turn'; 
subjectdata.events_filt.WalkWS(14).start = 120.974;
subjectdata.events_filt.WalkWS(14).end = 127.177;

%Selected stop
subjectdata.events_filt.WalkWS(15).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(15).start = 131.584000000000;
subjectdata.events_filt.WalkWS(15).end = 134.58;

%Walk 
subjectdata.events_filt.WalkWS(16).task = 'Walk'; 
subjectdata.events_filt.WalkWS(16).start = 136.390000000000;
subjectdata.events_filt.WalkWS(16).end = 144.199000000000;

%Turn 
subjectdata.events_filt.WalkWS(17).task = 'Turn'; 
subjectdata.events_filt.WalkWS(17).start = 146.058000000000;
subjectdata.events_filt.WalkWS(17).end = 153.543000000000;

%Selected stop 
subjectdata.events_filt.WalkWS(18).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(18).start = 157.161000000000;
subjectdata.events_filt.WalkWS(18).end = 159.802;

%Walk
subjectdata.events_filt.WalkWS(19).task = 'Walk'; 
subjectdata.events_filt.WalkWS(19).start = 161.266000000000;
subjectdata.events_filt.WalkWS(19).end = 168.653000000000;

%Turn 
subjectdata.events_filt.WalkWS(20).task = 'Turn'; 
subjectdata.events_filt.WalkWS(20).start = 171.434;
subjectdata.events_filt.WalkWS(20).end = 177.685000000000;

%Selected_stop
subjectdata.events_filt.WalkWS(21).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(21).start = 181.678000000000;
subjectdata.events_filt.WalkWS(21).end = 184.436;

%Walk 
subjectdata.events_filt.WalkWS(22).task = 'Walk'; 
subjectdata.events_filt.WalkWS(22).start = 184.872000000000;
subjectdata.events_filt.WalkWS(22).end = 193.131000000000;

%Turn 
subjectdata.events_filt.WalkWS(23).task = 'Turn'; 
subjectdata.events_filt.WalkWS(23).start = 196.754;
subjectdata.events_filt.WalkWS(23).end = 204.623000000000;

%Selected stop 
subjectdata.events_filt.WalkWS(24).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(24).start = 208.585000000000;
subjectdata.events_filt.WalkWS(24).end = 211.46;

%Walk 
subjectdata.events_filt.WalkWS(25).task = 'Walk'; 
subjectdata.events_filt.WalkWS(25).start = 211.940000000000;
subjectdata.events_filt.WalkWS(25).end = 220.677000000000;


% ===== Save DATA ====================================================================================================
save([path filesep subjectdata.subject_dir '_datafile.mat'], 'subjectdata', '-mat')

% *********************** END OF SCRIPT *******************************************************************************************************************
