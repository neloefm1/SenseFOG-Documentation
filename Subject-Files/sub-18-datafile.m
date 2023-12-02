%% sub-18-datafile.m ====================================================
% +------------------------------------------------------+
% |  Subject: SUB-18                                     |
% |                                                      |
% | Author: Philipp Klocke,Moritz Loeffler               | 
% +------------------------------------------------------+

% This script will serve as the main directory matlab file for sub-18

% Chose the pathway for the SenseFOG-main folder after downloading
subjectdata.generalpath     = uigetdir;                                                                                         % Target file should be the SenseFOG-main file after download
subjectdata.filedir         = 'sub-18';
subjectdata.subjectnr       = '18';
subjectdata.subject_dir     = 'sub-18';
path                        = append(subjectdata.generalpath, '/', subjectdata.filedir);
cd(path)



% SIT - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Sit = [];
subjectdata.signalpoint.Sit.EEG_signal          = 16578;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Sit.LFP_signal          = 11547;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Sit.LFP_signal > subjectdata.signalpoint.Sit.EEG_signal;                                             % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Sit.delay = subjectdata.signalpoint.Sit.LFP_signal - subjectdata.signalpoint.Sit.EEG_signal;         % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Sit.EEG_signal > subjectdata.signalpoint.Sit.LFP_signal;                                           % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Sit.delay = subjectdata.signalpoint.Sit.EEG_signal - subjectdata.signalpoint.Sit.LFP_signal;       % Find time-delay between both EEG and LFP
end 


% STAND - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Stand = [];
subjectdata.signalpoint.Stand.EEG_signal        = 11806;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Stand.LFP_signal        = 9621;                                                                         % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Stand.LFP_signal > subjectdata.signalpoint.Stand.EEG_signal;                                         % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Stand.delay = subjectdata.signalpoint.Stand.LFP_signal - subjectdata.signalpoint.Stand.EEG_signal;   % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Stand.EEG_signal > subjectdata.signalpoint.Stand.LFP_signal;                                       % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Stand.delay = subjectdata.signalpoint.Stand.EEG_signal - subjectdata.signalpoint.Stand.LFP_signal; % Find time-delay between both EEG and LFP
end 

% WALK - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Walk = [];
subjectdata.signalpoint.Walk.EEG_signal         = 10127;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Walk.LFP_signal         = 8265;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Walk.LFP_signal > subjectdata.signalpoint.Walk.EEG_signal;                                           % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Walk.delay = subjectdata.signalpoint.Walk.LFP_signal - subjectdata.signalpoint.Walk.EEG_signal;      % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Walk.EEG_signal > subjectdata.signalpoint.Walk.LFP_signal;                                         % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Walk.delay = subjectdata.signalpoint.Walk.EEG_signal - subjectdata.signalpoint.Walk.LFP_signal;    % Find time-delay between both EEG and LFP
end

% WALK WITH STOPS - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.WalkWS = [];
subjectdata.signalpoint.WalkWS.EEG_signal       = 11393;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.WalkWS.LFP_signal       = 9446;                                                                         % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.WalkWS.LFP_signal > subjectdata.signalpoint.WalkWS.EEG_signal;                                       % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.WalkWS.delay = subjectdata.signalpoint.WalkWS.LFP_signal - subjectdata.signalpoint.WalkWS.EEG_signal;% Find time-delay between both EEG and LFP
else subjectdata.signalpoint.WalkWS.EEG_signal > subjectdata.signalpoint.WalkWS.LFP_signal;                                     % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.WalkWS.delay = subjectdata.signalpoint.WalkWS.EEG_signal - subjectdata.signalpoint.WalkWS.LFP_signal;% Find time-delay between both EEG and LFP
end 


% INTERFERENCE - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Interf = [];
subjectdata.signalpoint.Interf.EEG_signal       = 10520;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Interf.LFP_signal       = 8546;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Interf.LFP_signal > subjectdata.signalpoint.Interf.EEG_signal;                                       % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Interf.delay = subjectdata.signalpoint.Interf.LFP_signal - subjectdata.signalpoint.Interf.EEG_signal;% find time-delay between both EEG and LFP
else subjectdata.signalpoint.Interf.EEG_signal > subjectdata.signalpoint.Interf.LFP_signal;                                     % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Interf.delay = subjectdata.signalpoint.Interf.EEG_signal - subjectdata.signalpoint.Interf.LFP_signal;% Find time-delay between both EEG and LFP
end 


