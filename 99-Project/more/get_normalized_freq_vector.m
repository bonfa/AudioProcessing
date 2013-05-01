function [ frequency_vector ] = get_normalized_freq_vector( fs, time_vector )
%GET_NORMALIZED_FREQ_VECTOR Summary of this function goes here
%   Detailed explanation goes here
       
    % calculates the abs of fft of the vector
    fft_abs_vect = 20*log10(abs(fft(time_vector)));
    
    % ASSUMPTION - real signal --> even simmetry of the abs of the fft 
    % limits on the first half part of the fft
    N = length(fft_abs_vect)/2;
    audio_data_normalized = (fft_abs_vect(1:N+1));
    
    % calculates the number of seconds of the sound
    %vector_len = round(length(time_vector)/fs);
    
    %normalize the frequency axis
    plot(audio_data_normalized);
    
    % I have the frequency x axis which goes from 0 to 16000
    % I have to scale it to the real frequency range
    % in this case: 0 - 4000 Hz
    
    
    
    

    return;
end

