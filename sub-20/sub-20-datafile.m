%% sub-20-datafile.m ====================================================
% +------------------------------------------------------+
% |  Subject: SUB-20                                     |
% |                                                      |
% | Author: Philipp Klocke,Moritz Löffler                | 
% +------------------------------------------------------+

% This script will serve as the main directory matlab file for sub-20

% Chose the pathway for the SenseFOG-main folder after downloading
subjectdata.generalpath     = uigetdir;                                                                                         % Target file should be the SenseFOG-main file after download
subjectdata.filedir         = 'sub-20';
subjectdata.subjectnr       = '20';
subjectdata.subject_dir     = 'sub-20';
path                        = append(subjectdata.generalpath, '/', subjectdata.filedir);
cd(path)



% SIT - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Sit = [];
subjectdata.signalpoint.Sit.EEG_signal          = 9628;                                                                         % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Sit.LFP_signal          = 8062;                                                                         % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Sit.LFP_signal > subjectdata.signalpoint.Sit.EEG_signal;                                             % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Sit.delay = subjectdata.signalpoint.Sit.LFP_signal - subjectdata.signalpoint.Sit.EEG_signal;         % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Sit.EEG_signal > subjectdata.signalpoint.Sit.LFP_signal;                                           % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Sit.delay = subjectdata.signalpoint.Sit.EEG_signal - subjectdata.signalpoint.Sit.LFP_signal;       % Find time-delay between both EEG and LFP
end 


% STAND - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Stand = [];
subjectdata.signalpoint.Stand.EEG_signal        = 9874;                                                                         % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Stand.LFP_signal        = 8520;                                                                         % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Stand.LFP_signal > subjectdata.signalpoint.Stand.EEG_signal;                                         % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Stand.delay = subjectdata.signalpoint.Stand.LFP_signal - subjectdata.signalpoint.Stand.EEG_signal;   % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Stand.EEG_signal > subjectdata.signalpoint.Stand.LFP_signal;                                       % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Stand.delay = subjectdata.signalpoint.Stand.EEG_signal - subjectdata.signalpoint.Stand.LFP_signal; % Find time-delay between both EEG and LFP
end 

% WALK - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Walk = [];
subjectdata.signalpoint.Walk.EEG_signal         = 9278;                                                                         % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Walk.LFP_signal         = 8329;                                                                         % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Walk.LFP_signal > subjectdata.signalpoint.Walk.EEG_signal;                                           % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Walk.delay = subjectdata.signalpoint.Walk.LFP_signal - subjectdata.signalpoint.Walk.EEG_signal;      % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Walk.EEG_signal > subjectdata.signalpoint.Walk.LFP_signal;                                         % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Walk.delay = subjectdata.signalpoint.Walk.EEG_signal - subjectdata.signalpoint.Walk.LFP_signal;    % Find time-delay between both EEG and LFP
end

% WALK WITH STOPS - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.WalkWS = [];
subjectdata.signalpoint.WalkWS.EEG_signal       = 9091;                                                                         % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.WalkWS.LFP_signal       = 7806;                                                                         % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.WalkWS.LFP_signal > subjectdata.signalpoint.WalkWS.EEG_signal;                                       % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.WalkWS.delay = subjectdata.signalpoint.WalkWS.LFP_signal - subjectdata.signalpoint.WalkWS.EEG_signal;% Find time-delay between both EEG and LFP
else subjectdata.signalpoint.WalkWS.EEG_signal > subjectdata.signalpoint.WalkWS.LFP_signal;                                     % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.WalkWS.delay = subjectdata.signalpoint.WalkWS.EEG_signal - subjectdata.signalpoint.WalkWS.LFP_signal;% Find time-delay between both EEG and LFP
end 


% INTERFERENCE - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Interf = [];
subjectdata.signalpoint.Interf.EEG_signal       = 9230;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Interf.LFP_signal       = 7704;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Interf.LFP_signal > subjectdata.signalpoint.Interf.EEG_signal;                                       % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Interf.delay = subjectdata.signalpoint.Interf.LFP_signal - subjectdata.signalpoint.Interf.EEG_signal;% find time-delay between both EEG and LFP
else subjectdata.signalpoint.Interf.EEG_signal > subjectdata.signalpoint.Interf.LFP_signal;                                     % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Interf.delay = subjectdata.signalpoint.Interf.EEG_signal - subjectdata.signalpoint.Interf.LFP_signal;% Find time-delay between both EEG and LFP
end 


%=== FILTERED GAIT EVENTS FOR WALK ONLY ===
% Manual input for filtered gait events based on exact timings of heelstrikes (not shown here)
subjectdata.events_filt.Walk = struct;

