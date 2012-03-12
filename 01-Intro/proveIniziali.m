%Prove Iniziali dei comandi matlab che non mi ricordo mai%

clear all
close all
clc

suono1 = wavread('Cmaj.wav');

sound(suono1);
len(suono1)

plot(suono1)
figure(2)
plot(sin(suono1))