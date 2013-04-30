function [ min_cb, max_cb ] = get_critical_bandwidth_range( fc )
%GET_CRITICAL_BANDWIDTH_RANGE 
% Calculate the critical bandwidth of the input frequency fc
%
% The critical bandwidth is given by the formula below.
% Then the extremes of the range are returned

    critical_bandwidth = 25 + 75 * ((1 + 14 * (fc/1000)^2)^0.69);
    
    min_cb = fc - critical_bandwidth/2;
    max_cb = fc + critical_bandwidth/2;
    
    return;
end

