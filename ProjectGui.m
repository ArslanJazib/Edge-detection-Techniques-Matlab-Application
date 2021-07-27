function varargout = ProjectGui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProjectGui_OpeningFcn, ...
                   'gui_OutputFcn',  @ProjectGui_OutputFcn, ...
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


% --- Executes just before ProjectGui is made visible.
function ProjectGui_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for ProjectGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = ProjectGui_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes on button press in load_btn.
function load_btn_Callback(hObject, eventdata, handles)
global orignalImage
[filepath]=uigetfile({'*.*';'*.jpg';'*.png';'*.bmp'},'Choose Orignal Image to Enhance');
orignalImagePath=[filepath];
orignalImage=imread(orignalImagePath)
axes(handles.orignal_image)
imshow(orignalImage)


% --- Executes on selection change in detection_options.
function detection_options_Callback(hObject, eventdata, handles)
global orignalImage
global eh_options
contents=cellstr(get(hObject,'String'));
eh_options=contents(get(hObject,'Value'));
if (strcmp(eh_options,'Image Segmentation'))
    set(handles.threshold,'visible','Off');
    set(handles.threshhold_lbl,'visible','Off');
    set(handles.shapes_options,'visible','Off');
elseif (strcmp(eh_options,'Laplacian Filter'))
    set(handles.threshold,'visible','Off');
    set(handles.threshhold_lbl,'visible','Off');
    set(handles.shapes_options,'visible','Off');
elseif (strcmp(eh_options,'Point Detection'))
    set(handles.threshold,'visible','Off');
    set(handles.threshhold_lbl,'visible','Off');
    set(handles.shapes_options,'visible','Off');
elseif (strcmp(eh_options,'Sobel Operator'))
    set(handles.threshold,'visible','On');
    set(handles.threshhold_lbl,'visible','On');
    set(handles.shapes_options,'visible','Off');
elseif (strcmp(eh_options,'Line Detection'))
    set(handles.threshold,'visible','Off');
    set(handles.threshhold_lbl,'visible','Off');
    set(handles.shapes_options,'visible','Off');
elseif (strcmp(eh_options,'Prewitt Operator'))
    set(handles.threshold,'visible','On');
    set(handles.threshhold_lbl,'visible','On');
    set(handles.shapes_options,'visible','Off');
elseif (strcmp(eh_options,'Robbert Operator'))
    set(handles.threshold,'visible','On');
    set(handles.threshhold_lbl,'visible','On');
    set(handles.shapes_options,'visible','Off');
elseif (strcmp(eh_options,'Count Objects'))
    set(handles.threshold,'visible','Off');
    set(handles.threshhold_lbl,'visible','Off');
    set(handles.shapes_options,'visible','Off');
elseif (strcmp(eh_options,'Open'))
    set(handles.threshold,'visible','Off');
    set(handles.threshhold_lbl,'visible','Off');
    set(handles.shapes_options,'visible','On');
elseif (strcmp(eh_options,'Close'))
    set(handles.threshold,'visible','Off');
    set(handles.threshhold_lbl,'visible','Off');
    set(handles.shapes_options,'visible','On');
elseif (strcmp(eh_options,'Sharpen'))
    set(handles.threshold,'visible','Off');
    set(handles.threshhold_lbl,'visible','Off');
    set(handles.shapes_options,'visible','Off');
end



% --- Executes during object creation, after setting all properties.
function detection_options_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in undo_btn.
function undo_btn_Callback(hObject, eventdata, handles)



% --- Executes on button press in Redo.
function Redo_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)



% --- Executes on button press in undo_btn.
function pushbutton10_Callback(hObject, eventdata, handles)




function threshold_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function threshold_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)
global eh_options
global shapes_options
global orignalImage
outputImage = orignalImage;
% Laplacian Filter
if (strcmp(eh_options,'Laplacian Filter'))
    filter= fspecial('laplacian');
    outputImage=imfilter(outputImage,filter,'replicate');
    axes(handles.output_image);
    imshow(outputImage);
% Point Detection
elseif (strcmp(eh_options,'Point Detection'))
    outputImage= im2double(outputImage);
    outputImage=rgb2gray(outputImage);
    w=[-1 -1 -1; -1 8 -1; -1 -1 -1];
    outputImage=abs(imfilter(double(outputImage),w));
    axes(handles.output_image);
    imshow(outputImage);
% Line Detection
elseif (strcmp(eh_options,'Line Detection'))
    outputImage = im2bw(outputImage);
    w=[-1 -1 -1; 2 2 2; -1 -1 -1];
    outputImage=abs(imfilter(double(outputImage),w));
    axes(handles.output_image);
    imshow(outputImage);
% Sobel Operator
elseif (strcmp(eh_options,'Sobel Operator'))
outputImage=rgb2gray(outputImage);
C=double(outputImage);
for i=1:size(C,1)-2
    for j=1:size(C,2)-2
        %Sobel mask for x-direction:
        Gx=((2*C(i+2,j+1)+C(i+2,j)+C(i+2,j+2))-(2*C(i,j+1)+C(i,j)+C(i,j+2)));
        %Sobel mask for y-direction:
        Gy=((2*C(i+1,j+2)+C(i,j+2)+C(i+2,j+2))-(2*C(i+1,j)+C(i,j)+C(i+2,j)));
        outputImage(i,j)=sqrt(Gx.^2+Gy.^2);
    end
