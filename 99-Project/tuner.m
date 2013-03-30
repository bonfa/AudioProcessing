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

% define the timer and its parameters
handles.timer = timer('executionMode','fixedDelay','TimerFcn',{@demo_tune,handles},'Period',1);

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
        
        % disable the button Start
        set(hObject,'Enable','off');
        % change the colors of the Button Start
        set(hObject,'BackgroundColor',[.314 .314 .314]);
        set(hObject,'ForegroundColor',[.235 .235 .235]);
        % change the help string
        set(hObject,'TooltipString','');
        
        % enable the button Stop
        set(handles.StopButton,'Enable','on');
        % change the colors of the Button Stop
        set(handles.StopButton,'BackgroundColor',[.6 .2 0]);
        set(handles.StopButton,'ForegroundColor',[0 0 0])
        % change the help string
        set(handles.StopButton,'TooltipString','Press to stop');
        
        % update the colors of the panel which represents the frequency axes
        %set(handles.frequencyAxes,'BackgroundColor',[0 0 0]);
        set(handles.frequencyAxes,'BackgroundColor',[.53 .32 .32]);
        
        % update the colors of the two labels
        set(handles.Bemolle,'ForegroundColor',[.53 .32 .32]);
        set(handles.Diesis,'ForegroundColor',[.53 .32 .32]);
        
        % change the message with the possibilities
        set(handles.HelpMex,'String','Just tune your guitar. To close press STOP.');
        set(handles.HelpMex,'ForegroundColor',[.93 .165 .32]);
        
        % change the color of the level
        set(handles.Bar,'BackgroundColor',[0 0 0]);
        
        %start the tuning operation
        start(handles.timer);
end
        
        
% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
%stop working        
               
        % disable the button Start
        set(hObject,'Enable','off');
        % change the colors of the Button Start
        set(hObject,'BackgroundColor',[.314 .314 .314]);
        set(hObject,'ForegroundColor',[.235 .235 .235]);
        % change the help string
        set(hObject,'TooltipString','');
        
        % enable the button Start
        set(handles.StartButton,'Enable','on');
        % change the colors of the Button Start
        set(handles.StartButton,'BackgroundColor',[0 .6 0]);
        set(handles.StartButton,'ForegroundColor',[0 0 0])
        % change the help string
        set(handles.StartButton,'TooltipString','Press to start using the tuner');
        
        % update the colors of the panel which represents the frequency axes
        set(handles.frequencyAxes,'BackgroundColor',[.314 .314 .314]);
        
        % update the colors of the two labels
        set(handles.Bemolle,'ForegroundColor',[.314 .314 .314]);
        set(handles.Diesis,'ForegroundColor',[.314 .314 .314]);
        
        % change the color of the bar (freqency correctness)
        set(handles.Bar,'BackgroundColor',[.235 .235 .235]);
        set(handles.HelpMex,'ForegroundColor',[0 1 1]);
   
        % change the message with the possibilities
        set(handles.HelpMex,'String','Press button START to start using the tuner');
        
        %stop the tuning operation
        stop(handles.timer);
         
        % set the text of the note to ''
        set(handles.Note,'String','');
end

     
%% functions that update the GUI

function updateGUI(handles,tone_frequency,distance)
    % updates the name of the tone and the level of frequency
    newX = calculateNewX(handles,distance);
    updateXBar(handles,newX);
    newTone = getToneName(tone_frequency);
    updateNoteName(handles,newTone);
    %drawnow();
end


function tone_name = getToneName(tone_frequency)
    %set the english name of the tone basing on the frequency
    if tone_frequency == 82.4 
        tone_name = 'E';
    elseif tone_frequency == 110
        tone_name = 'A';
    elseif tone_frequency == 146.8 
        tone_name = 'D';
    elseif tone_frequency == 196 
        tone_name = 'G';
    elseif tone_frequency == 246.9 
        tone_name = 'B';
    elseif  tone_frequency == 329.6
        tone_name = 'E';
    else
        tone_name = '';
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
    pos(1) = x;
    
    %disp(pos);
    setpixelposition(handles.Bar,pos,true);
    
end


function newX = calculateNewX(handles,distance)
    % calculates the new x of the bar inside the panel. 
    % such value represents the misplacement between the right tone and the
    % input one
    
    % the frequence range is -20,20
    % the panel length is 529
    % the bar length is 5
    % the space on the right and on the left is 262
    % 1hz is 262/20 pixels
    frequenceRange = 20;
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
    

function mispl = getMisplacementPercentage(distance)
    % returns the percentage on the displacement.
    % 100% means that the 
    %over 20 hz the difference is max
    if distance >= 20
        mispl = 100;
    elseif distance <= -20
        mispl = -100;    
    else      
        mispl = distance/20*100;     
    end    
    return;
end


function xCenter = getcenteredX(handles)
    %returns the x of the center of panel frequencyAxes
    pos = get(handles.frequencyAxes,'Position');
    xCenter = pos(1)+pos(3)/2;
    return;
end

%% functions that set the timer

function demo_tune(src, evt,handles)
    % callback of the tuning_timer
    % demo version
    
    % take a random value between 60 and 350
    a = 60 + 290*rand;
    %test con i valori limite :)
    %a = 62.4;
    %a = 349.6;
    %disp(a);
    % takes the frequency and the distance
    [nearest_frequency,distance] = get_nearest_frequency_and_distance(a);
    
    % updates the bar and the note
    updateGUI(handles,nearest_frequency,distance);
end
