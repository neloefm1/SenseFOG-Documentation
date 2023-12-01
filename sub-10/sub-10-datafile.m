%% sub-10-datafile.m ====================================================
% +------------------------------------------------------+
% |  Subject: SUB-10                                     |
% |                                                      |
% | Author: Philipp Klocke,Moritz Löffler                | 
% +------------------------------------------------------+

% This script will serve as the main directory matlab file for sub-01

% Chose the pathway for the SenseFOG-main folder after downloading
subjectdata.generalpath     = uigetdir;                                                                                         % Target file should be the SenseFOG-main file after download
subjectdata.filedir         = 'sub-10';
subjectdata.subjectnr       = '10';
subjectdata.subject_dir     = 'sub-10';
path                        = append(subjectdata.generalpath, '/', subjectdata.filedir);
cd(path)


% SIT - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Sit = [];
subjectdata.signalpoint.Sit.EEG_signal          = 53118;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Sit.LFP_signal          = 29780;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Sit.LFP_signal > subjectdata.signalpoint.Sit.EEG_signal;                                             % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Sit.delay = subjectdata.signalpoint.Sit.LFP_signal - subjectdata.signalpoint.Sit.EEG_signal;         % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Sit.EEG_signal > subjectdata.signalpoint.Sit.LFP_signal;                                           % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Sit.delay = subjectdata.signalpoint.Sit.EEG_signal - subjectdata.signalpoint.Sit.LFP_signal;       % Find time-delay between both EEG and LFP
end 


% STAND - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Stand = [];
subjectdata.signalpoint.Stand.EEG_signal        = 26948;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Stand.LFP_signal        = 30793;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Stand.LFP_signal > subjectdata.signalpoint.Stand.EEG_signal;                                         % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Stand.delay = subjectdata.signalpoint.Stand.LFP_signal - subjectdata.signalpoint.Stand.EEG_signal;   % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Stand.EEG_signal > subjectdata.signalpoint.Stand.LFP_signal;                                       % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Stand.delay = subjectdata.signalpoint.Stand.EEG_signal - subjectdata.signalpoint.Stand.LFP_signal; % Find time-delay between both EEG and LFP
end 

% WALK - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Walk = [];
subjectdata.signalpoint.Walk.EEG_signal         = 23608;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Walk.LFP_signal         = 19551;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Walk.LFP_signal > subjectdata.signalpoint.Walk.EEG_signal;                                           % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Walk.delay = subjectdata.signalpoint.Walk.LFP_signal - subjectdata.signalpoint.Walk.EEG_signal;      % Find time-delay between both EEG and LFP
else subjectdata.signalpoint.Walk.EEG_signal > subjectdata.signalpoint.Walk.LFP_signal;                                         % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Walk.delay = subjectdata.signalpoint.Walk.EEG_signal - subjectdata.signalpoint.Walk.LFP_signal;    % Find time-delay between both EEG and LFP
end

% WALK WITH STOPS - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.WalkWS = [];
subjectdata.signalpoint.WalkWS.EEG_signal       = 22398;                                                                        % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.WalkWS.LFP_signal       = 19072;                                                                        % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.WalkWS.LFP_signal > subjectdata.signalpoint.WalkWS.EEG_signal;                                       % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.WalkWS.delay = subjectdata.signalpoint.WalkWS.LFP_signal - subjectdata.signalpoint.WalkWS.EEG_signal;% Find time-delay between both EEG and LFP
else subjectdata.signalpoint.WalkWS.EEG_signal > subjectdata.signalpoint.WalkWS.LFP_signal;                                     % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.WalkWS.delay = subjectdata.signalpoint.WalkWS.EEG_signal - subjectdata.signalpoint.WalkWS.LFP_signal;% Find time-delay between both EEG and LFP
end 


% INTERFERENCE - Manual Input for EEG and LFP Datasets
subjectdata.signalpoint.Interf = [];
subjectdata.signalpoint.Interf.EEG_signal   = 28392;                                                                            % Sample where DBS Stimulation stops showing a clear downward spike, used for later alignsignals_new.m
subjectdata.signalpoint.Interf.LFP_signal   = 23262;                                                                            % Sample where DBS Stimulation stops showing a clear upward spike, used for later alignsignals_new.m
if subjectdata.signalpoint.Interf.LFP_signal > subjectdata.signalpoint.Interf.EEG_signal;                                       % If clause to see if LFP signal is longer than EEG signal 
   subjectdata.signalpoint.Interf.delay = subjectdata.signalpoint.Interf.LFP_signal - subjectdata.signalpoint.Interf.EEG_signal;% find time-delay between both EEG and LFP
