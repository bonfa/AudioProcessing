%%es_1 fft
clear all
close all
clc

%% Generazione della trasformata di fourier del segnale
% Si confronta la trasformata di fourier di un segnale con diverse versioni
% della trasformata realizzate variando i parametri.
% 
% Parte 1)
% Si effettua la fft su numero di punti minore rispetto ai campioni del
% segnale originale. In realtà, poichè il segnale in frequenza deve avere
% lo stesso numero di campioni del segnale originale, la funzione di matlab
% annulla i campioni in sovrannumero tenendo solo i primi 10. Come si può
% notare dal grafico, la FFT risulta essere meno accurata rispetto
% all'originale pur mantenendo lo stesso andamento.
%
% Parte 2)
% Si effettua la fft su numero di punti maggiore rispetto ai campioni del
% segnale originale. In questo caso la funzione di matlab effettua il
% padding del segnale originale prima di trasformare. Come si può vedere
% dal grafico, la FFT risulta essere molto più accurata rispetto a quella
% campionata con n=20
%
% Parte 3)
% Si effettua la fft sul segnale scalato di un fattore 2. In questo caso la
% bande del segnale dimezza e si affianca lo spettro del campione
% successivo. Questo risultato si può vedere nel grafico.
%
% Parte 4)
% Si effettua la fft sul segnale scalato di un fattore 2 ma in questo caso
% il segnale viene interpolato prima di effettuare la trasformata. In
% questo caso, lo spettro risulta essere molto simile allo spettro del
% segnale originale, solamente raddoppiato e leggermente allargato.
%%

%%generazione della sequenza
s = zeros(1,20);
for i=1:20,
   s(i) = (0.5)^i;
end
%%s


%%calcolo la fft normale
spettro = fft(s);
figure();
plot(1:20,spettro);
title('FFT');

%% calcolo la fft
%%1) con 10 campioni in frequenza  ---> s viene troncato a 10
spettro = fft(s,10);
figure();
plot(1:10,spettro);
title('FFT - dieci campioni');

%%2) con 40 campioni in frequenza ---> s viene paddato alla fine
spettro = fft(s,40);
figure();
plot(1:40,spettro);
title('FFT - 40 campioni');

%%3) aggiungo uno zero dopo ciascun campione 
%%nuova sequenza
q = zeros(1,40);
for i=1:40,
    if (mod(i+1,2) == 0)
        q(i) = s((i+1)/2)
    else
        q(i) = 0;
    end    
end
spettro = fft(q,40);
figure();
plot(1:40,spettro);
title('Um campione nullo e uno originale');

%%4)  interpolazione di fattore 2
%%nuova sequenza
r = interp(s,2);

spettro = fft(r,40);
figure();
plot(1:40,spettro);
title('Interpolazione di un fattore due');