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
% Il metodo serve per CALCOLARE VELOCEMENTE LA CONVOLUZIONE TRA UN SEGNALE
% E UN FILTRO FIR.
% L'algoritmo è il seguente:
% 1) si divide il segnale in intervalli (L = 64)
% 2) si calcola la fft del filtro con N desiderato (N = length(s)+length(h)) 
% 2.1) si prepara un vettore che conterrà il risultato della convoluzione
% 3) per ciascun intervallo:
% 4)    si calcola la fft dell'intervallo
% 5)    si moltiplica il risultato con la fft del filtro
% 6)    si antitrasforma
% 7)    si somma il risultato dell'anti trasformata al segnale y nella
%           posizione opportuna. (In particolare, il segnale y non è
%           nullo, ma contiene una parte del risultato della convoluzione
%           tra l'intervallo precedente e il filtro. Questo è dovuto al
%           fatto che il risultato della convoluzione ha supporto maggiore
%           del segnale in ingresso).
% 
% Di fatto questo metodo applica il procedimento fft - prodotto fft inversa
% su segmenti ridotti del segnale e poi somma tutti i risultati.

lunghezza_intervallo = 640;
lunghezza_convoluzione = length(c);
i = 1;
y = zeros(lunghezza_convoluzione,1);

while i<length(s2),
    % prendo l'intervallo
    estremo_inferiore_dell_intervallo = i;
    estremo_superiore_dell_intervallo = min(estremo_inferiore_dell_intervallo + lunghezza_intervallo -1,length(s2));
    %questo if gestisce il caso in cui la lunghezza del'intervallo sia
    %inferiore a 640. Questo succede nell'ultimo intervallo del vettore
    if(estremo_superiore_dell_intervallo +1 - estremo_inferiore_dell_intervallo < lunghezza_intervallo),
        lunghezza_intervallo = estremo_superiore_dell_intervallo + 1 - estremo_inferiore_dell_intervallo;
    end
    intervallo_del_segnale = s2(estremo_inferiore_dell_intervallo:estremo_superiore_dell_intervallo);
    % calcolo la fft, moltiplico con la risposta del filtro e antitrasformo.
    convoluzione_sull_intervallo = ifft(fft(intervallo_del_segnale,lunghezza_convoluzione).*H');
    % calcolo le coordinate in cui aggiungere il mio risultato in y
    estremo_inferiore_dell_intervallo_in_y = estremo_inferiore_dell_intervallo;
        % la convoluzione di un singolo intervallo con il filtro ha la somma
        % dei supporti, quindi L+length(h); il resto sono zeri
    lunghezza_filtro = number_of_samples+1;
    estremo_superiore_dell_intervallo_in_y = min(estremo_inferiore_dell_intervallo_in_y + lunghezza_intervallo + lunghezza_filtro,lunghezza_convoluzione);
    y(estremo_inferiore_dell_intervallo_in_y:estremo_superiore_dell_intervallo_in_y) = y(estremo_inferiore_dell_intervallo_in_y:estremo_superiore_dell_intervallo_in_y) + convoluzione_sull_intervallo(1:(estremo_superiore_dell_intervallo_in_y + 1 - estremo_inferiore_dell_intervallo_in_y));
    i = i + lunghezza_intervallo;
    %fprintf('%d ',i);
end

figure();
plot(y);
title('convoluzione - overlap add');
wavwrite(y,22050,'conv_overlap.wav');   