%=== FILTERED GAIT EVENTS FOR WALK ONLY ===
% Manual input for filtered gait events based on exact timings of heelstrikes (not shown here)
subjectdata.events_filt.Walk = struct;

%Walk 1
subjectdata.events_filt.Walk(1).start = 12.6810000000000; 
subjectdata.events_filt.Walk(1).task = 'Walk';
subjectdata.events_filt.Walk(1).end = 17.4890000000000;

%Turn 1
subjectdata.events_filt.Walk(2).start =  18.7880000000000;
subjectdata.events_filt.Walk(2).task = 'Turn';
subjectdata.events_filt.Walk(2).end = 22.529;

%Walk 
subjectdata.events_filt.Walk(3).start = 23.1790000000000; 
subjectdata.events_filt.Walk(3).task = 'Walk';
subjectdata.events_filt.Walk(3).end = 28.3260000000000;

%Turn 
subjectdata.events_filt.Walk(4).start =  29.0250000000000;
subjectdata.events_filt.Walk(4).task = 'Turn';
subjectdata.events_filt.Walk(4).end = 32.387;

%Walk 
subjectdata.events_filt.Walk(5).start = 33.817; 
subjectdata.events_filt.Walk(5).task = 'Walk';
subjectdata.events_filt.Walk(5).end = 38.9890000000000;

%Turn 
subjectdata.events_filt.Walk(6).start =  39.6060000000000;
subjectdata.events_filt.Walk(6).task = 'Turn';
subjectdata.events_filt.Walk(6).end = 42.3810000000000;

%Walk 
subjectdata.events_filt.Walk(7).start = 43.9720000000000; 
subjectdata.events_filt.Walk(7).task = 'Walk';
subjectdata.events_filt.Walk(7).end = 49.4860000000000;

%Turn 
subjectdata.events_filt.Walk(8).start =  50.1710000000000;
subjectdata.events_filt.Walk(8).task = 'Turn';
subjectdata.events_filt.Walk(8).end = 53.703;

%Walk 
subjectdata.events_filt.Walk(9).start = 55.111; 
subjectdata.events_filt.Walk(9).task = 'Walk';
subjectdata.events_filt.Walk(9).end = 58.9510000000000;

%Turn 
subjectdata.events_filt.Walk(10).start =  59.6260000000000;
subjectdata.events_filt.Walk(10).task = 'Turn';
subjectdata.events_filt.Walk(10).end = 62.9080000000000;

%Walk 
subjectdata.events_filt.Walk(11).start = 64.3960000000000; 
subjectdata.events_filt.Walk(11).task = 'Walk';
subjectdata.events_filt.Walk(11).end = 68.6220000000000;

%Turn 
subjectdata.events_filt.Walk(12).start =  69.9220000000000;
subjectdata.events_filt.Walk(12).task = 'Turn';
subjectdata.events_filt.Walk(12).end = 73.184;

%Walk 
subjectdata.events_filt.Walk(13).start = 73.8010000000000; 
subjectdata.events_filt.Walk(13).task = 'Walk';
subjectdata.events_filt.Walk(13).end = 78.8320000000000;

%Turn 
subjectdata.events_filt.Walk(14).start =  80.1780000000000;
subjectdata.events_filt.Walk(14).task = 'Turn';
subjectdata.events_filt.Walk(14).end = 83.568;

%Walk 
subjectdata.events_filt.Walk(15).start = 84.2300000000000; 
subjectdata.events_filt.Walk(15).task = 'Walk';
subjectdata.events_filt.Walk(15).end = 89.9470000000000;

%Turn 
subjectdata.events_filt.Walk(16).start =  90.6140000000000;
subjectdata.events_filt.Walk(16).task = 'Turn';
subjectdata.events_filt.Walk(16).end = 94.286;

%Walk 
subjectdata.events_filt.Walk(17).start = 94.9800000000000; 
subjectdata.events_filt.Walk(17).task = 'Walk';
subjectdata.events_filt.Walk(17).end = 100.312000000000;

