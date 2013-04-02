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

    %figure(2);
    %plot(x_axis(50:length(audio_data_normalized)),audio_data_normalized(50:length(audio_data_normalized)));


    %as findpeaks on the whole vector is too expensive, we calculare the
    %indexes that represent the bound in which looking for the vector.

    min_freq = 40;
    max_freq = 400;

    min_i = round(min_freq * 2 * length(audio_data_normalized)/TunerConstants.FS);
    max_i = round(max_freq * 2 * length(audio_data_normalized)/TunerConstants.FS);

    %{
    % version 1 - with findpeaks
        % find the peaks in the range of defined frequences
        [~,indexes] = findpeaks(audio_data_normalized(min_i:max_i),'MINPEAKHEIGHT',100,'THRESHOLD',50,'MINPEAKDISTANCE',4);


        % normalize indexes
        normalized_indexes = indexes*(TunerConstants.FS/(2*length(audio_data_normalized)))+min_freq;
        %disp(normalized_indexes);

        % the frequency is the lowest
        input_freq = normalized_indexes(1);
    %}
    %{
    % version 2 - with maximum
    threshold = 30;
    [m,index] = max(audio_data_normalized(min_i:max_i));
       
    if m > threshold
        normalized_indexes = index*(TunerConstants.FS/(2*length(audio_data_normalized)))+min_freq;
        input_freq = normalized_indexes;    
        disp(normalized_indexes);
    else    
        input_freq = -1;
    %}
        
    % version 3 - hps METHOD
    
    %todo- allungare il vettore su cui calcolare il sottocampionamento
    fft1 = audio_data_normalized;
    fft2 = downsample(fft1,2);
    fft3 = downsample(fft1,3);
    fft4 = downsample(fft1,4);
    fft5 = downsample(fft1,5);
    
    % as the vectors have different lengths, i use the length of the
    % shortest one for the product. 
    % In fact the main frequence is in the common part to all the vectors
    k = length(fft5);
    prod = (fft1(1:k).*fft2(1:k).*fft3(1:k).*fft4(1:k).*fft5(1:k));
    
    [m,i] = max(prod(min_i:length(prod)));
    
    %disp(i*(TunerConstants.FS/(2*length(audio_data_normalized)))+min_freq); 
    %disp(m);
    if m > 20000
        input_freq = i*(TunerConstants.FS/(2*length(audio_data_normalized)))+min_freq;
        %figure(2);
        %plot(prod);
        %disp(input_freq);
    else    
        input_freq = -1;
    end
return;
end

