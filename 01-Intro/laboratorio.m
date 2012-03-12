%%2-Basic tone and noise synthesis%
clear all
close all
clc
    
%Crea un rumore bianco di 10sec, lo suona e lo salva in un file
    y = rand([1,10000],'double');
    plot(y)
    %sound(y)
    wavwrite(y,'noise.wav');

%Create a sound  of length d sec with a simple sinusoid s(t)=sin(2pif)%
%     t = 0:0.00001:10;
%     f0 = 0.44;
% 
%     T = 1.0/f0;
% 
%     s = sin((2*pi*f0)*t);
%     plot(s)
%     %sprintf 'suono la sinusoide\n'
%     sound(s)
