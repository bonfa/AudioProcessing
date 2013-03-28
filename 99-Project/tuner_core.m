classdef tuner_core
    %TUNER_CORE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    methods
        function TC = tuner_core()
        end
        function [freq,distance] = tune_example(TC)
            path = './guitar_chords/';
            note = 'E_8khz_16bps.wav';
           
            name_file = strcat(path,note);
            
            fs = 8000;
            disp('Play');
            a = wavread(name_file);

            time_vector = a;
            % calculates the abs of fft of the vector
            fft_abs_vect = abs(fft(time_vector));

            % ASSUMPTION - real signal --> even simmetry of the abs of the fft 
            % limits on the first half part of the fft
            N = round(length(fft_abs_vect)/2);
            audio_data_normalized = (fft_abs_vect(1:N+1));

            %create a correct x-axis for the data
            upper_interval_frequency = round(fs/2)+1;
            step = fs/(2*length(audio_data_normalized));
            x_axis = 1:step:upper_interval_frequency;

            plot(x_axis(1:length(audio_data_normalized)),audio_data_normalized);


            %as findpeaks on the whole vector is too expensive, we calculare the
            %indexes that represent the bound in which looking for the vector.

            min_freq = 50;
            max_freq = 400;

            min_i = round(min_freq * 2 * length(audio_data_normalized)/fs);
            max_i = round(max_freq * 2 * length(audio_data_normalized)/fs);

            % find the peaks in the range of defined frequences
            [peaks,indexes] = findpeaks(audio_data_normalized(min_i:max_i),'MINPEAKHEIGHT',1000,'THRESHOLD',700,'MINPEAKDISTANCE',4);

            % normalize indexes
            normalized_indexes = indexes*(fs/(2*length(audio_data_normalized)))+min_freq;

            % the frequency is the lowest
            input_freq = normalized_indexes(1);

            % get nearest frequency and misplacement
            disp(input_freq);
            [freq,distance] = get_nearest_frequency_and_distance(input_freq);

            
            % display the info
            disp(['Reference Tone [Hz]: ', num2str(freq)]);
            disp(['Distance [Hz]: ', num2str(distance)]);
        end
        
    
end