else subjectdata.signalpoint.Interf.EEG_signal > subjectdata.signalpoint.Interf.LFP_signal;                                     % If clause to see if EEG signal is longer than LFP signal
     subjectdata.signalpoint.Interf.delay = subjectdata.signalpoint.Interf.EEG_signal - subjectdata.signalpoint.Interf.LFP_signal;% Find time-delay between both EEG and LFP
end 


%=== FILTERED GAIT EVENTS FOR WALK ONLY ===
% Manual input for filtered gait events based on exact timings of heelstrikes (not shown here)
subjectdata.events_filt.Walk = struct;

%Walk 1
subjectdata.events_filt.Walk(1).start = 27.5240; 
subjectdata.events_filt.Walk(1).task = 'Walk';
subjectdata.events_filt.Walk(1).end = 40.3780;

%Turn 1
subjectdata.events_filt.Walk(2).start =  41.5730;
subjectdata.events_filt.Walk(2).task = 'Turn';
subjectdata.events_filt.Walk(2).end = 46.5790;


%Walk 2
subjectdata.events_filt.Walk(3).start =  47.7920;
subjectdata.events_filt.Walk(3).task = 'Walk';
subjectdata.events_filt.Walk(3).end = 56.5810;


%Turn 2
subjectdata.events_filt.Walk(4).start = 57.8490;
subjectdata.events_filt.Walk(4).task = 'Turn'; 
subjectdata.events_filt.Walk(4).end = 63.281;

%Freezing while turning
subjectdata.events_filt.Walk(5).start =  59.9670;
subjectdata.events_filt.Walk(5).task = 'Freezing_turn';
subjectdata.events_filt.Walk(5).end = 65.1470;

 
%Walk
subjectdata.events_filt.Walk(6).start = 66.4310;
subjectdata.events_filt.Walk(6).task = 'Walk';
subjectdata.events_filt.Walk(6).end = 77.2490;

%Turn
subjectdata.events_filt.Walk(7).start = 78.4980; 
subjectdata.events_filt.Walk(7).task = 'Turn';
subjectdata.events_filt.Walk(7).end = 84.1680;

%Freezing while turning
subjectdata.events_filt.Walk(8).start =  81.0310;
subjectdata.events_filt.Walk(8).task = 'Freezing_turn';
subjectdata.events_filt.Walk(8).end = 84.1680;

%Walk
subjectdata.events_filt.Walk(9).start =  85.5290;
subjectdata.events_filt.Walk(9).task = 'Walk';
subjectdata.events_filt.Walk(9).end = 96.9140;

%Turn
subjectdata.events_filt.Walk(10).start = 98.2060;
subjectdata.events_filt.Walk(10).task = 'Turn'; 
subjectdata.events_filt.Walk(10).end = 104.695;

%Freezing while turning
subjectdata.events_filt.Walk(11).start =  102.8150;
subjectdata.events_filt.Walk(11).task = 'Freezing_turn';
subjectdata.events_filt.Walk(11).end = 107.1520;

%Freezing while walking %After review 07/23 FI not matching but clinically matching, therfore included
subjectdata.events_filt.Walk(12).start =  110.8930;
subjectdata.events_filt.Walk(12).task = 'Freezing_walk';
subjectdata.events_filt.Walk(12).end = 124.2940;

%Freezing while walking 
subjectdata.events_filt.Walk(13).start = 131.6870; 
subjectdata.events_filt.Walk(13).task = 'Freezing_walk';
subjectdata.events_filt.Walk(13).end = 135.6310;

%Turn
subjectdata.events_filt.Walk(14).start =  140.0720;
subjectdata.events_filt.Walk(14).task = 'Turn';
subjectdata.events_filt.Walk(14).end = 146.5640;

%Freezing while turning
subjectdata.events_filt.Walk(15).start =  143.6260;
subjectdata.events_filt.Walk(15).task = 'Freezing_turn';
subjectdata.events_filt.Walk(15).end = 152.6320;

%Walk
subjectdata.events_filt.Walk(16).start =  181.2980;
subjectdata.events_filt.Walk(16).task = 'Walk';
subjectdata.events_filt.Walk(16).end = 183.8440;

