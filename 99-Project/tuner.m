function varargout = tuner(varargin)
% TUNER M-file for tuner.fig
%      TUNER, by itself, creates a new TUNER or raises the existing
%      singleton*.
%
%      H = TUNER returns the handle to a new TUNER or the handle to
%      the existing singleton*.
%
%      TUNER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUNER.M with the given input arguments.
%
%      TUNER('Property','Value',...) creates a new TUNER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tuner_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tuner_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tuner

% Last Modified by GUIDE v2.5 30-Mar-2013 15:43:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tuner_OpeningFcn, ...
                   'gui_OutputFcn',  @tuner_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end

% --- Executes just before tuner is made visible.
function tuner_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tuner (see VARARGIN)

% Choose default command line output for tuner
handles.output = hObject;


%define the recorder
handles.recorder = audiorecorder;

% define the timer and its parameters
%handles.timer = timer('executionMode','fixedDelay','TimerFcn',{@demo_tune,handles},'Period',TunerConstants.TIMER_PERIOD);
handles.timer = timer('executionMode','fixedDelay','TimerFcn',{@tune,handles},'Period',TunerConstants.TIMER_PERIOD);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tuner wait for user response (see UIRESUME)
% uiwait(handles.mainWindow);

end

% --- Outputs from this function are returned to the command line.
function varargout = tuner_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end









% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
        %start working        
        %update the colors of the panel which represent the frequency axes
        %set(handles.frequencyAxes,'BackgroundColor',[0 0 0]);
        %disp(get(handles.Bar,'Position'));
        % disable the button Start
        set(hObject,'Enable','off');
        % change the colors of the Button Start
        set(hObject,'BackgroundColor',TunerConstants.BUTTONS_DISABLED_BACKGROUD_COLOR);
        set(hObject,'ForegroundColor',TunerConstants.BUTTONS_DISABLED_FOREGROUND_COLOR);
        % change the help string
        set(hObject,'TooltipString','');
        
        % enable the button Stop
        set(handles.StopButton,'Enable','on');
        % change the colors of the Button Stop
        set(handles.StopButton,'BackgroundColor',TunerConstants.BUTTON_STOP_ENABLED_BACKGROUND_COLOR);
        set(handles.StopButton,'ForegroundColor',TunerConstants.BUTTON_STOP_ENABLED_FOREGROUND_COLOR);
        % change the help string
        set(handles.StopButton,'TooltipString',TunerConstants.BUTTON_STOP_ENABLED_TOOLTIP_MEX);
        
        % update the colors of the panel which represents the frequency axes
        %set(handles.frequencyAxes,'BackgroundColor',[0 0 0]);
        set(handles.frequencyAxes,'BackgroundColor',TunerConstants.AXES_BEMOLLE_DIESIS_ENABLED_COLOR);
        
        % update the colors of the two labels
        set(handles.Bemolle,'ForegroundColor',TunerConstants.AXES_BEMOLLE_DIESIS_ENABLED_COLOR);
        set(handles.Diesis,'ForegroundColor',TunerConstants.AXES_BEMOLLE_DIESIS_ENABLED_COLOR);
        
        % change the message with the possibilities
        set(handles.HelpMex,'String',TunerConstants.HELP_MESSAGE_FOR_TUNING);
        set(handles.HelpMex,'ForegroundColor',TunerConstants.HELP_MESSAGE_ENABLED_FOREGROUND_COLOR);
        
        % change the color of the level
        set(handles.Bar,'BackgroundColor',TunerConstants.BAR_ENABLED_BACKGROUND_COLOR);
        
        %Change the color of the strings -20hz ... +20hz
        set(handles.min20str,'ForegroundColor',TunerConstants.AXES_BEMOLLE_DIESIS_ENABLED_COLOR);
        set(handles.min10str,'ForegroundColor',TunerConstants.AXES_BEMOLLE_DIESIS_ENABLED_COLOR);
        set(handles.zeroStr,'ForegroundColor',TunerConstants.AXES_BEMOLLE_DIESIS_ENABLED_COLOR);
        set(handles.plus10str,'ForegroundColor',TunerConstants.AXES_BEMOLLE_DIESIS_ENABLED_COLOR);
        set(handles.plus20str,'ForegroundColor',TunerConstants.AXES_BEMOLLE_DIESIS_ENABLED_COLOR);
        
        %start the tuning operation
        start(handles.timer);
        
        %start the recoder
        record(handles.recorder);
        
        %disable findpeaks warnings
        warning('OFF', 'signal:findpeaks:largeMinPeakHeight');