%Turn 
subjectdata.events_filt.Walk(18).start =  100.926000000000;
subjectdata.events_filt.Walk(18).task = 'Turn';
subjectdata.events_filt.Walk(18).end = 104.390000000000;

%Walk 
subjectdata.events_filt.Walk(19).start = 105.150000000000; 
subjectdata.events_filt.Walk(19).task = 'Walk';
subjectdata.events_filt.Walk(19).end = 110.736000000000;

%Turn 
subjectdata.events_filt.Walk(20).start =  112.111000000000;
subjectdata.events_filt.Walk(20).task = 'Turn';
subjectdata.events_filt.Walk(20).end = 115.678;

%Walk 
subjectdata.events_filt.Walk(21).start = 117.194; 
subjectdata.events_filt.Walk(21).task = 'Walk';
subjectdata.events_filt.Walk(21).end = 122.540000000000;

%Turn 
subjectdata.events_filt.Walk(22).start =  123.883000000000;
subjectdata.events_filt.Walk(22).task = 'Turn';
subjectdata.events_filt.Walk(22).end = 127.501000000000;

%Turn 
subjectdata.events_filt.Walk(23).start =  135.359000000000;
subjectdata.events_filt.Walk(23).task = 'Turn';
subjectdata.events_filt.Walk(23).end = 138.638000000000;

%Walk 
subjectdata.events_filt.Walk(24).start = 139.361000000000; 
subjectdata.events_filt.Walk(24).task = 'Walk';
subjectdata.events_filt.Walk(24).end = 145.032000000000;

%Turn 
subjectdata.events_filt.Walk(25).start =  145.740000000000;
subjectdata.events_filt.Walk(25).task = 'Turn';
subjectdata.events_filt.Walk(25).end = 149.067;

%Walk 
subjectdata.events_filt.Walk(26).start = 149.624000000000; 
subjectdata.events_filt.Walk(26).task = 'Walk';
subjectdata.events_filt.Walk(26).end = 153.827000000000;

%Turn 
subjectdata.events_filt.Walk(27).start =  154.562000000000;
subjectdata.events_filt.Walk(27).task = 'Turn';
subjectdata.events_filt.Walk(27).end = 158.185000000000;

%Walk 
subjectdata.events_filt.Walk(28).start = 159.032000000000; 
subjectdata.events_filt.Walk(28).task = 'Walk';
subjectdata.events_filt.Walk(28).end = 162.814000000000;

%Walk 
subjectdata.events_filt.Walk(29).start = 167.171000000000; 
subjectdata.events_filt.Walk(29).task = 'Walk';
subjectdata.events_filt.Walk(29).end = 172.847000000000;

%Turn 
subjectdata.events_filt.Walk(30).start =  173.472000000000;
subjectdata.events_filt.Walk(30).task = 'Turn';
subjectdata.events_filt.Walk(30).end = 177.077000000000;

%Walk 
subjectdata.events_filt.Walk(31).start = 177.924000000000; 
subjectdata.events_filt.Walk(31).task = 'Walk';
subjectdata.events_filt.Walk(31).end = 182.013000000000;

%Turn 
subjectdata.events_filt.Walk(32).start =  182.638000000000;
subjectdata.events_filt.Walk(32).task = 'Turn';
subjectdata.events_filt.Walk(32).end = 185.942000000000;

%Walk 
subjectdata.events_filt.Walk(33).start = 186.546000000000; 
subjectdata.events_filt.Walk(33).task = 'Walk';
subjectdata.events_filt.Walk(33).end = 190.728000000000;

%Turn 
subjectdata.events_filt.Walk(34).start =  192.079000000000;
subjectdata.events_filt.Walk(34).task = 'Turn';
subjectdata.events_filt.Walk(34).end = 194.915000000000;

%Walk 
subjectdata.events_filt.Walk(35).start = 195.673000000000; 
subjectdata.events_filt.Walk(35).task = 'Walk';
subjectdata.events_filt.Walk(35).end = 199.043000000000;

%Turn, omit because too short 
%subjectdata.events_filt.Walk(36).start =  201.668000000000;
%subjectdata.events_filt.Walk(36).task = 'Turn';
%subjectdata.events_filt.Walk(36).end = 203.099000000000;

