clear all
close all
clc

fc = 44.1;
dt = 1/fc;
t = 0:dt:10000;
f0 = 0.120;

sound = zeros(size(t));
for i=1:20
    armonica = (1/i).*sinusoide(t,1,f0*i);
    sound = sound + armonica;
end

plot(t,sound);
%soundsc(sound);

sound2 = zeros(size(t));
for i=3:20
    armonica = (1/i).*sinusoide(t,1,f0*i);
    sound2 = sound + armonica;
end
%soundsc(sound2);
figure();
plot(t,sound2,'r');

wavwrite(sound,'suono.wav');
wavwrite(sound2,'nofreqFond.wav');