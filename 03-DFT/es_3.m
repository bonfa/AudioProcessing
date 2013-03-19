%%es_3 fft
clear all
close all
clc

%% Applico un echo
%%

%%Caricamento del segnale audio con la frequenza di sampling e il numero
%%di bit
[s2,fs,nbits]= wavread('shine.wav');
plot(1:length(s2),s2);
title('segnale');

%%filtro
% Creo il filtro come una sequenza di zeri che ha 2 uni agli estremi del
% supporto (perchè non so come usare le delta). La lunghezza del vettore
% dipende dalla frequenza di sampling. (occhio alle unità di misura).
%    #campioni = durata*fs
t = 1.001;
number_of_samples = round(t*fs);
h = zeros(1,number_of_samples);
h(1) = 1/sqrt(2);
h(length(h)) = 1/sqrt(2);
figure();
plot(1:length(h),h,'*r');
title('filtro');

