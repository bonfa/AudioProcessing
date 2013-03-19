%% 2-Basic tone and noise synthesis%%
    clear all
    close all
    clc



%% a) Crea un rumore bianco di 10sec, lo suona e lo salva in un file
    fs = 8000;
    len = 10;
    t = getTimeVector(fs,len);
    y = rand(size(t));
    %normalizza per evitare il clip
    y = y/(max(abs(y)));
    
    lungh = length(t);
    axis([0 lungh -2 2]);
    plot(t,y);
    fprintf('Rumore Bianco (10 sec.)\n');
    sound(y);
    wavwrite(y,fs,'noise.wav');
    % lo warning si verifica perchè c'è il valore Y=+1 non è ammesso e
    % viene clippato (non è un gran problema)