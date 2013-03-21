%% 2-Basic tone and noise synthesis%%
    clear all
    close all
    clc

%%  OSSERVAZIONE IMPORTANTE
 %  Creo l'accordo di DO maggiore in tonalità originale e in temperamento
 %  equale

 %% parametri fissi
    len = 6;
    A = 0.1; 
    fc = 44100;
    t1 = getTimeVector(fc,len);
    
 %% a) Crea la sinusoide della tonica
    ft = 523.25;
    st = sinusoide(t1,A,ft);
   
   %% 
   %    Creo la terza e la quinta secondo l'intonazione originale
    f3 = ft*5/4;
    f5 = ft*3/2;
   
    s3 = sinusoide(t1,A,f3);
    s5 = sinusoide(t1,A,f5);    
   
    %% 
   %    Creo la terza e la quinta secondo il temperamento equale
    f3_te = ft*2^(1/3);
    f5_te = ft*2^(7/12);
   
    s3_te = sinusoide(t1,A,f3_te);
    s5_te = sinusoide(t1,A,f5_te);    
   
    
    
%% plotta e suona le due note
    C = st + s3 + s5; 
    C_te = st + s3_te + s5_te;
    figure('name','differenza tra le due sinusoidi');
    ylim([-1,+1]);
    plot(t1,C-C_te); 
    
    figure('name','sinusoidi');
    plot(t1,C,'r'); 
    hold on;
    plot(t1,C_te);     

    fprintf('Suono il DO puro a frequenza 44.1KHz\n');
    sound(C,fc); 
    
    fprintf('Suono il DO secondo il temperamento equale a frequenza 44.1KHz\n');
    sound(C_te,fc); 
    
%%  
% Si dovrebbe sentire che le due note sono diverse (leggermente)
