function [ input_freq ] = get_audio_main_frequency_in_guitar_domain(audio_vector)
%GET_AUDIO_MAIN_FREQUENCY_IN_GUITAR_DOMAIN Summary of this function goes here
%   Detailed explanation goes here

    % calculates the abs of fft of the vector
    fft_abs_vect = abs(fft(audio_vector));

    % ASSUMPTION - real signal --> even simmetry of the abs of the fft 
    % limits on the first half part of the fft
    N = round(length(fft_abs_vect)/2);
    audio_data_normalized = (fft_abs_vect(1:N+1));

    %create a correct x-axis for the data
    upper_interval_frequency = round(TunerConstants.FS/2)+1;
    step = TunerConstants.FS/(2*length(audio_data_normalized));
    x_axis = 1:step:upper_interval_frequency;

    %plot(x_axis(1:length(audio_data_normalized)),audio_data_normalized);


    %as findpeaks on the whole vector is too expensive, we calculare the
    %indexes that represent the bound in which looking for the vector.

    min_freq = 50;
    max_freq = 400;

    min_i = round(min_freq * 2 * length(audio_data_normalized)/TunerConstants.FS);
    max_i = round(max_freq * 2 * length(audio_data_normalized)/TunerConstants.FS);

    % find the peaks in the range of defined frequences
    [~,indexes] = findpeaks(audio_data_normalized(min_i:max_i),'MINPEAKHEIGHT',100,'THRESHOLD',50,'MINPEAKDISTANCE',4);
    
    
    % normalize indexes
    normalized_indexes = indexes*(TunerConstants.FS/(2*length(audio_data_normalized)))+min_freq;
    %disp(normalized_indexes);
    
    % the frequency is the lowest
    input_freq = normalized_indexes(1);

return;
end

