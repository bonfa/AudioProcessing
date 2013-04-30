classdef TunerConstants
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Constant = true)
        % GUI STAFF
        BUTTON_START_ENABLED_BACKGROUD_COLOR = [0 .6 0];
        BUTTON_START_DISABLED_FOREGROUND_COLOR = [0 0 0];
        
        BUTTON_STOP_ENABLED_BACKGROUND_COLOR = [.6 .2 0];
        BUTTON_STOP_ENABLED_FOREGROUND_COLOR = [0 0 0];
        
        BUTTONS_DISABLED_BACKGROUD_COLOR = [.314 .314 .314];
        BUTTONS_DISABLED_FOREGROUND_COLOR = [.235 .235 .235];
        
        AXES_BEMOLLE_DIESIS_ENABLED_COLOR = [.53 .32 .32];

        HELP_MESSAGE_ENABLED_FOREGROUND_COLOR = [.93 .165 .32];
        HELP_MESSAGE_DISABLED_FOREGROUND_COLOR = [0 1 0];
        
        BAR_ENABLED_BACKGROUND_COLOR = [0 0 0];
        
        BUTTON_START_ENABLED_TOOLTIP_MEX = 'Press to start using the tuner';
        BUTTON_STOP_ENABLED_TOOLTIP_MEX = 'Press to stop';
        
        HELP_MESSAGE_FOR_STARTING = 'Press button START to start using the tuner';
        HELP_MESSAGE_FOR_TUNING = 'Just tune your guitar. To close press STOP.';
        
        BAR_STARTING_POSITION = [52.175 .021 1.058 3.091];
        
        % TONE FREQUENCIES
        E_LOW_FREQ = 82.4;
        A_FREQ = 110;
        D_FREQ = 146.8;
        G_FREQ = 196;
        B_FREQ = 246.9;
        E_HIGH_FREQ = 329.6;
        G_HIGH_FREQ = 392;
    
        % TONE NAMES
        E_LOW_NAME = 'E';
        A_NAME = 'A';
        D_NAME = 'D';
        G_NAME = 'G';
        B_NAME = 'B';
        E_HIGH_NAME = 'E';
        EMPTY_STRING = '-';
        
        
        % OTHER PARAMETERS
        FREQ_RANGE = 50;
        TIMER_PERIOD = 1;
        BAR_Y = 35.5384615384615; % this is a value inserted in ordr to supply to an error in linux --> the bar moving continuously decrease its y
        
        FS = 8000;
    end
    
    methods
    end
    
end

