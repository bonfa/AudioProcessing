function [ y ] = overlap_add( segnale,filtro,lunghezza_intervallo)
%OVERLAP_ADD Metodo veloce per calcolare la convoluzione
% Il metodo serve per CALCOLARE VELOCEMENTE LA CONVOLUZIONE TRA UN SEGNALE
% E UN FILTRO FIR.
% L'algoritmo è il seguente:
% 1) si divide il segnale in intervalli (di lunghezza L)
% 2) si calcola la fft del filtro con N desiderato (N = L+length(h)) 
% 2.1) si prepara un vettore che conterrà  il risultato della convoluzione
% 3) per ciascun intervallo:
% 4)    si calcola la fft dell'intervallo
% 5)    si moltiplica il risultato con la fft del filtro
% 6)    si antitrasforma
% 7)    si somma il risultato dell'anti trasformata al segnale y nella
%           posizione opportuna. (In particolare, il segnale y non Ã¨
%           nullo, ma contiene una parte del risultato della convoluzione
%           tra l'intervallo precedente e il filtro. Questo Ã¨ dovuto al
%           fatto che il risultato della convoluzione ha supporto maggiore
%           del segnale in ingresso).
% 
% Di fatto questo metodo applica il procedimento fft - prodotto fft inversa
% su segmenti ridotti del segnale e poi somma tutti i risultati.

%non è veloce e non funziona!!!

    lunghezza_convoluzione = length(segnale)+length(filtro);
    y = zeros(lunghezza_convoluzione,1);
    i = 1;    
    H = fft(filtro,lunghezza_intervallo + length(filtro));
           
    while i<length(segnale),
        %calcolo gli estremi dell'intervallo
        estremo_inferiore_intervallo_segnale = i;
        estremo_superiore_intervallo_segnale = min(estremo_inferiore_intervallo_segnale+lunghezza_intervallo-1,length(segnale));
        
        %estraggo l'intervallo
        intervallo_segnale = segnale(estremo_inferiore_intervallo_segnale:estremo_superiore_intervallo_segnale);
        
        %faccio la convoluzione tra l'intervallo e il filtro 
        convoluzione_intervallo = ifft(fft(intervallo_segnale,length(intervallo_segnale)+length(filtro)).*H(length(intervallo_segnale)+length(filtro))');
        %convoluzione_intervallo = ifft(fft(intervallo_segnale,lunghezza_intervallo+length(filtro)).*H');
        
        %calcolo gli estremi nel nuovo intervallo
        estremo_inferiore_intervallo_y = estremo_inferiore_intervallo_segnale;
        estremo_superiore_intervallo_y = min(estremo_inferiore_intervallo_y+length(convoluzione_intervallo)-1,length(y));
        
        %sommo al vettore y il risultato della convoluzione
        y(estremo_inferiore_intervallo_y:estremo_superiore_intervallo_y) = y(estremo_inferiore_intervallo_y:estremo_superiore_intervallo_y) + convoluzione_intervallo;
        i = i + lunghezza_intervallo;
    end

    return;
end