%Turn
subjectdata.events_filt.Walk(17).start =  185.0860;
subjectdata.events_filt.Walk(17).task = 'Turn';
subjectdata.events_filt.Walk(17).end = 192.0580;

%Freezing while walking
subjectdata.events_filt.Walk(18).start =  173.8760;
subjectdata.events_filt.Walk(18).task = 'Freezing_walk';
subjectdata.events_filt.Walk(18).end = 180.0800;

%Walk
subjectdata.events_filt.Walk(19).start =  192.5770;
subjectdata.events_filt.Walk(19).task = 'Walk';
subjectdata.events_filt.Walk(19).end = 194.9880;

%Freezing while walking 
subjectdata.events_filt.Walk(20).start = 197.2800;
subjectdata.events_filt.Walk(20).task = 'Freezing_walk';
subjectdata.events_filt.Walk(20).end = 209.2560;

% Walk
subjectdata.events_filt.Walk(21).start = 210.8050;
subjectdata.events_filt.Walk(21).task = 'Walk';
subjectdata.events_filt.Walk(21).end = 219.7680;

% Turn
subjectdata.events_filt.Walk(22).start = 230.7010;
subjectdata.events_filt.Walk(22).task = 'Turn';
subjectdata.events_filt.Walk(22).end = 237.0140;

% Freezing while walking
subjectdata.events_filt.Walk(23).start = 222.2000;
subjectdata.events_filt.Walk(23).task = 'Freezing_turn';
subjectdata.events_filt.Walk(23).end = 230.7010;

%Freezing while walking %After review 07/23 FI not matching but clinically matching, therfore included
subjectdata.events_filt.Walk(24).start = 240.7220;
subjectdata.events_filt.Walk(24).task = 'Freezing_walk';
subjectdata.events_filt.Walk(24).end = 249.9170;

%Walk
subjectdata.events_filt.Walk(25).start = 255.3920;
subjectdata.events_filt.Walk(25).task = 'Walk';
subjectdata.events_filt.Walk(25).end = 265.5610;

%Turn
subjectdata.events_filt.Walk(26).start = 266.8420;
subjectdata.events_filt.Walk(26).task = 'Turn';
subjectdata.events_filt.Walk(26).end = 273.9350;

%Walk
subjectdata.events_filt.Walk(27).start = 275.1760;
subjectdata.events_filt.Walk(27).task = 'Walk';
subjectdata.events_filt.Walk(27).end = 287.1270;

%Turn
subjectdata.events_filt.Walk(28).start = 288.4090;
subjectdata.events_filt.Walk(28).task = 'Turn';
subjectdata.events_filt.Walk(28).end = 294.1560;

%Walk
subjectdata.events_filt.Walk(29).start = 295.4820;
subjectdata.events_filt.Walk(29).task = 'Walk';
subjectdata.events_filt.Walk(29).end = 308.3270;

%Turn
subjectdata.events_filt.Walk(30).start = 309.4990;
subjectdata.events_filt.Walk(30).task = 'Turn';
subjectdata.events_filt.Walk(30).end = 316.3270;

%Freezing while turning
subjectdata.events_filt.Walk(31).start = 312.5640;
subjectdata.events_filt.Walk(31).task = 'Freezing_turn';
subjectdata.events_filt.Walk(31).end = 318.9370;

%Freezing while walking %After review 07/23 FI not matching but clinically matching, therfore included
subjectdata.events_filt.Walk(32).start = 323.7340;
subjectdata.events_filt.Walk(32).task = 'Freezing_walk';
subjectdata.events_filt.Walk(32).end = 337.2320;

%Walk
subjectdata.events_filt.Walk(33).start = 340.5570;
subjectdata.events_filt.Walk(33).task = 'Walk';
subjectdata.events_filt.Walk(33).end = 347.0040;

%Walk
subjectdata.events_filt.Walk(34).start = 356.6200;
subjectdata.events_filt.Walk(34).task = 'Walk';
subjectdata.events_filt.Walk(34).end = 368.8650;

%Turn
subjectdata.events_filt.Walk(35).start = 370.2130;
subjectdata.events_filt.Walk(35).task = 'Turn';
subjectdata.events_filt.Walk(35).end = 377.0170;

%Walk
subjectdata.events_filt.Walk(36).start = 378.8660;
subjectdata.events_filt.Walk(36).task = 'Walk';
subjectdata.events_filt.Walk(36).end = 391.7310;

%Turn
subjectdata.events_filt.Walk(37).start = 392.4010;
subjectdata.events_filt.Walk(37).task = 'Turn';
subjectdata.events_filt.Walk(37).end = 399.1520;

