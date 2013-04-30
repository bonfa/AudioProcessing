clear all
close all
clc



% Creation of the object for the recording (creates an 8000 Hz, 8-bit,
% 1-channel audiorecorder object)
recorder = audiorecorder;

disp('Start Recording.');
recordblocking(recorder,4);
disp('End of Recording.');

disp('Start playing.');
play(recorder);
disp('End of Playing.');