end
        
        
% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
%stop working        
               
        % disable the button Start
        set(hObject,'Enable','off');
        % change the colors of the Button Start
        set(hObject,'BackgroundColor',TunerConstants.BUTTONS_DISABLED_BACKGROUD_COLOR);
        set(hObject,'ForegroundColor',TunerConstants.BUTTONS_DISABLED_FOREGROUND_COLOR);
        % change the help string
        set(hObject,'TooltipString','');
        
        % enable the button Start
        set(handles.StartButton,'Enable','on');
        % change the colors of the Button Start
        set(handles.StartButton,'BackgroundColor',TunerConstants.BUTTON_START_ENABLED_BACKGROUD_COLOR);
        set(handles.StartButton,'ForegroundColor',TunerConstants.BUTTON_STOP_ENABLED_FOREGROUND_COLOR);
        % change the help string
        set(handles.StartButton,'TooltipString',TunerConstants.BUTTON_START_ENABLED_TOOLTIP_MEX);
        
        % update the colors of the panel which represents the frequency axes
        set(handles.frequencyAxes,'BackgroundColor',TunerConstants.BUTTONS_DISABLED_BACKGROUD_COLOR);
        
        % update the colors of the two labels
        set(handles.Bemolle,'ForegroundColor',TunerConstants.BUTTONS_DISABLED_BACKGROUD_COLOR);
        set(handles.Diesis,'ForegroundColor',TunerConstants.BUTTONS_DISABLED_BACKGROUD_COLOR);
        
        % change the color of the bar (frequency correctness)
        set(handles.Bar,'BackgroundColor',TunerConstants.BUTTONS_DISABLED_FOREGROUND_COLOR);
        set(handles.HelpMex,'ForegroundColor',TunerConstants.HELP_MESSAGE_DISABLED_FOREGROUND_COLOR);
   
        % change the message with the possibilities
        set(handles.HelpMex,'String',TunerConstants.HELP_MESSAGE_FOR_STARTING);
        
        %Change the color of the strings -20hz ... +20hz
        set(handles.min20str,'ForegroundColor',TunerConstants.BUTTONS_DISABLED_BACKGROUD_COLOR);
        set(handles.min10str,'ForegroundColor',TunerConstants.BUTTONS_DISABLED_BACKGROUD_COLOR);
        set(handles.zeroStr,'ForegroundColor',TunerConstants.BUTTONS_DISABLED_BACKGROUD_COLOR);
        set(handles.plus10str,'ForegroundColor',TunerConstants.BUTTONS_DISABLED_BACKGROUD_COLOR);
        set(handles.plus20str,'ForegroundColor',TunerConstants.BUTTONS_DISABLED_BACKGROUD_COLOR);      
        
        % set the text of the note to ''
        set(handles.Note,'String','');
        
        %set the position of the bar in the middle
        set(handles.Bar,'Position',TunerConstants.BAR_STARTING_POSITION);
        
        %stop the tuning operation
        stop(handles.timer);
               
        %stop the recoder
        stop(handles.recorder);
        
        %these commands show that the recorder works correctly
            %pl = getplayer(handles.recorder);
            %disp('play');
            %playblocking(pl);
end

     
%% functions that update the GUI