%Walk
subjectdata.events_filt.Walk(38).start = 400.5470;
subjectdata.events_filt.Walk(38).task = 'Walk';
subjectdata.events_filt.Walk(38).end = 413.8860;

%Turn 
subjectdata.events_filt.Walk(39).start = 415.1600;
subjectdata.events_filt.Walk(39).task = 'Turn';
subjectdata.events_filt.Walk(39).end = 419.9810;

%Walk
subjectdata.events_filt.Walk(40).start = 421.6900;
subjectdata.events_filt.Walk(40).task = 'Walk';
subjectdata.events_filt.Walk(40).end = 430.9600;

%Freezing while turning
subjectdata.events_filt.Walk(41).start = 435.2830;
subjectdata.events_filt.Walk(41).task = 'Freezing_turn';
subjectdata.events_filt.Walk(41).end = 453.3070;

%Walk
subjectdata.events_filt.Walk(42).start = 454.7700;
subjectdata.events_filt.Walk(42).task = 'Walk';
subjectdata.events_filt.Walk(42).end = 467.2600;

%Freezing while walking
subjectdata.events_filt.Walk(43).start = 153.5420;
subjectdata.events_filt.Walk(43).task = 'Freezing_walk';
subjectdata.events_filt.Walk(43).end = 180.0800;

%=== FILTERED GAIT EVENTS FOR WALK WITH STOPS ONLY ===
%Manual Input for Filtered Gait Events based on the exact timings of heelstrike events (not shown here)
subjectdata.events_filt.WalkWS = struct;

%Walk 1
subjectdata.events_filt.WalkWS(1).task = 'Walk'; 
subjectdata.events_filt.WalkWS(1).start = 36.0160000000000;
subjectdata.events_filt.WalkWS(1).end = 39.8970;

%Selected Stop
subjectdata.events_filt.WalkWS(2).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(2).start = 40.3990;
subjectdata.events_filt.WalkWS(2).end = 43.625;

%Walk
subjectdata.events_filt.WalkWS(3).task = 'Walk'; 
subjectdata.events_filt.WalkWS(3).start = 44.7460;
subjectdata.events_filt.WalkWS(3).end = 52.9220;

%Turn
subjectdata.events_filt.WalkWS(4).start = 54.1080;
subjectdata.events_filt.WalkWS(4).task = 'Turn'; 
subjectdata.events_filt.WalkWS(4).end = 63.1420;

%Freezing while turning
subjectdata.events_filt.WalkWS(5).start = 59.4710;
subjectdata.events_filt.WalkWS(5).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkWS(5).end = 67.6070;

%Selected Stop
subjectdata.events_filt.WalkWS(6).start = 69.9430;
subjectdata.events_filt.WalkWS(6).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(6).end =  73.006;

%WAlk
subjectdata.events_filt.WalkWS(7).start = 73.6190;
subjectdata.events_filt.WalkWS(7).task = 'Walk'; 
subjectdata.events_filt.WalkWS(7).end = 84.3080;

%Turn
subjectdata.events_filt.WalkWS(8).start = 85.4670;
subjectdata.events_filt.WalkWS(8).task = 'Turn'; 
subjectdata.events_filt.WalkWS(8).end = 91.4750;

%Selected Stop 
subjectdata.events_filt.WalkWS(9).start = 94.5080;
subjectdata.events_filt.WalkWS(9).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(9).end = 99.33;
 
%Walk 
subjectdata.events_filt.WalkWS(10).start = 100.0450;
subjectdata.events_filt.WalkWS(10).task = 'Walk'; 
subjectdata.events_filt.WalkWS(10).end = 108.4590;

%Turn 
subjectdata.events_filt.WalkWS(11).start = 109.6000; 
subjectdata.events_filt.WalkWS(11).task = 'Turn' ; 
subjectdata.events_filt.WalkWS(11).end = 117.0210; 

%Freezing while turning
subjectdata.events_filt.WalkWS(12).start = 114.0060;
subjectdata.events_filt.WalkWS(12).task = 'Freezing_turn' ; 
subjectdata.events_filt.WalkWS(12).end = 115.8240;

%Selected Stop
%subjectdata.events_filt.WalkWS(13).start = 118.6420;
%subjectdata.events_filt.WalkWS(13).task = 'Selected_stop'; 
%subjectdata.events_filt.WalkWS(13).end = ;

