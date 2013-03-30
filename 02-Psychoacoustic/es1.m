clear all
close all
clc

%{
Load the wave le track 10.wav and hear it. 

In this demonstration the masked threshold of pure tones masked 
by critical-band wide noise (1 kHz, 70 dB) is illustrated. 

You will hear three series of tone triplets: the first series is played at a level
of 75 dB, the second at a level of 60 dB, the third at a level of 40 dB. 

Each series consists of six tone triplets with the frequencies 600 Hz, 
800 Hz, 1000 Hz, 1300 Hz, 1700 Hz, and 2300 Hz. 

In the second series the third tone triplet at 1000 Hz is masked by the
narrow-band noise, and in the third series the third and fourth triplet
at 1000 Hz and 1300 Hz (for some persons also the fth triplet at 1700 Hz)
are masked.
%}


suono1 = wavread('track_10.wav');

fprintf('beginning of playing\n');
sound(suono1,44100);
fprintf('end of playing\n');