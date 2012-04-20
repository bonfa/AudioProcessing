%%es_2 fft

clear all
close all
clc

%% Primo filtraggio di segnale audio

%%

%%Caricamento del segnale audio
s2 = wavread('shine.wav');

%filtro
h = 1/sqrt(2)*(dirac(0)+dirac(+1));

plot(1:length(s2),s2);
title('segnale');
figure();
plot(1:length(h),h);
title('filtro');

%primo metodo - convoluzione
c = conv(s2,h);
fprintf('suoniamo');
figure();
plot(1:length(c),c);
soundsc(c);
title('convoluzione - diretta');

%secondo metodo - prodotto delle fft
S2 = fft(s2);
H = fft(h);

C = S2*H;
c = ifft(C);
plot(1:length(c),c);
figure();
title('convoluzione - tramite fft');

sound(c);