%Walk 
subjectdata.events_filt.WalkWS(14).start = 123.9340;
subjectdata.events_filt.WalkWS(14).task = 'Walk'; 
subjectdata.events_filt.WalkWS(14).end = 134.8080;

%Turn
subjectdata.events_filt.WalkWS(15).start = 135.9430;
subjectdata.events_filt.WalkWS(15).task = 'Turn'; 
subjectdata.events_filt.WalkWS(15).end = 142.0410;

%Selected stop 
subjectdata.events_filt.WalkWS(16).start = 143.8960; 
subjectdata.events_filt.WalkWS(16).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(16).end = 148.350;

%Walk 
subjectdata.events_filt.WalkWS(17).start = 148.8240;
subjectdata.events_filt.WalkWS(17).task = 'Walk'; 
subjectdata.events_filt.WalkWS(17).end = 155.0370;

%Freezing while walking
subjectdata.events_filt.WalkWS(18).start = 155.6650;
subjectdata.events_filt.WalkWS(18).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkWS(18).end = 170.4050;

%Walk
subjectdata.events_filt.WalkWS(19).start = 171.6360;
subjectdata.events_filt.WalkWS(19).task = 'Walk'; 
subjectdata.events_filt.WalkWS(19).end = 172.9120;

%Turn
subjectdata.events_filt.WalkWS(20).start = 174.1220; 
subjectdata.events_filt.WalkWS(20).task = 'Turn'; 
subjectdata.events_filt.WalkWS(20).end = 181.1550;

%Freezing while turning
subjectdata.events_filt.WalkWS(21).start = 176.2650;
subjectdata.events_filt.WalkWS(21).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkWS(21).end = 180.0160;

%Selected stop
subjectdata.events_filt.WalkWS(22).start = 183.0300; 
subjectdata.events_filt.WalkWS(22).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(22).end = 187.75;

%Walk 
subjectdata.events_filt.WalkWS(23).start = 188.1420;
subjectdata.events_filt.WalkWS(23).task = 'Walk'; 
subjectdata.events_filt.WalkWS(23).end = 197.6960;

%Turn
subjectdata.events_filt.WalkWS(24).start = 198.7940;
subjectdata.events_filt.WalkWS(24).task = 'Turn'; 
subjectdata.events_filt.WalkWS(24).end = 204.3530;

%Selected_stop
subjectdata.events_filt.WalkWS(25).start = 206.5470;
subjectdata.events_filt.WalkWS(25).task = 'Selected_stop'; 
subjectdata.events_filt.WalkWS(25).end = 209.254;

%Walk 
subjectdata.events_filt.WalkWS(26).start = 210.4680;
subjectdata.events_filt.WalkWS(26).task = 'Walk'; 
subjectdata.events_filt.WalkWS(26).end = 217.4720;

%Turn
subjectdata.events_filt.WalkWS(27).start = 219.141; 
subjectdata.events_filt.WalkWS(27).task = 'Turn'; 
subjectdata.events_filt.WalkWS(27).end = 225.9640;

%Freezing while turning
subjectdata.events_filt.WalkWS(28).start = 222.2500;
subjectdata.events_filt.WalkWS(28).task= 'Freezing_turn'; 
subjectdata.events_filt.WalkWS(28).end = 232.9640;

%Walk
subjectdata.events_filt.WalkWS(29).start = 239.7090;
subjectdata.events_filt.WalkWS(29).task= 'Walk'; 
subjectdata.events_filt.WalkWS(29).end = 249.6110;

%Turn
subjectdata.events_filt.WalkWS(30).start = 250.8770;
subjectdata.events_filt.WalkWS(30).task= 'Turn'; 
subjectdata.events_filt.WalkWS(30).end = 256.6490;

%Selected Stop
subjectdata.events_filt.WalkWS(31).start = 258.526; 
subjectdata.events_filt.WalkWS(31).task= 'Selected_stop'; 
subjectdata.events_filt.WalkWS(31).end = 261.546;

%Walk
subjectdata.events_filt.WalkWS(32).start = 263.1750;
subjectdata.events_filt.WalkWS(32).task= 'Walk'; 
subjectdata.events_filt.WalkWS(32).end = 268.0250;

%Turn
subjectdata.events_filt.WalkWS(33).start = 286.0630;
subjectdata.events_filt.WalkWS(33).task= 'Turn'; 
subjectdata.events_filt.WalkWS(33).end = 292.452;

