function [ s ] = sinusoide( t,A,f0 )
%SINUSOIDE crea una sinusoide dati l'intervallo temporale,l'ampiezza e la frequenza
%   Input Parameters:
%       t = asse dei tempi
%       A = ampiezza
%       f0 = frequenza
%
%   Output Parameters:
%       s = A*sin(2*pi*f0*t)
%

y = @(x)[A.*sin(2*pi*f0.*x)];
s = y(t);
return;

end