%Walk 1
subjectdata.events_filt.Walk(1).start = 12.4700; 
subjectdata.events_filt.Walk(1).task = 'Walk';
subjectdata.events_filt.Walk(1).end = 18.4380000000000;

%Turn 1
subjectdata.events_filt.Walk(2).start =  19.3690000000000;
subjectdata.events_filt.Walk(2).task = 'Turn';
subjectdata.events_filt.Walk(2).end = 24.7090000000000;

%Freezing while turning
subjectdata.events_filt.Walk(3).start =  20.2330000000000;
subjectdata.events_filt.Walk(3).task = 'Freezing_turn';
subjectdata.events_filt.Walk(3).end = 24.7090000000000;

%Walk
subjectdata.events_filt.Walk(4).start =  25.7040000000000;
subjectdata.events_filt.Walk(4).task = 'Walk';
subjectdata.events_filt.Walk(4).end = 32.4300000000000;

%Turn
subjectdata.events_filt.Walk(5).start =  33.0020000000000;
subjectdata.events_filt.Walk(5).task = 'Turn';
subjectdata.events_filt.Walk(5).end = 37.713;

%Freezing while turning
subjectdata.events_filt.Walk(6).start =  33.8540000000000;
subjectdata.events_filt.Walk(6).task = 'Freezing_turn';
subjectdata.events_filt.Walk(6).end = 36.8810000000000;

%Walk
subjectdata.events_filt.Walk(7).start =  38.1000000000000;
subjectdata.events_filt.Walk(7).task = 'Walk';
subjectdata.events_filt.Walk(7).end = 42.8940000000000;

%Walk
subjectdata.events_filt.Walk(8).start =  50.116;
subjectdata.events_filt.Walk(8).task = 'Walk';
subjectdata.events_filt.Walk(8).end = 55.8940000000000;

%Turn
subjectdata.events_filt.Walk(9).start =  56.8490000000000;
subjectdata.events_filt.Walk(9).task = 'Turn';
subjectdata.events_filt.Walk(9).end = 62.9390000000000;

%Freezing while turning
subjectdata.events_filt.Walk(10).start =  57.8290000000000;
subjectdata.events_filt.Walk(10).task = 'Freezing_turn';
subjectdata.events_filt.Walk(10).end = 62.4870000000000;

%Walk
subjectdata.events_filt.Walk(11).start =  63.7860000000000;
subjectdata.events_filt.Walk(11).task = 'Walk';
subjectdata.events_filt.Walk(11).end = 69.3010000000000;

%Turn
subjectdata.events_filt.Walk(12).start =  69.8040000000000;
subjectdata.events_filt.Walk(12).task = 'Turn';
subjectdata.events_filt.Walk(12).end = 76.8580000000000;

%Freezing while turning
subjectdata.events_filt.Walk(13).start =  70.8640000000000;
subjectdata.events_filt.Walk(13).task = 'Freezing_turn';
subjectdata.events_filt.Walk(13).end = 76.8580000000000;

%Walk
subjectdata.events_filt.Walk(14).start =  78.6910;
subjectdata.events_filt.Walk(14).task = 'Walk';
subjectdata.events_filt.Walk(14).end = 85.2010000000000;

%Turn
subjectdata.events_filt.Walk(15).start =  85.6440000000000;
subjectdata.events_filt.Walk(15).task = 'Turn';
subjectdata.events_filt.Walk(15).end = 91.8350000000000;

%Freezing while turning
subjectdata.events_filt.Walk(16).start =  86.6820000000000;
subjectdata.events_filt.Walk(16).task = 'Freezing_turn';
subjectdata.events_filt.Walk(16).end = 90.4690000000000;

%Walk
subjectdata.events_filt.Walk(17).start =  94.5630000000000;
subjectdata.events_filt.Walk(17).task = 'Walk';
subjectdata.events_filt.Walk(17).end = 99.1570000000000;

%Turn
subjectdata.events_filt.Walk(18).start =  100.130000000000;
subjectdata.events_filt.Walk(18).task = 'Turn';
subjectdata.events_filt.Walk(18).end = 107.381000000000;

%Freezing while turning
subjectdata.events_filt.Walk(19).start =  101.632000000000;
subjectdata.events_filt.Walk(19).task = 'Freezing_turn';
subjectdata.events_filt.Walk(19).end = 103.757000000000;

%Walk
subjectdata.events_filt.Walk(20).start =  110.969000000000;
subjectdata.events_filt.Walk(20).task = 'Walk';
subjectdata.events_filt.Walk(20).end = 116.027000000000;

%Turn
subjectdata.events_filt.Walk(21).start =  116.553000000000;
subjectdata.events_filt.Walk(21).task = 'Turn';
subjectdata.events_filt.Walk(21).end = 120.718000000000;

