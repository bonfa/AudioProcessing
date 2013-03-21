%% 2-Basic tone and noise synthesis%%
    clear all
    close all
    clc

%%  OSSERVAZIONE IMPORTANTE
 %  LA FREQUENZA DELLA SINUSOIDE E' DIVERSA DALLA FREQUENZA DI
 %  CAMPIONAMENTO!!!!!!!!!!!!!!!!!!!!
 %
 %  f0 è la frequenza della sinusoide
 %  fc è la frequenza di campionamento e determina la lunghezza del
 %  vettore dell'asse dei tempi
 %  
 %  IL METODO sound() DEV'ESSERE SEMPRE USATO CON LA FREQUENZA CORRETTA

 %% parametri fissi
    len = 36;
    A = 0.3; 
    fc = 44100;
    t1 = getTimeVector(fc,len);
    
 %% a) Crea la sinusoide a frequenza variabile
    f0 = 440;
    sfv = sinusoideFreqVariabile(t1,A,f0,1);
       
%% suona la sinusoide
    figure('name','sinusoide a frequenza variabile');
    plot(t1,sfv); 
    
    fprintf('Suono la sinusoide a frequenza 44.1KHz\n');
    sound(sfv,fc); 