%Selected Stop
subjectdata.events_filt.WalkWS(34).start = 294.866;
subjectdata.events_filt.WalkWS(34).task= 'Selected_stop'; 
subjectdata.events_filt.WalkWS(34).end = 298.73;

%Freezing while walking
subjectdata.events_filt.WalkWS(35).start = 268.0250;
subjectdata.events_filt.WalkWS(35).task= 'Freezing_walk'; 
subjectdata.events_filt.WalkWS(35).end = 286.0630;

%walk
subjectdata.events_filt.WalkWS(36).start = 299.1210;
subjectdata.events_filt.WalkWS(36).task= 'Walk'; 
subjectdata.events_filt.WalkWS(36).end = 307.2980;

%Turn, omit after discussion
%subjectdata.events_filt.WalkWS(37).start = 308.4430;
%subjectdata.events_filt.WalkWS(37).task= 'Turn'; 
%subjectdata.events_filt.WalkWS(37).end = 314.2820;

%Selected Stop
subjectdata.events_filt.WalkWS(38).start = 316.479;
subjectdata.events_filt.WalkWS(38).task= 'Selected_stop'; 
subjectdata.events_filt.WalkWS(38).end = 320.920;

%Walk
subjectdata.events_filt.WalkWS(39).start = 322.2430;
subjectdata.events_filt.WalkWS(39).task= 'Walk'; 
subjectdata.events_filt.WalkWS(39).end = 330.9060;

%Selected Stop, omit after discussion
%subjectdata.events_filt.WalkWS(40).start = ;
%subjectdata.events_filt.WalkWS(40).task= 'Selected_stop'; 
%subjectdata.events_filt.WalkWS(40).end = ;

%Walk
subjectdata.events_filt.WalkWS(41).start = 348.1670;
subjectdata.events_filt.WalkWS(41).task= 'Walk'; 
subjectdata.events_filt.WalkWS(41).end = 356.8040;

%Turn
subjectdata.events_filt.WalkWS(42).start = 358.0050;
subjectdata.events_filt.WalkWS(42).task= 'Turn'; 
subjectdata.events_filt.WalkWS(42).end = 364.6430;

%Selected stop
subjectdata.events_filt.WalkWS(43).start = 366.433;
subjectdata.events_filt.WalkWS(43).task= 'Selected_stop'; 
subjectdata.events_filt.WalkWS(43).end = 370.90;

%Walk
subjectdata.events_filt.WalkWS(44).start = 371.3930;
subjectdata.events_filt.WalkWS(44).task= 'Walk'; 
subjectdata.events_filt.WalkWS(44).end = 377.0560;

%Turn
subjectdata.events_filt.WalkWS(45).start = 392.2780;
subjectdata.events_filt.WalkWS(45).task= 'Turn'; 
subjectdata.events_filt.WalkWS(45).end = 399.046;


%Freezing while turning
subjectdata.events_filt.WalkWS(46).start = 394.6420;
subjectdata.events_filt.WalkWS(46).task= 'Freezing_turn'; 
subjectdata.events_filt.WalkWS(46).end = 399.0460;


%Selected stop
subjectdata.events_filt.WalkWS(47).start = 411.186;
subjectdata.events_filt.WalkWS(47).task= 'Selected_stop'; 
subjectdata.events_filt.WalkWS(47).end = 416.45;


%Walk
subjectdata.events_filt.WalkWS(48).start = 416.9850;
subjectdata.events_filt.WalkWS(48).task= 'Walk'; 
subjectdata.events_filt.WalkWS(48).end = 421.8710;


%Turn
subjectdata.events_filt.WalkWS(49).start = 423.581;
subjectdata.events_filt.WalkWS(49).task= 'Turn'; 
subjectdata.events_filt.WalkWS(49).end = 432.7030;


%Freezing while turning
subjectdata.events_filt.WalkWS(50).start = 427.0000;
subjectdata.events_filt.WalkWS(50).task= 'Freezing_turn'; 
subjectdata.events_filt.WalkWS(50).end = 432.7030;

%Selected stop %After review 04/23, omit this due to FI being too high
%subjectdata.events_filt.WalkWS(51).start = 436.965;
%subjectdata.events_filt.WalkWS(51).task= 'Selected_stop'; 
%subjectdata.events_filt.WalkWS(51).end = ;

%Walk
subjectdata.events_filt.WalkWS(52).start = 442.8540;
subjectdata.events_filt.WalkWS(52).task= 'Walk'; 
subjectdata.events_filt.WalkWS(52).end = 447.5480;

