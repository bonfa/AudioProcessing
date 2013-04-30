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
    x_axis_from_min_freq = x_axis(40:length(x_axis));

    %figure(2);
    %plot(x_axis(50:length(audio_data_normalized)),audio_data_normalized(50:length(audio_data_normalized)));


    %as findpeaks on the whole vector is too expensive, we calculare the
    %indexes that represent the bound in which looking for the vector.

    min_freq = 40;
    %max_freq = 400;

    min_i = round(min_freq * 2 * length(audio_data_normalized)/TunerConstants.FS);
    %max_i = round(max_freq * 2 * length(audio_data_normalized)/TunerConstants.FS);

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
    product = (fft1(1:k).*fft2(1:k).*fft3(1:k).*fft4(1:k).*fft5(1:k));

   
    
    %calculate the max
    %OSS: in this case the min_i has index 1 --> In order to bring the
    %right x i have to add min_i
    [m,i] = max(product(min_i:length(product)));
    
    correct_i = i + min_i;
    
    % Interpolation
    % create the vector that represents the frequency axes for the range
    % i-1 and i+1 
    minimum_i = correct_i - 10;
    maximum_i = correct_i + 10;
    
    %x = %[minimum_i i maximum_i];    
    x = minimum_i:maximum_i;
    step_finer = 0.001;
    finer_x = minimum_i:step_finer:maximum_i;
    y = product(minimum_i:maximum_i);
    
    % interpolate values i-1,i,i+1
    interpolated_prod = interp1(x,y,finer_x,'spline');
    
%{    
    % create the x axis for the interpolated vector
    interp_freq_min = minimum_i*TunerConstants.FS/(2*length(audio_data_normalized));
    interp_freq_max= maximum_i*TunerConstants.FS/(2*length(audio_data_normalized));
    interp_step = (interp_freq_max-interp_freq_min)/length(finer_x);
    interp_freq_axes = interp_freq_min:interp_step:interp_freq_max;
    
    %create the x axis for the low precision vector
    x_freq = x*TunerConstants.FS/(2*length(audio_data_normalized));
    % plot the original signal plus the interpolation around the maximum
    figure(2);
    
    plot(interp_freq_axes(1:length(interpolated_prod)),interpolated_prod);    
    hold on;
    
    plot(x_freq,product(x),'ro');
    hold off;
    figure(3);
    plot(product(minimum_i:maximum_i));
%}    
    % calculate again the maximum and normalize that frequency
    [mi,ii] = max(interpolated_prod);
    
    
    interp_index = minimum_i + (ii*(maximum_i-minimum_i)/length(finer_x));
        
    if mi > 16000
        
        input_freq = interp_index*(TunerConstants.FS/(2*length(audio_data_normalized)));%+min_freq;
        %disp(input_freq);
        
    else    
        input_freq = -1;
    end
return;
end

