%{ 
    This project defines a simple real-time guitar tuner.
    The main steps of this work are:
        1) taking as input the sound
        2) analyzing the main frequence of it
        3) comparing with the reference frequence and indicate how far it
        is from it

%}



% Creation of the object for the recording (creates an 8000 Hz, 8-bit,
% 1-channel audiorecorder object)
recorder = audiorecorder;

% view the properties
get(recorder);

% first try
disp('Start speaking.')
recordblocking(recorder, 5);
disp('End of Recording.');
% Store data in double-precision array.
myRecording = getaudiodata(recorder);

% Plot the waveform.
plot(myRecording);

play(recorder);