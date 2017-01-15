function varargout = colorHormization(varargin)
% COLORHORMIZATION MATLAB code for colorHormization.fig
%      COLORHORMIZATION, by itself, creates a new COLORHORMIZATION or raises the existing
%      singleton*.
%
%      H = COLORHORMIZATION returns the handle to a new COLORHORMIZATION or the handle to
%      the existing singleton*.
%
%      COLORHORMIZATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLORHORMIZATION.M with the given input arguments.
%
%      COLORHORMIZATION('Property','Value',...) creates a new COLORHORMIZATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before colorHormization_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to colorHormization_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help colorHormization

% Last Modified by GUIDE v2.5 12-Jan-2017 14:49:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @colorHormization_OpeningFcn, ...
                   'gui_OutputFcn',  @colorHormization_OutputFcn, ...
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


% --- Executes just before colorHormization is made visible.
function colorHormization_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to colorHormization (see VARARGIN)

set(handles.axes3,'xtick',[],'ytick',[])
set(handles.axes6,'xtick',[],'ytick',[])
set(handles.axes1,'xtick',[],'ytick',[])
set(handles.axes8,'xtick',[],'ytick',[])
set(handles.axes9,'xtick',[],'ytick',[])
readHueWheelImage(handles.axes8)
showImage(handles.axes9, 'UI_Component/type.png')


% Choose default command line output for colorHormization
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes colorHormization wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = colorHormization_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

val = get(hObject, 'Value');
str = get(hObject, 'String' );
idx = -1;
switch str{val}
    case 'i type'
        idx = 1;
    case 'V type'
        idx = 2;
    case 'L type'
        idx = 3;
    case 'I type'
        idx = 4;
    case 'T type'
        idx = 5;
    case 'Y type'
        idx = 6;
    case 'X type'
        idx = 7;
end

setCurrIdx(idx);
[ imRecover, im_wheel ] = getImg( 0 );
showImage( handles.axes1, imRecover );
showImage( handles.axes3, im_wheel );


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chooseImageButton.
function chooseImageButton_Callback(hObject, eventdata, handles)
% hObject    handle to chooseImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uigetfile({'*.jpg';'*.png';'*.bmp';'*.jpeg'});
imagePath = fullfile( pathname, filename );

%store image path as global variable
setImagePath(imagePath);

%extract color information from img, and store those image as global
%variable, then output the result of best matching template
[imRecover, im_wheel, allBound, im_hsv, hue_len, im_hsv_hist, idx ] = doColorHarmon( imagePath );

showImage( handles.axes6, imagePath );
showImage( handles.axes1, imRecover );
showImage( handles.axes3, im_wheel );

% store allBound to global
setImgInfo(allBound, im_hsv, hue_len, im_hsv_hist );
setCurrIdx(idx);


% --- Executes on button press in saveImageButton.
function saveImageButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

F = getframe(handles.axes1);
Image = frame2im(F);
imwrite(Image, 'output/result.jpg')

%imwrite( handles.axes1, 'result.png', 'png' );

function setImagePath(path)
    global fullImagePath;
    fullImagePath = path;

function setImgInfo( bounds, im_hsv, hue_len, im_hsv_hist )

    global allBound;
    global hsv;
    global hue_length;
    global hsv_hist;
    
    allBound = bounds;
    hsv = im_hsv;
    hue_length = hue_len;
    hsv_hist = im_hsv_hist;
    
function setCurrIdx( idx )
    global currIdx;
    currIdx = idx;
    
        
function [ imRecover, im_wheel ] = getImg( rotateAngle )

    global allBound;
    global hsv;
    global hue_length;
    global hsv_hist;
    global currIdx;
    
    bound = allBound{currIdx};
    [ imRecover, im_wheel ] = colorTransfering( bound, hsv, hue_length, hsv_hist, rotateAngle );
    
function path = getImagePath
    global fullImagePath;
    path = fullImagePath;

function showImage( hObject, img )
    axes(hObject);
    imshow(img);

function readHueWheelImage( hObject )
    global hueWheelImg;
    showImage(hObject, 'hue_wheel.jpg');
    hueWheelImg = imread('hue_wheel.jpg');
    
function img = getHueWheelImage
    global hueWheelImg;
    img = hueWheelImg;

% --- Executes on slider movement.
function HueRotationSlider_Callback(hObject, eventdata, handles)
% hObject    handle to HueRotationSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


angle = round(get(hObject, 'Value'));
[ im_Recover, im_wheel ] = getImg(angle);
showImage( handles.axes8, im_wheel );
showImage( handles.axes1, im_Recover );
set(handles.rotationValue,'String', num2str(angle) );

% --- Executes during object creation, after setting all properties.
function HueRotationSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HueRotationSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function rotationValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rotationValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
