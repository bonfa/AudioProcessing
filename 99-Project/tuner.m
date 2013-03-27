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

% Last Modified by GUIDE v2.5 27-Mar-2013 11:40:31

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


% --- Executes just before tuner is made visible.
function tuner_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tuner (see VARARGIN)

% Choose default command line output for tuner
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tuner wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tuner_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;








% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
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
        set(handles.frequencyAxes,'BackgroundColor',[0 0 0]);
        
        % update the colors of the two labels
        set(handles.Bemolle,'ForegroundColor',[0 0 0]);
        set(handles.Diesis,'ForegroundColor',[0 0 0]);
        
        % change the message with the possibilities
        set(handles.HelpMex,'String','Just tune your guitar. To close press STOP.');
        
        
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
   
        % change the message with the possibilities
        set(handles.HelpMex,'String','Press button START to start using the tuner');


     