%Walk
subjectdata.events_filt.Walk(22).start =  121.114000000000;
subjectdata.events_filt.Walk(22).task = 'Walk';
subjectdata.events_filt.Walk(22).end = 127.201000000000;

%Walk
subjectdata.events_filt.Walk(23).start =  137.091000000000;
subjectdata.events_filt.Walk(23).task = 'Walk';
subjectdata.events_filt.Walk(23).end = 141.648000000000;

%Turn
subjectdata.events_filt.Walk(24).start =  143.023000000000;
subjectdata.events_filt.Walk(24).task = 'Turn';
subjectdata.events_filt.Walk(24).end = 148.750000000000;

%Freezing while turning
subjectdata.events_filt.Walk(25).start =  146.500000000000;
subjectdata.events_filt.Walk(25).task = 'Freezing_turn';
subjectdata.events_filt.Walk(25).end = 148.133000000000;

%Walk
subjectdata.events_filt.Walk(26).start =  149.362;
subjectdata.events_filt.Walk(26).task = 'Walk';
subjectdata.events_filt.Walk(26).end = 155.030000000000;

%Turn
subjectdata.events_filt.Walk(27).start =  155.594;
subjectdata.events_filt.Walk(27).task = 'Turn';
subjectdata.events_filt.Walk(27).end = 163.544000000000;

%Freezing while turning
subjectdata.events_filt.Walk(28).start =  156.564000000000;
subjectdata.events_filt.Walk(28).task = 'Freezing_turn';
subjectdata.events_filt.Walk(28).end = 163.544000000000;

%WAalk
subjectdata.events_filt.Walk(29).start =  164.756000000000;
subjectdata.events_filt.Walk(29).task = 'Walk';
subjectdata.events_filt.Walk(29).end = 170.109000000000;

%Turn
subjectdata.events_filt.Walk(30).start =  171.009000000000;
subjectdata.events_filt.Walk(30).task = 'Turn';
subjectdata.events_filt.Walk(30).end = 182.752000000000;

%Freezing while turning
subjectdata.events_filt.Walk(31).start =  172.289000000000;
subjectdata.events_filt.Walk(31).task = 'Freezing_turn';
subjectdata.events_filt.Walk(31).end = 182.752000000000;

%Walk
subjectdata.events_filt.Walk(32).start =  184.216000000000;
subjectdata.events_filt.Walk(32).task = 'Walk';
subjectdata.events_filt.Walk(32).end = 187.532000000000;

%Turn
subjectdata.events_filt.Walk(33).start =  188.839000000000;
subjectdata.events_filt.Walk(33).task = 'Turn';
subjectdata.events_filt.Walk(33).end = 199.538000000000;

%Freezing while turning
subjectdata.events_filt.Walk(34).start =  190.359000000000;
subjectdata.events_filt.Walk(34).task = 'Freezing_turn';
subjectdata.events_filt.Walk(34).end = 199.538000000000;

%Walk
subjectdata.events_filt.Walk(35).start =  201.239000000000;
subjectdata.events_filt.Walk(35).task = 'Walk';
subjectdata.events_filt.Walk(35).end = 206.580000000000;

%Turn
subjectdata.events_filt.Walk(36).start =  207.108000000000;
subjectdata.events_filt.Walk(36).task = 'Turn';
subjectdata.events_filt.Walk(36).end = 214.558000000000;

%Freezing while turning
subjectdata.events_filt.Walk(37).start =  208.239000000000;
subjectdata.events_filt.Walk(37).task = 'Freezing_turn';
subjectdata.events_filt.Walk(37).end = 213.434000000000;

%Walk
subjectdata.events_filt.Walk(38).start =  215.919000000000;
subjectdata.events_filt.Walk(38).task = 'Walk';
subjectdata.events_filt.Walk(38).end = 221.263000000000;

%Turn
subjectdata.events_filt.Walk(39).start =  222.719000000000;
subjectdata.events_filt.Walk(39).task = 'Turn';
subjectdata.events_filt.Walk(39).end = 234.817000000000;

%Freezing while turning
subjectdata.events_filt.Walk(40).start =  225.252000000000;
subjectdata.events_filt.Walk(40).task = 'Freezing_turn';
subjectdata.events_filt.Walk(40).end = 234.817000000000;

%Freezing while walking
subjectdata.events_filt.Walk(41).start =  128.930000000000;
subjectdata.events_filt.Walk(41).task = 'Freezing_walk';
subjectdata.events_filt.Walk(41).end = 131.174000000000;



%=== FILTERED GAIT EVENTS FOR WALK WITH INTERFERENCE ONLY ===
%Manual Input for Filtered Gait Events based on the exact timings of heelstrike events (not shown here)
subjectdata.events_filt.WalkINT = struct;

%Walk
subjectdata.events_filt.WalkINT(1).task = 'Walk'; 
subjectdata.events_filt.WalkINT(1).start = 11.5890000000000; 
subjectdata.events_filt.WalkINT(1).end = 19;