%Walk 
subjectdata.events_filt.Walk(37).start = 204.718000000000; 
subjectdata.events_filt.Walk(37).task = 'Walk';
subjectdata.events_filt.Walk(37).end = 207.653000000000;

%Turn 
subjectdata.events_filt.Walk(38).start =  209.033000000000;
subjectdata.events_filt.Walk(38).task = 'Turn';
subjectdata.events_filt.Walk(38).end = 212.960000000000;

%Walk 
subjectdata.events_filt.Walk(39).start = 214.521000000000; 
subjectdata.events_filt.Walk(39).task = 'Walk';
subjectdata.events_filt.Walk(39).end = 217.285000000000;

%Turn 
subjectdata.events_filt.Walk(40).start =  217.959000000000;
subjectdata.events_filt.Walk(40).task = 'Turn';
subjectdata.events_filt.Walk(40).end = 221.416000000000;

%Walk 
subjectdata.events_filt.Walk(41).start = 222.124000000000; 
subjectdata.events_filt.Walk(41).task = 'Walk';
subjectdata.events_filt.Walk(41).end = 226.336000000000;

%Turn 
subjectdata.events_filt.Walk(42).start =  227.032000000000;
subjectdata.events_filt.Walk(42).task = 'Turn';
subjectdata.events_filt.Walk(42).end = 230.955000000000;

%Walk 
subjectdata.events_filt.Walk(43).start = 231.661000000000; 
subjectdata.events_filt.Walk(43).task = 'Walk';
subjectdata.events_filt.Walk(43).end = 236.063000000000;

%Turn 
subjectdata.events_filt.Walk(44).start =  236.641000000000;
subjectdata.events_filt.Walk(44).task = 'Turn';
subjectdata.events_filt.Walk(44).end = 240.463;

%Walk 
subjectdata.events_filt.Walk(45).start = 241.291000000000; 
subjectdata.events_filt.Walk(45).task = 'Walk';
subjectdata.events_filt.Walk(45).end = 245.616000000000;

%Turn 
subjectdata.events_filt.Walk(46).start =  246.307000000000;
subjectdata.events_filt.Walk(46).task = 'Turn';
subjectdata.events_filt.Walk(46).end = 249.786000000000;

%Walk 
subjectdata.events_filt.Walk(47).start = 250.603000000000; 
subjectdata.events_filt.Walk(47).task = 'Walk';
subjectdata.events_filt.Walk(47).end = 253.562000000000;

%Turn 
subjectdata.events_filt.Walk(48).start =  255.591000000000;
subjectdata.events_filt.Walk(48).task = 'Turn';
subjectdata.events_filt.Walk(48).end = 258.276000000000;

%Walk 
subjectdata.events_filt.Walk(49).start = 258.957000000000; 
subjectdata.events_filt.Walk(49).task = 'Walk';
subjectdata.events_filt.Walk(49).end = 263.249000000000;

%Turn 
subjectdata.events_filt.Walk(50).start =  264.493000000000;
subjectdata.events_filt.Walk(50).task = 'Turn';
subjectdata.events_filt.Walk(50).end = 267.364000000000;

%Walk 
subjectdata.events_filt.Walk(51).start = 268.078000000000; 
subjectdata.events_filt.Walk(51).task = 'Walk';
subjectdata.events_filt.Walk(51).end = 270.894000000000;

%Turn 
subjectdata.events_filt.Walk(52).start =  272.304000000000;
subjectdata.events_filt.Walk(52).task = 'Turn';
subjectdata.events_filt.Walk(52).end = 276.182;
%Walk 
subjectdata.events_filt.Walk(53).start = 276.855000000000; 
subjectdata.events_filt.Walk(53).task = 'Walk';
subjectdata.events_filt.Walk(53).end = 280.963000000000;



%=== FILTERED GAIT EVENTS FOR WALK WITH INTERFERENCE ONLY ===
%Manual Input for Filtered Gait Events based on the exact timings of heelstrike events (not shown here)
subjectdata.events_filt.WalkINT = struct;


