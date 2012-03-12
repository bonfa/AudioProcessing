%%2-Basic tone and noise synthesis%
clear all
close all
clc
%create and play 10 sec white noise seq%
y = rand([1,100000],'double');
%plot(y)
%sound(y)
wavwrite(y,'noise.wav');

%create a sound  of length d sec with a simple sinusoid s(t)=sin(2pif)%
f0 = 8000;

ti = 0;
tf = 10000;
T = 1.0/f0;

dt = 1e-3;
t = 0:dt:tf;

s = sin((2*pi*f0)*t);
plot(s)
%printf 'suono la sinusoide\n'
sound(s)