%Turn
subjectdata.events_filt.WalkINT(2).task = 'Turn'; 
subjectdata.events_filt.WalkINT(2).start = 21.3530000000000; 
subjectdata.events_filt.WalkINT(2).end = 26.7340000000000;

%Freezing while turning
subjectdata.events_filt.WalkINT(3).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT(3).start = 21.7520000000000; 
subjectdata.events_filt.WalkINT(3).end = 26.7340000000000;

%Walk
subjectdata.events_filt.WalkINT(4).task = 'Walk'; 
subjectdata.events_filt.WalkINT(4).start = 32.2470000000000; 
subjectdata.events_filt.WalkINT(4).end = 42.0990000000000;

%Turn
subjectdata.events_filt.WalkINT(5).task = 'Turn'; 
subjectdata.events_filt.WalkINT(5).start = 43.7900000000000; 
subjectdata.events_filt.WalkINT(5).end = 54.2290000000000;

%Freezing while turning
subjectdata.events_filt.WalkINT(6).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT(6).start = 44.8070000000000; 
subjectdata.events_filt.WalkINT(6).end = 54.2290000000000;

%Walk
subjectdata.events_filt.WalkINT(7).task = 'Walk'; 
subjectdata.events_filt.WalkINT(7).start = 55.0730000000000; 
subjectdata.events_filt.WalkINT(7).end = 63.0680000000000;

%Turn
subjectdata.events_filt.WalkINT(8).task = 'Turn'; 
subjectdata.events_filt.WalkINT(8).start = 63.9700000000000; 
subjectdata.events_filt.WalkINT(8).end = 73.2800000000000;

%Freezing while turning
subjectdata.events_filt.WalkINT(9).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT(9).start = 64.7880000000000; 
subjectdata.events_filt.WalkINT(9).end = 73.2800000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT(10).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(10).start = 86.5300000000000; 
subjectdata.events_filt.WalkINT(10).end = 88.5740000000000;

%
subjectdata.events_filt.WalkINT(11).task = 'Walk'; 
subjectdata.events_filt.WalkINT(11).start = 117.675000000000; 
subjectdata.events_filt.WalkINT(11).end = 125.290000000000;

%Walk
subjectdata.events_filt.WalkINT(12).task = 'Walk'; 
subjectdata.events_filt.WalkINT(12).start = 150.015000000000; 
subjectdata.events_filt.WalkINT(12).end = 157.082000000000;

%Turn
subjectdata.events_filt.WalkINT(13).task = 'Turn'; 
subjectdata.events_filt.WalkINT(13).start = 159.896000000000; 
subjectdata.events_filt.WalkINT(13).end = 178.764000000000;

%Freezing while tunring
subjectdata.events_filt.WalkINT(14).task = 'Freezing_turn_start'; 
subjectdata.events_filt.WalkINT(14).start = 160.673000000000; 
subjectdata.events_filt.WalkINT(14).end = 171.116;

%Turn
subjectdata.events_filt.WalkINT(15).task = 'Turn'; 
subjectdata.events_filt.WalkINT(15).start = 198.038000000000; 
subjectdata.events_filt.WalkINT(15).end = 241.060000000000;

%Freezing while turning
subjectdata.events_filt.WalkINT(16).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT(16).start = 198.357000000000; 
subjectdata.events_filt.WalkINT(16).end = 241.060000000000;

%Turn
subjectdata.events_filt.WalkINT(17).task = 'Turn'; 
subjectdata.events_filt.WalkINT(17).start = 257.432000000000; 
subjectdata.events_filt.WalkINT(17).end = 291.555000000000;

%Freezing while turning
subjectdata.events_filt.WalkINT(18).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT(18).start = 258.231000000000; 
subjectdata.events_filt.WalkINT(18).end = 291.555000000000;

%Walk
subjectdata.events_filt.WalkINT(19).task = 'Walk'; 
subjectdata.events_filt.WalkINT(19).start = 292.374000000000; 
subjectdata.events_filt.WalkINT(19).end = 301.615000000000;

%Turn
subjectdata.events_filt.WalkINT(20).task = 'Turn'; 
subjectdata.events_filt.WalkINT(20).start = 302.172000000000; 
subjectdata.events_filt.WalkINT(20).end = 329.307000000000;

%Freezing while turning
subjectdata.events_filt.WalkINT(21).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT(21).start = 302.419000000000; 
subjectdata.events_filt.WalkINT(21).end = 329.307000000000;


% ===== Save DATA ====================================================================================================
save([path filesep subjectdata.subject_dir '_datafile.mat'], 'subjectdata', '-mat')

% *********************** END OF SCRIPT *******************************************************************************************************************
