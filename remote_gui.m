% UNIS:adb2184, bxh2102, jrk2181, jll2219, ljt2130
% Represents a prototype of our simplified remote. 
%

%Pls work
function varargout = remote_gui(varargin)
% REMOTE_GUI MATLAB code for remote_gui.fig
%      REMOTE_GUI, by itself, creates a new REMOTE_GUI or raises the existing
%      singleton*.
%
%      H = REMOTE_GUI returns the handle to a new REMOTE_GUI or the handle to
%      the existing singleton*.
%
%      REMOTE_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REMOTE_GUI.M with the given inputPanel arguments.
%
%      REMOTE_GUI('Property','Value',...) creates a new REMOTE_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before remote_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to remote_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help remote_gui

% Last Modified by GUIDE v2.5 09-Dec-2015 17:26:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @remote_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @remote_gui_OutputFcn, ...
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


% --- Executes just before remote_gui is made visible.
function remote_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to remote_gui (see VARARGIN)

% Choose default command line output for remote_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes remote_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = remote_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% The power button on our remote.
% This button sets up the television screen and volume and channel defaults
% on start and closes open screens (input, channel) upon close.
function power_Callback(hObject, eventdata, handles)
% hObject    handle to power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setCurrentChannel(5);
setLastChannel(5);
setCurrentVolume(10);
setLastVolume(5);
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));
global tv;
tv.channelSelected = false;
tv.volumeSelected = false;
tv.inputSelected = false;
tv.inputIndex = 1;
set(handles.inputPanel, 'Visible', 'off');
if (strcmp(get(handles.baseScreen, 'Visible'),'on'))
    set(handles.baseScreen, 'Visible', 'off');
else
    set(handles.baseScreen, 'Visible', 'on');
end
if (strcmp(get(handles.channels, 'Visible'),'on'))
    set(handles.channels, 'Visible', 'off');
end


% The menu button brings up the menu screen (currently equipped with a 
% list box used to represent the menu)
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(get(handles.mainMenu, 'Visible'),'on'))
    set(handles.mainMenu, 'Visible', 'off');
else
    set(handles.mainMenu, 'Visible', 'on');
end

% Pressing the channel button allows the channel number to be changed, and 
% brings up the channel screen (a list of channels). In this model, a
% non-functioning list of channels is used to represent this list.
% Pressing the channel button again leaves the channel screen, and channels
% can no longer be changed.
function channel_Callback(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
setLastChannelNumber(0);
if (tv.channelSelected == false)
    tv.channelSelected = true;
else 
    tv.channelSelected = false;
end
if (strcmp(get(handles.channels, 'Visible'),'on'))
    set(handles.channels, 'Visible', 'off');
else
    set(handles.channels, 'Visible', 'on');
end


% Pressing the volume button allows the volume number to be changed, and
% pressing again disables this function.
function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
setLastVolumeNumber(0);
if (tv.volumeSelected == false)
    tv.volumeSelected = true;
else 
    tv.volumeSelected = false;
end

% The input button brings up / takes away the input panel,and allows /
% disables the toggling function between inputs.
function input_Callback(hObject, eventdata, handles)
% hObject    handle to inputPanel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (strcmp(get(handles.inputPanel, 'Visible'),'on'))
    set(handles.inputPanel, 'Visible', 'off');
    tv.inputSelected = false;
else
    set(handles.inputPanel, 'Visible', 'on');
    tv.inputSelected = true;
end

% Appends the number one to the channel number or volume number.
function one_Callback(hObject, eventdata, handles)
% hObject    handle to one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 1;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 1;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));



% Appends the number two to the channel number or volume number.
function two_Callback(hObject, eventdata, handles)
% hObject    handle to two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 2;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 2;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% Appends the number three to the channel number or volume number.
function three_Callback(hObject, eventdata, handles)
% hObject    handle to three (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 3;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 3;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));


% Appends the number four to the channel number or volume number.
function four_Callback(hObject, eventdata, handles)
% hObject    handle to four (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 4;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 4;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% Appends the number five to the channel number or volume number.
function five_Callback(hObject, eventdata, handles)
% hObject    handle to five (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 5;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 5;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% Appends the number six to the channel number or volume number.
function six_Callback(hObject, eventdata, handles)
% hObject    handle to six (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 6;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 6;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% Appends the number eight to the channel number or volume number.
function eight_Callback(hObject, eventdata, handles)
% hObject    handle to eight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 8;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 8;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% Appends the number seven to the channel number or volume number.
function seven_Callback(hObject, eventdata, handles)
% hObject    handle to seven (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 7;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 7;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));


% Appends the number nine to the channel number or volume number.
function nine_Callback(hObject, eventdata, handles)
% hObject    handle to nine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10 + 9;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10 + 9;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% Appends the number zero to the channel number or volume number.
function zero_Callback(hObject, eventdata, handles)
% hObject    handle to zero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.channelSelected)
    setLastChannel(getCurrentChannel());
    tv.channelNumber = tv.lastChannelNumber * 10;
    setLastChannelNumber(tv.channelNumber);
    setCurrentChannel(tv.channelNumber);
end
if (tv.volumeSelected)
    setLastVolume(getCurrentVolume());
    tv.volumeNumber = tv.lastVolumeNumber * 10;
    setLastVolumeNumber(tv.volumeNumber);
    setCurrentVolume(tv.volumeNumber);
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% Enables/disables closed captioning. Closed captioning stays enabled/
% disabled regardless of whether the power is turned on or off. 
function ccbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ccbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(get(handles.closedCaptioning, 'Visible'),'off'))
    set(handles.closedCaptioning, 'Visible', 'on')
