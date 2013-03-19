%%es_2 fft
clear all
close all
clc

%% Primo filtraggio di segnale audio
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

% Primo metodo - convoluzione
c = conv(s2,h);
figure();
plot(1:length(c),c);
wavwrite(c,22050,'conv_diretta.wav');
title('convoluzione - diretta');

% Secondo metodo - prodotto delle fft
% è necessario fare il padding:
% paddo sia il segnale che il filtro con zero-padding.
% Il numero di campioni dev'essere il numero di campioni del risultato
% dell'operazione. Ma questo lo fa la funzione di matlab fft.
% C'è un problema per quanto riguarda lo sfasamento del segnale dovuto
% all'operazione automatica di padding e quindi ho dovuto inserire un
% secondo di padding nel segnale originale per evitare che il risultato
% della convoluzione circolare del segnale fosse sfasato.
total_number_of_samples = length(c) ;
new_s = [zeros(1,number_of_samples) s2']';

S2 = fft(new_s,length(c));
H = fft(h,length(c));

figure();
plot(abs(S2),'r');
title('fft segnale');

figure();
plot(abs(H),'g');
title('fft filtro');


C = S2.*H';
figure();
plot(abs(C));
title('fft prodotto');
c_fft = ifft(C);
figure();
plot(1:length(c_fft),c_fft);
title('convoluzione - tramite fft');
wavwrite(c_fft,22050,'conv_fft.wav');

close all;

% Terzo metodo - Overlap ADD
%non funziona non so perch�...
lunghezza_intervallo = 64;
y = overlap_add(s2,h,lunghezza_intervallo);

figure();
plot(1:length(s2),s2);
title('segnale');

figure();
plot(1:length(c),c,'r');
title('concoluzione');

figure();
plot(1:length(y),y);
title('convoluzione - overlap add');
wavwrite(y,22050,'conv_overlap.wav');   