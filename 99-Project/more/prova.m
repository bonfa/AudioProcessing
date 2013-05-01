clear all
close all
clc



% Creation of the object for the recording (creates an 8000 Hz, 8-bit,
% 1-channel audiorecorder object)
recorder = audiorecorder;

disp('Start Recording.');
recordblocking(recorder,1);
disp('End of Recording.');

stop(recorder);
% extract audio data (double)
audio_data = getaudiodata(recorder);

get_normalized_freq_vector(8000,audio_data);



disp('Start playing.');
play(recorder);
disp('End of Playing.');