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
recorder = audiorecorder;

% print recorder properties
get(recorder);

%add callback to show when recording starts and completes
recorder.StartFcn = 'disp(''Start playing.'')';

set(recorder,'TimerFcn',{@tune_sound});
set(recorder,'TimerPeriod',3);
record(recorder);