%Freezing while walking
subjectdata.events_filt.WalkWS(53).start = 449.3850;
subjectdata.events_filt.WalkWS(53).task= 'Freezing_walk'; 
subjectdata.events_filt.WalkWS(53).end = 453.2200;

%Selected stop
subjectdata.events_filt.WalkWS(54).start = 469.596;
subjectdata.events_filt.WalkWS(54).task= 'Selected_stop'; 
subjectdata.events_filt.WalkWS(54).end = 473.950;

%Walk
subjectdata.events_filt.WalkWS(55).start = 474.5120;
subjectdata.events_filt.WalkWS(55).task= 'Walk'; 
subjectdata.events_filt.WalkWS(55).end = 479.6750;

%Turn
subjectdata.events_filt.WalkWS(56).start = 481.4720;
subjectdata.events_filt.WalkWS(56).task= 'Turn'; 
subjectdata.events_filt.WalkWS(56).end = 487.953;

%Selected stop
subjectdata.events_filt.WalkWS(57).start = 489.3120;
subjectdata.events_filt.WalkWS(57).task= 'Selected_stop'; 
subjectdata.events_filt.WalkWS(57).end = 493.41;

%Walk
subjectdata.events_filt.WalkWS(58).start = 493.9400;
subjectdata.events_filt.WalkWS(58).task= 'Walk'; 
subjectdata.events_filt.WalkWS(58).end = 500.1420;

%Freezing while walking
subjectdata.events_filt.WalkWS(59).start = 501.9350;
subjectdata.events_filt.WalkWS(59).task= 'Freezing_walk'; 
subjectdata.events_filt.WalkWS(59).end = 511.0650;

%Walk
subjectdata.events_filt.WalkWS(60).start = 532.1350;
subjectdata.events_filt.WalkWS(60).task= 'Walk'; 
subjectdata.events_filt.WalkWS(60).end = 535.7640;


%=== FILTERED GAIT EVENTS FOR WALK WITH INTERFERENCE ONLY ===
%Manual Input for Filtered Gait Events based on the exact timings of heelstrike events (not shown here)
subjectdata.events_filt.WalkINT = struct;

%Gait initiation freezing
subjectdata.events_filt.WalkINT(1).task = 'Freezing_walk_initiation'; 
subjectdata.events_filt.WalkINT(1).start = 41.2750000000000; %toe-off
subjectdata.events_filt.WalkINT(1).end = 0;

%Walk
subjectdata.events_filt.WalkINT(2).task = 'Walk'; 
subjectdata.events_filt.WalkINT(2).start = 46.6590000000000; 
subjectdata.events_filt.WalkINT(2).end = 57.2430000000000;

%Freezing while walking %After review 07/23 FI not matching but clinically matching, therfore included
subjectdata.events_filt.WalkINT(3).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(3).start = 60.5730000000000; 
subjectdata.events_filt.WalkINT(3).end = 69.7110000000000;

%Turn
subjectdata.events_filt.WalkINT(4).task = 'Turn'; 
subjectdata.events_filt.WalkINT(4).start = 71.3730000000000; 
subjectdata.events_filt.WalkINT(4).end = 81.3320000000000;

%Freezing while turning
subjectdata.events_filt.WalkINT(5).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT(5).start = 76.6820000000000; 
subjectdata.events_filt.WalkINT(5).end = 80.8020000000000;

%Freezing while walking %After review 07/23 FI not matching but clinically matching, therfore included
subjectdata.events_filt.WalkINT(6).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(6).start = 83.3350000000000; 
subjectdata.events_filt.WalkINT(6).end = 90.2680000000000;

%Freezing while walking %After review 04/23, omit this due to no FI increase
%subjectdata.events_filt.WalkINT(7).task = 'Freezing_walk'; 
%subjectdata.events_filt.WalkINT(7).start = 92.5240000000000; 
%subjectdata.events_filt.WalkINT(7).end = 96.4160000000000;

%Freezing while walking
subjectdata.events_filt.WalkINT(8).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(8).start = 100.544000000000; 
subjectdata.events_filt.WalkINT(8).end = 105.253000000000;

%Freeezing while Walking
subjectdata.events_filt.WalkINT(9).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(9).start = 111.488000000000; 
subjectdata.events_filt.WalkINT(9).end = 121.402000000000;

