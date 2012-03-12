%% 2-Basic tone and noise synthesis%%
clear all
close all
clc



%% Crea un rumore bianco di 10sec, lo suona e lo salva in un file
%     text = sprintf('White Noise');
%     display(text);
%     t = [0:0.1:6000];
%     y = rand(size(t));
%     axes = [0 6000 -2 2]
%     plot(t,y);
%     sound(y);
%     wavwrite(y,'noise.wav');



%%
% Crea e suona una sinusoide di 6 secondi con diverse frequenze di
% campionamento
%   il tempo è in millisecondi
%   la frequenza è in kHz

% %    frequenzaCampionamento = 8;
% %    frequenzaCampionamento = 22.05; 
    frequenzaCampionamento = 44.1;
    
    dt = 1/frequenzaCampionamento;
    t = 0:dt:6000;
    f0 = 0.44;
    s = sinusoide(t,1,f0);
%     plot(s);
%     axis([0 6000 -2 2]);
%     sprintf 'suono la sinusoide\n'
%     sound(s,frequenzaCampionamento*1000);

% Si dovrebbe sentire che, diminuendo la frequenza di campionamento,
% il suono diventa più cupo. (???) Questo perchè vengono perse della armoniche
% durante il campionamento



%% Esperimenti Con i Beats
% Sintetizzazione di un tono formato da due sinusoidi con frequenze diverse
% con differenza inferiore a 10 per sentire i beats.
% Poi aumentare la frequenza progressivamente fino a evitare i beats
k = 1;
s1 = sinusoideFreqVariabile(t,1,f0,k);
plot(t,s1);
axis([0 6000 -2 2]);
soundsc(s1);