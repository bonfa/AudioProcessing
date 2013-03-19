function [ time_vector ] = getTimeVector( fc,len )
%% GETTIMEVECTOR 
%   Riceve in ingresso la frequenza di campionamento e la 
%   lunghezza che deve avere l'asse dei tempi
%   e ritorna il vettore contenente il numero giusto di campioni che
%   generano la sequenza di lunghezza corretta.
%%
%    Input Parameters:
%       fc = frequenza di campionamento (in Hz)
%       len = ampiezza dell'intervallo (in secondi)
%
%   Output Parameters:
%       time_vector = vettore contenente tutti gli intervalli di tempo
%%
%   La durata di un suono dipende dal numero di elementi del vettore e dalla frequenza di campionamento.
%   Per esempio, un vettore di 1000 elementi, 
%       con frequenza di 1 KHz dura 1 secondo
%       con frequenza di 0,5 KHz dura 2 secondi
%
%   Bisogna quindi scegliere la frequenza di campionamento e poi calcolare
%   il numero di elementi del vettore.
%
%   Qui il problema non si pone perchè la fc è in ingresso
%%  
%   L'estremo destro dell'intervallo è  len
%   Il numero di campioni si ottiene come fc*len
%
%%
    time_vector = linspace(0,len,fc*len);
    return;
end
