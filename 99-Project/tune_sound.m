function [ output_args ] = tune_sound( audio_vector )
%TUNE_SOUND This functions represents the tuner. 
%   It 
%   takes as input the sound, 
%   makes noise reduction, 
%   calculates the fft,
%   calculates the maximum,
%   returns the misplacement between the maximum and the nearest tone
%   frequency

%disp('Hello World!');
if(~isempty(audio_vector))
    disp(length(audio_vector));

end

