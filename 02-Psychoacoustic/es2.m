clear all
close all
clc

fc = 44.1;
dt = 1/fc;
t = 0:dt:10000;
f0 = 0.44;

s_left = sinusoide(t,1,f0);
s_right = sinusoide_frequenza_variabile(t,1,f0,1);

stereo_sound = [s_left ; s_right]';

sound(stereo_sound,fc);