else
    set(handles.closedCaptioning, 'Visible', 'off')
end

% When undo is pressed, either the channel or volume or both revert to their last states,
% depending on whether channel or volume or both are pressed down.
function undo_Callback(hObject, eventdata, handles)
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global tv;
if (tv.volumeSelected)
        curVol = getCurrentVolume();
        setCurrentVolume(getLastVolume());
        setLastVolume(curVol);
end
if (tv.channelSelected)
    curChann = getCurrentChannel();
    setCurrentChannel(getLastChannel());
    setLastChannel(curChann);
end
set(handles.infobox, 'String', strcat('Channel: ', int2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over power.
function power_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Our menuBox is a dummy listbox representing an actual menu box.
function menuBox_Callback(hObject, eventdata, handles)
% hObject    handle to menuBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menuBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menuBox


% --- Executes during object creation, after setting all properties.
function menuBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menuBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% Our channel list is a dummy list representing the list of channels.
function channelList_Callback(hObject, eventdata, handles)
% hObject    handle to channelList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns channelList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channelList

% --- Executes during object creation, after setting all properties.
function channelList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channelList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% This left button is a representation of pushing the toggle to the left
% side, although this button does not accurately represent how pushing farther
% means scrolling faster. When channel and/or volume are pressed down, 
% pressing this button will decrease the values of the volume or channel. 
% When input is selected, this button flips through the possible input options.
function leftButton_Callback(hObject, eventdata, handles)
% hObject    handle to leftButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
optionsdata = ['TV  '; 'DVD ';'Xbox'];
options = cellstr(optionsdata);
setLastVolumeNumber(0);
setLastChannelNumber(0);
global tv;
if (tv.volumeSelected == true)
        setLastVolume(getCurrentVolume());
        setCurrentVolume(getCurrentVolume() - 1);
end
if (tv.channelSelected == true)
        setLastChannel(getCurrentChannel);
        setCurrentChannel(getCurrentChannel() - 1);
end
if (tv.inputSelected == true)
    if (tv.inputSelected == true)
        if (strcmp(get(handles.inputPanel,'Visible'),'on'))
            if (tv.inputIndex == 1)
                a = size(options);
                tv.inputIndex = a(1,1);
             else
            tv.inputIndex = tv.inputIndex - 1;
             end
        end
    set(handles.inputBox,'String', options(tv.inputIndex,1));
    end
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));

% The enterButton would be used to select objects from a menu list or
% channel list. Since our lists are dummy lists used to represent a list of
% channels a cable company may provide, this enter button has no function
% in this prototype.
function enterButton_Callback(hObject, eventdata, handles)
% hObject    handle to enterButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% This right button is a representation of pushing the toggle to the right
% side, although this button does not accurately represent how pushing farther
% means scrolling faster. When channel and/or volume are pressed down, 
% pressing this button will decrease the values of the volume or channel. 
% When input is selected, this button flips through the possible input options.
function rightButton_Callback(hObject, eventdata, handles)
% hObject    handle to rightButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
optionsdata = ['TV  '; 'DVD ';'Xbox'];
options = cellstr(optionsdata);
setLastVolumeNumber(0);
setLastChannelNumber(0);
global tv;
if (tv.volumeSelected == true)
        setLastVolume(getCurrentVolume);
        setCurrentVolume(getCurrentVolume() + 1);
end
if (tv.channelSelected == true)
        setLastChannel(getCurrentChannel);
        setCurrentChannel(getCurrentChannel() + 1);
end
if (tv.inputSelected == true)

    if (strcmp(get(handles.inputPanel,'Visible'),'on'))
        a = size(options);
        if (tv.inputIndex == a(1, 1))
            tv.inputIndex = 1;
        else
            tv.inputIndex = tv.inputIndex + 1;
        end
    end
    set(handles.inputBox,'String', options(tv.inputIndex,1));
end
set(handles.infobox,'String',strcat('Channel: ' , num2str(getCurrentChannel()), ' Volume: ' , num2str(getCurrentVolume())));