function updateGUI(handles,tone_frequency,distance)
    % updates the name of the tone and the level of frequency
    
    %calculates the new x of the Bar
    newX = calculateNewX(handles,distance);
    
    %calculates the name of the tone
    newTone = getToneName(tone_frequency);
    
    %updates the Bar
    updateXBar(handles,newX);
    
    %updates the name of the note
    updateNoteName(handles,newTone);
   
end


function tone_name = getToneName(tone_frequency)
    %set the english name of the tone basing on the frequency
    if tone_frequency == TunerConstants.E_LOW_FREQ
        tone_name = TunerConstants.E_LOW_NAME;
    elseif tone_frequency == TunerConstants.A_FREQ
        tone_name = TunerConstants.A_NAME;
    elseif tone_frequency == TunerConstants.D_FREQ
        tone_name = TunerConstants.D_NAME;
    elseif tone_frequency == TunerConstants.G_FREQ
        tone_name = TunerConstants.G_NAME;
    elseif tone_frequency == TunerConstants.B_FREQ
        tone_name = TunerConstants.B_NAME;
    elseif  tone_frequency == TunerConstants.E_HIGH_FREQ
        tone_name = TunerConstants.E_HIGH_NAME;
    elseif  tone_frequency == TunerConstants.G_HIGH_FREQ
        tone_name = TunerConstants.G_NAME;
    else
        % tone_frequency = -1 or 0
        tone_name = TunerConstants.EMPTY_STRING;
    end
    return;
end


function updateNoteName(handles,note_name)
    % updates the name of the note on the GUI
    set(handles.Note,'String',note_name);
end

function updateXBar(handles,x)
    %updates the position of the level Bar 
    pos = getpixelposition(handles.Bar,true);
    
    %disp(x);
    disp(pos(2));
    
    pos(1) = x;
    %disp(pos(2));
    pos(2) = TunerConstants.BAR_Y;
    %disp(pos);
    %disp(pos);
    setpixelposition(handles.Bar,pos,true);
    
end


function newX = calculateNewX(handles,distance)
    % calculates the new x of the bar inside the panel. 
    % such value represents the misplacement between the right tone and the
    % input one
    
    % the frequence range is -50,50
    % the panel length is 529
    % the bar length is 5
    % the space on the right and on the left is 262
    % 1hz is 262/50 pixels
    frequenceRange = TunerConstants.FREQ_RANGE;
    panelDimension = getpixelposition(handles.frequencyAxes,true);
    panelLenght = panelDimension(3);
    
    barDimension = getpixelposition(handles.Bar,true);
    barLength = barDimension(3);
    RangeInPixel = round((panelLenght - barLength)/2);
    
    ratioHzPixel = RangeInPixel/frequenceRange;
    
    theoricPosition = round(ratioHzPixel*distance)+RangeInPixel;
    
    if theoricPosition > panelLenght 
        %if the new X is over the maximum, its value is set to the maximum
        newX = panelLenght-barLength;
    elseif theoricPosition < 1
        %if the new X is below the minimum, its value is set to the minimum
        newX = 1; 
    else
        % the X is correct
        newX = theoricPosition;
    end
    
    newX = newX + panelDimension(1);
    %disp(newX);
    return;
end


%% function that have to be called when every timer timestamp
% It's the function that tunes the input sound.

function tune(src, evt,handles)
    % callback of the tuning_timer
        
    % stops the audiorecorder
    stop(handles.recorder);
    
    try
        % takes the audio data
        audio_vector = getaudiodata(handles.recorder);

        % starts again the audio recorder
        record(handles.recorder);

        % processes the audio and extracts the frequency of the sound
        input_freq = get_audio_main_frequency_in_guitar_domain(audio_vector);
        
        % updates the GUI
        [nearest_frequency,distance] = get_nearest_frequency_and_distance(input_freq);

        %disp(distance);
        
        % updates the bar and the note
        updateGUI(handles,nearest_frequency,distance);
    catch err
        %print the error
        disp(err.message);
        
        % starts again the audio recorder
        record(handles.recorder);
        
        % updates the bar and the note
        updateGUI(handles,-1,0);
    end
end
