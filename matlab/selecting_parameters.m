function varargout = selecting_parameters(varargin)
% SELECTING_PARAMETERS MATLAB code for selecting_parameters.fig
%      SELECTING_PARAMETERS, by itself, creates a new SELECTING_PARAMETERS or raises the existing
%      singleton*.
%
%      H = SELECTING_PARAMETERS returns the handle to a new SELECTING_PARAMETERS or the handle to
%      the existing singleton*.
%
%      SELECTING_PARAMETERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECTING_PARAMETERS.M with the given input arguments.
%
%      SELECTING_PARAMETERS('Property','Value',...) creates a new SELECTING_PARAMETERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before selecting_parameters_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to selecting_parameters_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help selecting_parameters

% Last Modified by GUIDE v2.5 28-Aug-2014 15:51:14
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @selecting_parameters_OpeningFcn, ...
                   'gui_OutputFcn',  @selecting_parameters_OutputFcn, ...
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


% --- Executes just before selecting_parameters is made visible.
function selecting_parameters_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to selecting_parameters (see VARARGIN)

% Choose default command line output for selecting_parameters
handles.output = hObject;
global ip;
global portXPLANE;


%Ip and Ports
ip = '127.0.0.1';   
portXPLANE  = 49000; 
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes selecting_parameters wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = selecting_parameters_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes('Position', [0.0 0.86 .6 .14]);
 [x,map] = imread('DU2SRI_Logo','png');
 image(x);
 set(gca,'visible','off');
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pb_clearall.
function pb_clearall_Callback(hObject, eventdata, handles)
% hObject    handle to pb_clearall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%% Define computer-specific variables
%Modify these values to be those of your first computer:
global ip;
global portXPLANE;



%% Create UDP Object
udpSocket = dsp.UDPSender('RemoteIPAddress',ip,'RemoteIPPort',portXPLANE);
%% Connect to UDP Object
%fopen(udpSocket);
% 


%%Clear UDP
number_of_labels = 126; %--> DO NOT CHANGE THIS NUMBER 
MaxSize = (number_of_labels+1)*4+5;

for i=1:MaxSize
    clear_packet(i) = uint8('0');
end

clear_packet(1) = uint8('U');
clear_packet(2) = uint8('S');
clear_packet(3) = uint8('E');
clear_packet(4) = uint8('L');
label = 0;
for i=6:4:MaxSize
    clear_packet(i) = uint8(label);
    label= label+1;
end

step(udpSocket, clear_packet);

%%Clear cockpit
clear_packet(1) = uint8('U');
clear_packet(2) = uint8('C');
clear_packet(3) = uint8('O');
clear_packet(4) = uint8('C');

step(udpSocket, clear_packet);
release(udpSocket); 

% --- Executes on button press in pb_helicopter.
function pb_helicopter_Callback(hObject, eventdata, handles)
% hObject    handle to pb_helicopter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ip;
global portXPLANE;


%clear all
pb_clearall_Callback();

%% Create UDP Object
udpSocket = dsp.UDPSender('RemoteIPAddress',ip,'RemoteIPPort',portXPLANE);
%% Select Helicopter Data on UDP
packet = [uint8('DSEL0') uint8(8) uint8('000') uint8(13) uint32('000') uint8(16) uint32('000') uint8(17) uint32('000') uint8(21) uint32('000') uint8(39) uint32('000')];
step(udpSocket, packet);
%% Select Helicopter Data on Cockpit
packet = [uint8('DCOC ') uint8(8) uint8('000') uint8(13) uint32('000') uint8(16) uint32('000') uint8(17) uint32('000') uint8(21) uint32('000') uint8(39) uint32('000')];
step(udpSocket, packet);
release(udpSocket);

% --- Executes on button press in pb_fixedwing.
function pb_fixedwing_Callback(hObject, eventdata, handles)
% hObject    handle to pb_fixedwing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ip;
global portXPLANE;