%Walk
subjectdata.events_filt.WalkINT(1).task = 'Walk'; 
subjectdata.events_filt.WalkINT(1).start = 11.6900000000000; 
subjectdata.events_filt.WalkINT(1).end = 17.9750000000000;

%Walk
subjectdata.events_filt.WalkINT(2).task = 'Turn'; 
subjectdata.events_filt.WalkINT(2).start = 18.5900000000000; 
subjectdata.events_filt.WalkINT(2).end = 21.871;

%Walk
subjectdata.events_filt.WalkINT(3).task = 'Walk'; 
subjectdata.events_filt.WalkINT(3).start = 22.5590000000000; 
subjectdata.events_filt.WalkINT(3).end = 26.7770000000000;

%Turn
subjectdata.events_filt.WalkINT(4).task = 'Turn'; 
subjectdata.events_filt.WalkINT(4).start = 28.1990000000000; 
subjectdata.events_filt.WalkINT(4).end = 31.525;

%Walk
subjectdata.events_filt.WalkINT(5).task = 'Walk'; 
subjectdata.events_filt.WalkINT(5).start = 32.1400000000000; 
subjectdata.events_filt.WalkINT(5).end = 34.9170000000000;

%Turn
subjectdata.events_filt.WalkINT(6).task = 'Turn'; 
subjectdata.events_filt.WalkINT(6).start = 36.3540000000000; 
subjectdata.events_filt.WalkINT(6).end = 39.9490000000000;

%Walk
subjectdata.events_filt.WalkINT(7).task = 'Walk'; 
subjectdata.events_filt.WalkINT(7).start = 41.6780000000000; 
subjectdata.events_filt.WalkINT(7).end = 45.0410000000000;

%Turn
subjectdata.events_filt.WalkINT(8).task = 'Turn'; 
subjectdata.events_filt.WalkINT(8).start = 46.4220000000000; 
subjectdata.events_filt.WalkINT(8).end = 50.568;

%Walk
subjectdata.events_filt.WalkINT(9).task = 'Walk'; 
subjectdata.events_filt.WalkINT(9).start = 52.125; 
subjectdata.events_filt.WalkINT(9).end = 53.8860000000000;

%Turn
subjectdata.events_filt.WalkINT(10).task = 'Turn'; 
subjectdata.events_filt.WalkINT(10).start = 58.3750000000000; 
subjectdata.events_filt.WalkINT(10).end = 62.9500000000000;

%TUrn
subjectdata.events_filt.WalkINT(11).task = 'Walk'; 
subjectdata.events_filt.WalkINT(11).start = 64.8800000000000; 
subjectdata.events_filt.WalkINT(11).end = 67.9420000000000;

%Turn
subjectdata.events_filt.WalkINT(12).task = 'Turn'; 
subjectdata.events_filt.WalkINT(12).start = 69.4660000000000; 
subjectdata.events_filt.WalkINT(12).end = 72.957;

%Walk
subjectdata.events_filt.WalkINT(13).task = 'Walk'; 
subjectdata.events_filt.WalkINT(13).start = 73.6050000000000; 
subjectdata.events_filt.WalkINT(13).end = 78.3140000000000;

%Turn
subjectdata.events_filt.WalkINT(14).task = 'Turn'; 
subjectdata.events_filt.WalkINT(14).start = 79.8720000000000; 
subjectdata.events_filt.WalkINT(14).end = 82.6660000000000;

%WAlk
subjectdata.events_filt.WalkINT(15).task = 'Walk'; 
subjectdata.events_filt.WalkINT(15).start = 84.2150000000000; 
subjectdata.events_filt.WalkINT(15).end = 88.8790000000000;

%Turn
subjectdata.events_filt.WalkINT(16).task = 'Turn'; 
subjectdata.events_filt.WalkINT(16).start = 89.6050000000000; 
subjectdata.events_filt.WalkINT(16).end = 93.342;

%Walk
subjectdata.events_filt.WalkINT(17).task = 'Walk'; 
subjectdata.events_filt.WalkINT(17).start = 94.7970; 
subjectdata.events_filt.WalkINT(17).end = 99.3490000000000;

