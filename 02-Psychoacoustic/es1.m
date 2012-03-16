clear all
close all
clc

suono1 = wavread('track_10.wav');

fprintf('beginning of playing\n');
sound(suono1);
fprintf('end of playing\n');