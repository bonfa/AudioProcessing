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
    
 %% a) Crea la prima sinusoide 
    f0 = 440;
    s1 = sinusoide(t1,A,f0);
   
   %% 
   %    Crea diverse versioni della seconda sinusoide che durano 4 secondi 
   %    avvicinando sempre più la frequenza a f0
   
    f2 = [430:439];
    f2(10:18) = [439.5 439.6 439.7 439.8 439.9 440 440 440 440];
    len_i = len/length(f2);
    
    t_i = getTimeVector(fc,len_i);
    
    s2 = 1:length(t1);
    
    t = 1;    
    for i=1:length(f2)
        a = t;
        b = t + length(t_i)-1;
        s_i = sinusoide(t_i,A,f2(i));
        s2(a:b) = s_i;
        t = t + length(t_i);
    end
        
    
%% plotta e suona le due sinusoidi    
    s_tot = s1 + s2; 
    figure('name','differenza tra le due sinusoidi');
    ylim([-1,+1]);
    plot(t1,s1-s2); 
    %hold on;
    %plot(t1,s1,'r'); 
    %plot(t1,s2,'g');     

    figure('name','differenza somma delle due sinusoidi');
    plot(t1,s_tot); 
    
    fprintf('Suono la sinusoide a frequenza 44.1KHz\n');
    sound(s_tot,fc); 
    
    
%%  
% Si dovrebbe sentire che, diminuendo la frequenza di campionamento,
% il suono diventa più cupo. (con molta attenzione qualcosa si sente) 
% Questo perché vengono perse della armoniche durante il campionamento