end
axes(handles.output_image);
imshow(outputImage);
% Applying mask on an image using convulution
elseif (strcmp(eh_options,'Image Segmentation'))
    outputImage=medfilt2(rgb2gray(outputImage),[5 5]);
    output_image=edge(outputImage,'sobel');
    msk=[0 0 0 0 0;
        0 1 1 1 0;
        0 1 1 1 0;
        0 1 1 1 0;
        0 0 0 0 0;];
    output_image=conv2(double(output_image),double(msk));
    axes(handles.output_image);
    imshow(output_image);
% Prewitt Operator
elseif (strcmp(eh_options,'Prewitt Operator'))
    outputImage=im2bw(outputImage);
    outputImage = edge(outputImage,'Prewitt');
    axes(handles.output_image);
    imshow(outputImage);
% Robert Operator
elseif (strcmp(eh_options,'Robert Operator'))
    outputImage=im2bw(outputImage);
    outputImage = edge(outputImage,'Roberts');
    axes(handles.output_image);
    imshow(outputImage);
% Canny Operator
elseif (strcmp(eh_options,'Canny Operator'))
    outputImage=im2bw(outputImage);
    outputImage = edge(outputImage,'Canny');
    axes(handles.output_image);
    imshow(outputImage);
% Connected Components
elseif (strcmp(eh_options,'Count Objects'))
outputImage=im2bw(outputImage);
concomp=bwconncomp(outputImage);
L = labelmatrix(concomp);
axes(handles.output_image);
hold on
for x=1: concomp.NumObjects
 z = outputImage.*double(uint8(L==x));
 figure(x+1)
 imshow(z)
end
% Closing
elseif (strcmp(eh_options,'Close'))
    if (strcmp(shapes_options,'Diamond'))
        se = strel('diamond',5);
        outputImage=rgb2gray(outputImage);
        outputImage=imclose(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Disk'))
        se = strel('disk',3);
        outputImage=rgb2gray(outputImage);
        outputImage=imclose(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Octagon'))
        se = strel('octagon',9);
        outputImage=rgb2gray(outputImage);
        outputImage=imclose(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Line'))
        se = strel('line',10, 45);
        outputImage=rgb2gray(outputImage);
        outputImage=imclose(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Rectangle'))
        se = strel('rectangle',[5 5]);
        outputImage=rgb2gray(outputImage);
        outputImage=imclose(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Square'))
        se = strel('square',10);
        outputImage=rgb2gray(outputImage);
        outputImage=medfilt2(outputImage,[5 5]);
        outputImage=imclose(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Cube'))
        se = strel('cube',10);
        outputImage=rgb2gray(outputImage);
        outputImage=medfilt2(outputImage,[5 5]);
        outputImage=imclose(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
     elseif(strcmp(shapes_options,'cuboid'))
        se = strel('Cuboid',[10 10 10]);
        outputImage=rgb2gray(outputImage);
        outputImage=medfilt2(outputImage,[5 5]);
        outputImage=imclose(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
     elseif(strcmp(shapes_options,'sphere'))
        se = strel('Sphere',10);
        outputImage=rgb2gray(outputImage);
        outputImage=medfilt2(outputImage,[5 5]);
        outputImage=imclose(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);  
    end
% Opening
elseif (strcmp(eh_options,'Open'))
    if (strcmp(shapes_options,'Diamond'))
        se = strel('diamond',6);
        outputImage=rgb2gray(outputImage);
        outputImage=imopen(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Disk'))
        se = strel('disk',5);
        outputImage=rgb2gray(outputImage);
        outputImage=imopen(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Octagon'))
        se = strel('octagon',5);
        outputImage=rgb2gray(outputImage);
        outputImage=imopen(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Line'))
        se = strel('line',10, 45);
        outputImage=rgb2gray(outputImage);
        outputImage=imopen(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Rectangle'))
        se = strel('rectangle',[5 5]);
        outputImage=rgb2gray(outputImage);
        outputImage=imopen(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Square'))
        se = strel('square',5);
        outputImage=rgb2gray(outputImage);
        outputImage=imopen(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
    elseif(strcmp(shapes_options,'Cube'))
        se = strel('cube',5);
        outputImage=rgb2gray(outputImage);
        outputImage=imopen(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
     elseif(strcmp(shapes_options,'cuboid'))
        se = strel('Cuboid',[10 10 10]);
        outputImage=rgb2gray(outputImage);
        outputImage=imopen(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);
     elseif(strcmp(shapes_options,'sphere'))
        se = strel('Sphere',5);
        outputImage=rgb2gray(outputImage);
        outputImage=imopen(outputImage,se);
        axes(handles.output_image);
        imshow(outputImage);  
    end
% Sharpening
elseif (strcmp(eh_options,'Sharpen'))
    h=fspecial('unsharp');
    outputImage=imfilter(outputImage,h);
    axes(handles.output_image);
    imshow(outputImage); 
end

function gamma_Callback(~, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function gamma_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in boxFilter.
function boxFilter_Callback(hObject, ~, handles)



% --- Executes on button press in gaussianFilter.
function gaussianFilter_Callback(hObject, eventdata, handles)


% --- Executes on button press in medianFilter.
function medianFilter_Callback(hObject, eventdata, handles)




function boxSize_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function boxSize_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaussSize_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function gaussSize_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_btn.
function save_btn_Callback(hObject, eventdata, handles)
savedImage = getframe(handles.output_image) ;
imwrite(savedImage.cdata,'output.jpg','jpg')


% --- Executes on selection change in shapes_options.
function shapes_options_Callback(hObject, eventdata, handles)
global shapes_options
contents=cellstr(get(hObject,'String'));
shapes_options=contents(get(hObject,'Value'));

% --- Executes during object creation, after setting all properties.
function shapes_options_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shapes_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