%clear all
pb_clearall_Callback();


%% Create UDP Object
udpSocket = dsp.UDPSender('RemoteIPAddress',ip,'RemoteIPPort',portXPLANE);
%% Select Helicopter Data on UDP
packet = [uint8('DSEL0') uint8(3) uint8('000') uint8(4) uint32('000') uint8(8) uint32('000') uint8(13) uint32('000') uint8(16) uint32('000') uint8(17) uint32('000') uint8(20) uint32('000') uint8(26) uint32('000')];
step(udpSocket, packet)
%% Select Helicopter Data on Cockpit
packet = [uint8('DCOC0') uint8(3) uint8('000') uint8(4) uint32('000') uint8(8) uint32('000') uint8(13) uint32('000') uint8(16) uint32('000') uint8(17) uint32('000') uint8(20) uint32('000') uint8(26) uint32('000')];
step(udpSocket, packet)
release(udpSocket);



function ip_adress_Callback(hObject, eventdata, handles)
% hObject    handle to ip_adress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ip_adress as text
%        str2double(get(hObject,'String')) returns contents of ip_adress as a double
global ip;

  NewStrVal = get(hObject,'String');
  NewVal = str2double(NewStrVal);
  

  % Check that the entered value falls within the allowable range
  if  isempty(NewStrVal)
     set(hObject,'String','127.0.0.1');
    
  else
    set(hObject,'String',NewStrVal);
    ip = NewStrVal;
    % Set the Gain parameter of the Kf Gain Block to the new value
    %  set_param('Piper_Autopilot/Roll_ref','Gain',NewStrVal)
  end
  


% --- Executes during object creation, after setting all properties.
function ip_adress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ip_adress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PortNumber_Callback(hObject, eventdata, handles)
% hObject    handle to PortNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PortNumber as text
%        str2double(get(hObject,'String')) returns contents of PortNumber as a double

global portXPLANE;

  NewStrVal = get(hObject,'String');
  

  % Check that the entered value falls within the allowable range
  if  isempty(NewStrVal)
     set(hObject,'String','49000');
     portXPLANE = 49000;
  else
    set(hObject,'String',NewStrVal);
    portXPLANE = str2double(NewStrVal)
    % Set the Gain parameter of the Kf Gain Block to the new value
    %  set_param('Piper_Autopilot/Roll_ref','Gain',NewStrVal)
  end



% --- Executes during object creation, after setting all properties.
function PortNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PortNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_free_xplane.
function pb_free_xplane_Callback(hObject, eventdata, handles)
% hObject    handle to pb_free_xplane (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global ip;
global portXPLANE;


%% Create UDP Object
udpSocket = dsp.UDPSender('RemoteIPAddress',ip,'RemoteIPPort',portXPLANE);
%% Select Helicopter Data on UDP
%No_Comand = single(-999);


header = (([uint8(68) uint8(65) uint8(84) uint8(65) uint8(0)]));
No_Comand = (uint8([uint8(0) uint8(192) uint8(121) uint8(196)]));

Surface_header = (uint8([uint8(8) uint8(0) uint8(0) uint8(0)]));

surfaces_control_cmd = [Surface_header No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand];

Trim_header = ([uint8(13) uint8(0) uint8(0) uint8(0)]);


trim_control_cmd = [ Trim_header No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand];

Throttle_header = (uint8([uint8(25) uint8(0) uint8(0) uint8(0)]));
trhottle_cmd = [Throttle_header No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand];


Collective_header = (uint8([uint8(39) uint8(0) uint8(0) uint8(0)]));
collective_cmd = [ Collective_header No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand No_Comand];

packet = [header surfaces_control_cmd trim_control_cmd trhottle_cmd collective_cmd];
step(udpSocket, packet);




%data_out = [surfaces_control_cmd trim_control_cmd trhottle_cmd collective_cmd];

%% Select Helicopter Data on Cockpit
release(udpSocket);
