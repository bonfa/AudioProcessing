function [ input_freq ] = get_audio_main_frequency_in_guitar_domain(audio_vector)
%GET_AUDIO_MAIN_FREQUENCY_IN_GUITAR_DOMAIN Summary of this function goes here
%   Detailed explanation goes here

    % calculates the abs of fft of the vector
    fft_abs_vect = abs(fft(audio_vector));

    % ASSUMPTION - real signal --> even simmetry of the abs of the fft 
    % limits on the first half part of the fft
    N = round(length(fft_abs_vect)/2);
    audio_data_normalized = (fft_abs_vect(1:N+1));

    % debug part
    % plot the product with the correct freq axes
    % 
    % create the x axis for the interpolated vector
    %freq_min = 0*TunerConstants.FS/(2*length(audio_data_normalized));
    %freq_max= length(audio_data_normalized)*TunerConstants.FS/(2*length(audio_data_normalized));
    %step_ = (freq_max-freq_min)/length(audio_data_normalized);
    %freq_axes = freq_min:step_:freq_max;
    %plot(freq_axes,audio_data_normalized);
    %figure(2);ù
    %disp(length(audio_vector));
    %disp(length(fft_abs_vect));
    %disp(length(audio_data_normalized));
    %plot(audio_data_normalized);
      
    % Pitch detection - hps METHOD (3rd try)
    
    % calculate the scaled versions of the vector downsampled by the factor
    % 2,3,4 and 5
    fft1 = audio_data_normalized;
    fft2 = downsample(fft1,2);
    fft3 = downsample(fft1,3);
    fft4 = downsample(fft1,4);
    fft5 = downsample(fft1,5);
    
    % As the vectors have different lengths, i use the length of the
    % shortest one for the product. 
    % As the harmonics in which the energy is concentrated are the overtones, 
    % a smart way for isolating the f0 (the pitch) is to multiply the scaled
    % versions of the input downsampled with many factors (1,2,3,4 and 5 here).
    % With this method the pitch is enhanced. 
    k = length(fft5);
    product = (fft1(1:k).*fft2(1:k).*fft3(1:k).*fft4(1:k).*fft5(1:k));

   
    
    
    % min frequency from which starting the analysis of the vector
    min_freq = 40;
    
    % min_i is the index correspondent to 40 hz in the vector
    min_i = round(min_freq * 2 * length(audio_data_normalized)/TunerConstants.FS);
    
    % Fisrt approximation of the pitch, that is the maximum of the resulting function.
    %
    % OSS: as the input is very noisy and the noise is concentrated in the 
    % low frequencies, the maximum is computated from values greater than 
    % 40 hz.
    [m,i] = max(product(min_i:length(product)));
    
    % adjust the index of the vector, adding min_i
    correct_i = i + min_i;
    
    % As the input sound is sampled with low FS (8 Khz) and the downsampled
    % versions are even less precise, an operation of interpolation is
    % introduced in order to improve the precision of the pitch detection.
    
    % Interpolation wit spline
    % not on the whole product function but only around the maximum
    % (interval of length 10 around the maximum)
        
    % create the vector that represents the frequency axes for the range
    % i-10 and i+10    
    minimum_i = correct_i - 10;
    maximum_i = correct_i + 10;
    
    % create the vector
    x = minimum_i:maximum_i;
    % step of the high precision x axis for the interpolating function
    step_finer = 0.001;
    % x-axis for the interpolating function
    finer_x = minimum_i:step_finer:maximum_i;
    % part of the function to be interpolated
    y = product(minimum_i:maximum_i);
    
    % interpolation of the interval around the bad maximum
    interpolated_prod = interp1(x,y,finer_x,'spline');
    
    
    % debug part - plots the values to be interpolated and the
    % interpolation function.
    %
    % the x-axes does not contain the indexes of the vector but the
    % frequencies correspondent to the index
    
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
    plot(x_freq,product(x),'g');
    hold off;
    figure(3);
    plot(product(minimum_i:maximum_i));
    
    
    % calculate again the maximum - higher precision
    [mi,ii] = max(interpolated_prod);
    
    % extract the frequency correspondent to the index of the maximum
    interp_index = minimum_i + (ii*(maximum_i-minimum_i)/length(finer_x));
        
    % the maximum frequency represents a tone only if the maximum is over a
    % threshold, otherwise it is noise
    if mi > 16000    
        input_freq = interp_index*(TunerConstants.FS/(2*length(audio_data_normalized)));%+min_freq;
        %disp(input_freq);
    else    
        input_freq = -1;
    end
return;
end

