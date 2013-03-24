%{ 
    This project defines a simple real-time guitar tuner.
    The main steps of this work are:
        1) taking as input the sound
        2) analyzing the main frequence of it
        3) comparing with the reference frequence and indicate how far it
        is from it

%}

clear all
close all
clc



% Creation of the object for the recording (creates an 8000 Hz, 8-bit,
% 1-channel audiorecorder object)
sound = audiorecorder;

% print recorder properties
get(sound);

%add callback to show when recording starts and completes
sound.StartFcn = 'disp(''Start playing.'')';
%sound.StopFcn = 'disp(''End of playing.'')';
sound.StopFcn = {@play,sound.};

% first try
%recordblocking(sound,5);
record(sound,5);


%play(sound);

% Store data in double-precision array.
% myRecording = getaudiodata(recorder);

%add a callback every timestamp
%recorder.TimerFcn = {@tune_sound,myRecording};

%recordblocking(recorder, 5);
%disp('End of Recording.');



% Plot the waveform.
%plot(myRecording);


