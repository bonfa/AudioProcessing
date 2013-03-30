function [ nearest_frequency,distance ] = get_nearest_frequency_and_distance( input_freq )
%GET_NEAREST_FREQUENCY_AND_DISTANCE Summary of this function goes here
%   Detailed explanation goes here
    
    reference_strings_tones = [82.4, 110, 146.8, 196, 246.9, 329.6];
    
    [~,i] = min(abs(reference_strings_tones - input_freq));
    
    nearest_frequency = reference_strings_tones(i);
    distance = input_freq - nearest_frequency;
    
    return;
end

