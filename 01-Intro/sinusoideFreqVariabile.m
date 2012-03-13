function [ s ] = sinusoideFreqVariabile( t,A,f0,k )
%SINUSOIDEFREQVARIABILE Crea una sinusoide a frequenza variabile, dati l'intervallo
%temporale,l'ampiezza e la frequenza di base
%
%   Input Parameters:
%       t = asse dei tempi
%       A = ampiezza
%       f0 = frequenza
%
%   Output Parameters:
%       s = 0.5(A*sin(2*pi*f0*t) + A*sin(2*pi*f0*t+pi*k*t^3))

y = @(x)[1/2*(A.*sin(2*pi*f0.*x)+A.*sin(2*pi*f0.*x+k*pi.*(x.^3)))];
s = y(t);
return;
end