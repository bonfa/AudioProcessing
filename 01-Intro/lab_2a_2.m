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

 
 %% a) Crea la prima sinusoide e la suona
    f0 = 440;
    len = 4;
    A = 0.3;    
    
    fc1 = 44100;
    t1 = getTimeVector(fc1,len);
    
    s1 = sinusoide(t1,A,f0);
    %visualizza il grafico
    lungh = length(t1);
    axis([0 lungh -2 2]);
    plot(t1,s1);
    
    %ATTENZIONE: PASSARE SEMPRE LA FREQUENZA CON CUI SUONARE!!!    
    fprintf('Suono la sinusoide a frequenza 44.1KHz\n');
    sound(s1,fc1);
  
    
   %% Crea la seconda sinusoide e la suona
    fc2 = 22100;
    t2 = getTimeVector(fc2,len);
    
    s2 = sinusoide(t2,A,f0);
    %visualizza il grafico
    lungh = length(t2);
    axis([0 lungh -2 2]);
    plot(t2,s2);
    
    fprintf('Suono la sinusoide a frequenza 22.1KHz\n');
    sound(s2,fc2);
    
    
    %% Crea la terza sinusoide e la suona
    fc3 = 8000;
    t3 = getTimeVector(fc3,len);
    
    s3 = sinusoide(t3,A,f0);
    %visualizza il grafico
    lungh = length(t3);
    axis([0 lungh -2 2]);
    plot(t3,s3);
        
        
    fprintf('Suono la sinusoide a frequenza 8KHz\n');
    sound(s3,fc3);
    
%%  
% Si dovrebbe sentire che, diminuendo la frequenza di campionamento,
% il suono diventa più cupo. (con molta attenzione qualcosa si sente) 
% Questo perché vengono perse della armoniche durante il campionamento
