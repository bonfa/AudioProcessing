function [ ] = tune_sound(recorder,event)
%TUNE_SOUND This functions represents the tuner. 
%   It 
%   takes as input the sound, 
%   makes noise reduction, 
%   calculates the fft,
%   calculates the maximum,
%   returns the misplacement between the maximum and the nearest tone
%   frequency
    
    % stop the recorder
    stop(recorder);
    % extract audio data (double)
    %audio_data = getaudiodata(recorder);
    %make fft
    %audio_data_fft = fft();
    
    disp('Play');
    playblocking(recorder.getplayer());
    disp('Stop');
    
    resume(recorder);
    
    %disp(data[1]);
    % estraggo il vettore audio
    

    return;    
end