%Freezing while walking %After review 07/23 FI not matching but clinically matching, therfore included
subjectdata.events_filt.WalkINT(10).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(10).start = 130.387000000000; 
subjectdata.events_filt.WalkINT(10).end = 141.967000000000;

%Turn
subjectdata.events_filt.WalkINT(11).task = 'Turn'; 
subjectdata.events_filt.WalkINT(11).start = 142.506000000000; 
subjectdata.events_filt.WalkINT(11).end = 151.241000000000;

%Freezing while turning
subjectdata.events_filt.WalkINT(12).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT(12).start = 148.609000000000; 
subjectdata.events_filt.WalkINT(12).end = 151.241000000000;

%Walk
subjectdata.events_filt.WalkINT(13).task = 'Walk'; 
subjectdata.events_filt.WalkINT(13).start = 153.654000000000; 
subjectdata.events_filt.WalkINT(13).end = 158.212000000000;

%Turn
subjectdata.events_filt.WalkINT(14).task = 'Turn'; 
subjectdata.events_filt.WalkINT(14).start = 169.804000000000; 
subjectdata.events_filt.WalkINT(14).end = 175.596000000000;

%WAlk
subjectdata.events_filt.WalkINT(15).task = 'Walk'; 
subjectdata.events_filt.WalkINT(15).start = 176.165000000000; 
subjectdata.events_filt.WalkINT(15).end = 178.444000000000;

%Walk
subjectdata.events_filt.WalkINT(16).task = 'Walk'; 
subjectdata.events_filt.WalkINT(16).start = 181.981000000000; 
subjectdata.events_filt.WalkINT(16).end = 184.285000000000;

%Turn
subjectdata.events_filt.WalkINT(17).task = 'Turn'; 
subjectdata.events_filt.WalkINT(17).start = 187.659000000000; 
subjectdata.events_filt.WalkINT(17).end = 193.550000000000;

%Walk
subjectdata.events_filt.WalkINT(18).task = 'Walk'; 
subjectdata.events_filt.WalkINT(18).start = 196.014000000000; 
subjectdata.events_filt.WalkINT(18).end = 204.185000000000;

%Turn
subjectdata.events_filt.WalkINT(19).task = 'Turn'; 
subjectdata.events_filt.WalkINT(19).start = 206.051000000000; 
subjectdata.events_filt.WalkINT(19).end = 211.583000000000;

%Freezing while turning
subjectdata.events_filt.WalkINT(20).task = 'Freezing_turn'; 
subjectdata.events_filt.WalkINT(20).start = 208.398000000000; 
subjectdata.events_filt.WalkINT(20).end = 210.912000000000;

%Walk
subjectdata.events_filt.WalkINT(21).task = 'Walk'; 
subjectdata.events_filt.WalkINT(21).start = 213.081000000000; 
subjectdata.events_filt.WalkINT(21).end = 216.001000000000;

%Freezing while walking %After review 07/23 FI not matching but clinically matching, therfore included
subjectdata.events_filt.WalkINT(22).task = 'Freezing_walk'; 
subjectdata.events_filt.WalkINT(22).start = 235.802000000000; 
subjectdata.events_filt.WalkINT(22).end = 243.504000000000;

%Turn  % omit,Denkpause
%subjectdata.events_filt.WalkINT(23).task = 'Turn'; 
%subjectdata.events_filt.WalkINT(23).start = 244.915000000000; 
%subjectdata.events_filt.WalkINT(23).end = 271.298000000000;

%Freezing while turning      %omit, Denkpause
%subjectdata.events_filt.WalkINT(24).task = 'Freezing_turn'; 
%subjectdata.events_filt.WalkINT(24).start = 248.627000000000; 
%subjectdata.events_filt.WalkINT(24).end = 271.298000000000;

%Gait initiation freezing
subjectdata.events_filt.WalkINT(25).task = 'Freezing_walk_initiation'; 
subjectdata.events_filt.WalkINT(25).start = 289.539000000000; %toe off 
subjectdata.events_filt.WalkINT(25).end = 0;

%Walk
subjectdata.events_filt.WalkINT(26).task = 'Walk'; 
subjectdata.events_filt.WalkINT(26).start = 298.639000000000; 
subjectdata.events_filt.WalkINT(26).end = 302.474000000000;

% ===== Save DATA ====================================================================================================
save([path filesep subjectdata.subject_dir '_datafile.mat'], 'subjectdata', '-mat')

% *********************** END OF SCRIPT *******************************************************************************************************************
