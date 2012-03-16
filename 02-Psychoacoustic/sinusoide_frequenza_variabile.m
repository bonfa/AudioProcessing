function [ s ] = sinusoide_frequenza_variabile( t,A,f0,k )
%SINUSOIDEFREQVARIABILE Crea una sinusoide a frequenza variabile, dati l'intervallo
%temporale,l'ampiezza e la frequenza di base
%
%   Input Parameters:
%       t = asse dei tempi
%       A = ampiezza
%       f0 = frequenza
%
%   Output Parameters:
%       s = A*sin(2*pi*f0*t+pi*k*t^2)

y = @(x)[A.*sin(2*pi*f0.*x+k*pi.*(x.^2))];
s = y(t);
return;
end

