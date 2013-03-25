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


%{
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
%}

path = './guitar_chords/';
note = 'E_8khz_16bps.wav';
%note = 'A_8khz_16bps.wav';



%path = './';
%note = '440.wav';

name_file = strcat(path,note);
disp(name_file);

fs = 8000;
disp('Play');
a = wavread(name_file);

time_vector = a;
% calculates the abs of fft of the vector
fft_abs_vect = abs(fft(time_vector));

% ASSUMPTION - real signal --> even simmetry of the abs of the fft 
% limits on the first half part of the fft
N = round(length(fft_abs_vect)/2);
audio_data_normalized = (fft_abs_vect(1:N+1));

% calculates the number of seconds of the sound
%vector_len = round(length(time_vector)/fs);

%

%create a correct x-axis for the data
upper_interval_frequency = round(fs/2)+1;
step = fs/(2*length(audio_data_normalized));
x_axis = 1:step:upper_interval_frequency;

plot(x_axis(1:length(audio_data_normalized)),audio_data_normalized);

[peaks,indexes] = findpeaks(audio_data_normalized);

%normalize indexes
normalixed_indexes = 
%norm_max_freq = i_max*fs/(2*length(audio_data_normalized));
%%disp(norm_max_freq);


%{
Suonando la corda del MI grave, le frequenze con i picchi sono:
83.13 --> Mi
165.4 --> Mi
248.8 --> Si
331   --> Mi

Suonando la corda del LA, le frequenze con i picchi sono:
La --> 111 hz          
La2 --> 223.4 hz       
Mi --> 331.3 hz         
La4 --> 441.4 hz         
                         
%}
