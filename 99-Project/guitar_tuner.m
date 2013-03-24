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
fs = 8000;

% print recorder properties
get(recorder);

%add callback to show when recording starts and completes
recorder.StartFcn = 'disp(''Start playing.'')';

set(recorder,'TimerFcn',{@tune_sound,fs});
set(recorder,'TimerPeriod',6);
record(recorder);


%{
fs = 8000;
disp('Play');
a = wavread('440.wav');

time_vector = a;
% calculates the abs of fft of the vector
fft_abs_vect = abs(fft(time_vector));

% ASSUMPTION - real signal --> even simmetry of the abs of the fft 
% limits on the first half part of the fft
N = length(fft_abs_vect)/2;
audio_data_normalized = (fft_abs_vect(1:N+1));

% calculates the number of seconds of the sound
%vector_len = round(length(time_vector)/fs);

%
plot(audio_data_normalized);

[m,i_max] = max(audio_data_normalized);

%normalize 
norm_max_freq = i_max*2*1000/fs;
disp(norm_max_freq);
%}