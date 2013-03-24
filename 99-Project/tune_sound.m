function [ ] = tune_sound(recorder,event,fs)
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
    audio_data = getaudiodata(recorder);
    
    % get frequency normalized 
    % make fft
    abs_fft_audio_data = abs(fft(audio_data));
    % data in this way are not normalized
    % as the signal is real, we analyze only the right part of the spectrum
    N = length(abs_fft_audio_data)/2;
    half_fft = (abs_fft_audio_data(1:N+1));
    
    plot(half_fft);
    [m,i_max] = max(half_fft);
    
    norm_max_freq = i_max*2*1000/fs;
    disp(norm_max_freq);
    
    disp('Play');
    playblocking(recorder.getplayer());
    disp('Stop');
    
    %resume(recorder);
        

    return;    
end

