%% 2-Basic tone and noise synthesis%%
    clear all
    close all
    clc



%% a) Crea un rumore bianco di 10sec, lo suona e lo salva in un file
    t = [0:0.1:6000];
    y = rand(size(t));
    axis([0 6000 -2 2]);
    plot(t,y);
    fprintf('Rumore Bianco (6 sec.)\n');
    sound(y);
    wavwrite(y,'noise.wav');



%%
%% b) Crea e suona una sinusoide di 6 secondi con diverse frequenze di campionamento
%   il tempo � in millisecondi
%   la frequenza � in kHz

% %    frequenzaCampionamento = 8;
% %    frequenzaCampionamento = 22.05; 
    frequenzaCampionamento = 44.1;
      
    dt = 1/frequenzaCampionamento;
    t = 0:dt:6000;
    f0 = 0.44;
    s = sinusoide(t,1,f0);
    plot(s);
    axis([0 6000 -2 2]);
    fprintf('Suono la sinusoide a frequenza 440Hz\n');
    sound(s,frequenzaCampionamento*1000);

% Si dovrebbe sentire che, diminuendo la frequenza di campionamento,
% il suono diventa pi� cupo. (???) Questo perch� vengono perse della armoniche
% durante il campionamento



%% 3) Esperimenti Con i Beats
% a) Sintetizzazione di un tono formato da due sinusoidi con frequenze diverse
% con differenza inferiore a 10 per sentire i beats.
    f1 = 0.4235;
    s1 = sinusoide(t,1,f1);
    figure();
    plot(t,s1);
    axis([0 6000 -2 2]);
    fprintf('Suono la sinusoide a 423.5Hz\n');
    sound(s1,frequenzaCampionamento*1000);

    s2 = s + s1;
    figure();
    plot(s2);
    axis([0 6000 -2 2]);
    fprintf('Suono la somma delle due sinusoidi\n');
    soundsc(s2,frequenzaCampionamento*1000);


% b) Creo un segnale formato da due toni, uno con frequenza fissa e l'altro 
% con frequenza che aumenta in modo esponenziale.
% In questo modo si possono ascoltare i beats che gradualmente scompaiono
    clear t;
    t = 0:dt:10000;
    k = 1e-6;
    f0 = 0.44;
    
    s3 = sinusoideFreqVariabile(t,1,f0,k);
    figure();
    plot(t,s3);

    fprintf('Suono un segnale formato da due sinusoidi, la prima a frequenza fissa e l''altra a frequenza variabile\n');
    sound(s3,frequenzaCampionamento*1000);
 
 %% 4) Toni Complessi: Accordi
 % L'accordo è formato da 3 o più note che suonano insieme. Queste note
 % sono definite dalle regole armoniche. 
 % Esempio: DO maggiore --> DO(root) MI(terza maggiore) SOL(quinta)
 
 % Sintetizzare un accordo di DO Maggiore c(t) = 1/3 * sum (0..2) sin(2 pi fi)
 % La frequenza di root è f0 = 523.25 Hz. La frequenza di MI e SOL può
 % essere calcolata tramite la tabella presente nel foglio delle
 % esercitazioni a partire dalla frequenza f0. Diversi rapporti sono
 % definiti per diversi temperamenti musicali. 
 % Sintetizzare sia l'intonazione normale sia il temperamento equale e
 % sentire le differenze.
     clear all 
     close all

     format long g
 
     frequenzaCampionamento = 44.1;
     dt = 1/frequenzaCampionamento;
     t = 0:dt:10000;
     f0 = 0.52325;
 % Frequenze della terza e della quinta di Do Maggiore per la scala
 % naturale
     f3MJust = f0*5/4;
     f5MJust = f0*3/2;

 % Frequenze della terza e della quinta di Do Maggiore per la scala del
 % temperamento equale
     f3EqualTemp = f0*2^(4/12);
     f5EqualTemp = f0*2^(7/12);

 
     doMJust = 1/3*(sinusoide(t,1,f0)+sinusoide(t,1,f3MJust)+sinusoide(t,1,f5MJust));
     doMEqualTemp = 1/3*(sinusoide(t,1,f0)+sinusoide(t,1,f3EqualTemp)+sinusoide(t,1,f5EqualTemp));
     
     fprintf('Suono il Do Maggiore costruito secondo le regole della scala naturale\n');
     sound(doMJust,frequenzaCampionamento*1000);
     fprintf('Suono il Do Maggiore costruito secondo le regole del temperamento equale\n');
     sound(doMEqualTemp,frequenzaCampionamento*1000);

     figure();
     plot(t,doMJust,'r');
     hold on;
     plot(t,doMEqualTemp,'b');
     axis([0 10000 -2 2]);

 