%Turn
subjectdata.events_filt.WalkINT(18).task = 'Turn'; 
subjectdata.events_filt.WalkINT(18).start = 100.095000000000; 
subjectdata.events_filt.WalkINT(18).end = 104.192;

%Walk
subjectdata.events_filt.WalkINT(19).task = 'Walk'; 
subjectdata.events_filt.WalkINT(19).start = 104.934000000000; 
subjectdata.events_filt.WalkINT(19).end = 109.725000000000;

%Turn
subjectdata.events_filt.WalkINT(20).task = 'Turn'; 
subjectdata.events_filt.WalkINT(20).start = 111.276000000000; 
subjectdata.events_filt.WalkINT(20).end = 115.01;

%WAlk
subjectdata.events_filt.WalkINT(21).task = 'Walk'; 
subjectdata.events_filt.WalkINT(21).start = 115.628000000000; 
subjectdata.events_filt.WalkINT(21).end = 120.554000000000;

%Turn
subjectdata.events_filt.WalkINT(22).task = 'Turn'; 
subjectdata.events_filt.WalkINT(22).start = 121.313000000000; 
subjectdata.events_filt.WalkINT(22).end = 124.893000000000;

%Walk
subjectdata.events_filt.WalkINT(23).task = 'Walk'; 
subjectdata.events_filt.WalkINT(23).start = 126.760000000000; 
subjectdata.events_filt.WalkINT(23).end = 131.802000000000;

%Turn
subjectdata.events_filt.WalkINT(24).task = 'Turn'; 
subjectdata.events_filt.WalkINT(24).start = 133.420000000000; 
subjectdata.events_filt.WalkINT(24).end = 137.900000000000;

%Walk
subjectdata.events_filt.WalkINT(25).task = 'Walk'; 
subjectdata.events_filt.WalkINT(25).start = 139.466000000000; 
subjectdata.events_filt.WalkINT(25).end = 144.240000000000;

%Walk
subjectdata.events_filt.WalkINT(26).task = 'Walk'; 
subjectdata.events_filt.WalkINT(26).start = 152.748000000000; 
subjectdata.events_filt.WalkINT(26).end = 157.713000000000;

%Turn
subjectdata.events_filt.WalkINT(27).task = 'Turn'; 
subjectdata.events_filt.WalkINT(27).start = 159.065000000000; 
subjectdata.events_filt.WalkINT(27).end = 164.207000000000;

%Walk
subjectdata.events_filt.WalkINT(28).task = 'Walk'; 
subjectdata.events_filt.WalkINT(28).start = 165.937000000000; 
subjectdata.events_filt.WalkINT(28).end = 170.848000000000;

%Turn
subjectdata.events_filt.WalkINT(29).task = 'Turn'; 
subjectdata.events_filt.WalkINT(29).start = 172.163000000000; 
subjectdata.events_filt.WalkINT(29).end = 175.812;

%Walk
subjectdata.events_filt.WalkINT(30).task = 'Walk'; 
subjectdata.events_filt.WalkINT(30).start = 176.566000000000; 
subjectdata.events_filt.WalkINT(30).end = 182.601000000000;

%Turn
subjectdata.events_filt.WalkINT(31).task = 'Turn'; 
subjectdata.events_filt.WalkINT(31).start = 183.338000000000; 
subjectdata.events_filt.WalkINT(31).end = 187.01;

%WAlk
subjectdata.events_filt.WalkINT(32).task = 'Walk'; 
subjectdata.events_filt.WalkINT(32).start = 188.534; 
subjectdata.events_filt.WalkINT(32).end = 191.557000000000;

%Turn
subjectdata.events_filt.WalkINT(33).task = 'Turn'; 
subjectdata.events_filt.WalkINT(33).start = 193.061000000000; 
subjectdata.events_filt.WalkINT(33).end = 196.258000000000;

%Walk
subjectdata.events_filt.WalkINT(34).task = 'Walk'; 
subjectdata.events_filt.WalkINT(34).start = 197.950000000000; 
subjectdata.events_filt.WalkINT(34).end = 202.736000000000;


% ===== Save DATA ====================================================================================================
save([path filesep subjectdata.subject_dir '_datafile.mat'], 'subjectdata', '-mat')

% *********************** END OF SCRIPT *******************************************************************************************************************
