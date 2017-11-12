function varargout = GraphicalUserInterface(varargin)
% GRAPHICALUSERINTERFACE MATLAB code for GraphicalUserInterface.fig
%      GRAPHICALUSERINTERFACE, by itself, creates a new GRAPHICALUSERINTERFACE or raises the existing
%      singleton*.
%      H = GRAPHICALUSERINTERFACE returns the handle to a new GRAPHICALUSERINTERFACE or the handle to
%      the existing singleton*.
%
%      GRAPHICALUSERINTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAPHICALUSERINTERFACE.M with the given input arguments.
%
%      GRAPHICALUSERINTERFACE('Property','Value',...) creates a new GRAPHICALUSERINTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GraphicalUserInterface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GraphicalUserInterface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GraphicalUserInterface

% Last Modified by GUIDE v2.5 09-Nov-2017 19:31:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GraphicalUserInterface_OpeningFcn, ...
                   'gui_OutputFcn',  @GraphicalUserInterface_OutputFcn, ...
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


% --- Executes just before GraphicalUserInterface is made visible.
function GraphicalUserInterface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GraphicalUserInterface (see VARARGIN)

% Choose default command line output for GraphicalUserInterface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GraphicalUserInterface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GraphicalUserInterface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [filename, pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
 if isequal(filename, 0)
    return
 end
 handles.myImage = strcat(pathname, filename);
 axes(handles.axes1);
 handles.myImage = imread(handles.myImage);
 imshow(handles.myImage);
 RB1Status = get(handles.radiobutton1, 'Value');
 RB2Status = get(handles.radiobutton2, 'Value');
 RB1Status
 RB2Status
 if RB1Status == 1
    h = imfreehand(gca);
    xy = h.getPosition;
    xCoordinates = xy(:, 1);
    yCoordinates = xy(:, 2);
    handles.xCoordinates = xCoordinates;
    handles.yCoordinates = yCoordinates;
    
    % Changing value at those pixels which have value as 255 to have pixel value as 254.
    % This is being done to ensure that the region that is to be inpainted has
    % not pixel value overlap with any of the pixels in the original region
    handles.myImage(handles.myImage == 255) = 254;
    uploadedImage = handles.myImage;
    handles.uploadedImage = uploadedImage;
    
    numberOfCoordinates = (length(handles.myImage(:, 1, 1)))*(length(handles.myImage(1, :, 1)));
    imageCoordinate = zeros(numberOfCoordinates, 2);
    var = 1;
    for i = 1:length(handles.myImage(:, 1, 1))
        for j = 1:length(handles.myImage(1, :, 1))
            imageCoordinate(var, 2) = i;
            imageCoordinate(var, 1) = j;
            var = var + 1;
        end
    end
    inPolygonOrNot = inpolygon(imageCoordinate(:, 1), imageCoordinate(:, 2), xCoordinates, yCoordinates);
    for someVar = 1: numberOfCoordinates
        if inPolygonOrNot(someVar) == 1
            handles.myImage(imageCoordinate(someVar, 2), imageCoordinate(someVar, 1), 1) = 0;
            handles.myImage(imageCoordinate(someVar, 2), imageCoordinate(someVar, 1), 2) = 255;
            handles.myImage(imageCoordinate(someVar, 2), imageCoordinate(someVar, 1), 3) = 0;
        end
    end
 
    %Let's construct the mask that we are going to use later
    mask = zeros(length(handles.myImage(:, 1, 1)), length(handles.myImage(1, :, 1)));
    for someVar = 1:numberOfCoordinates
        if inPolygonOrNot(someVar) == 1
            mask(imageCoordinate(someVar, 2), imageCoordinate(someVar, 1)) = 255;
        end
    end
    handles.mask = mask; 
    imshow(handles.myImage)
 else
     handles.uploadedImage = handles.myImage;
     h1 = impoly(gca, 'Closed', false);
     foresub = getPosition(h1);
     foregroundInd = sub2ind(size(handles.myImage), foresub(:, 2), foresub(:, 1));
     imshow(handles.myImage);
     h2 = impoly(gca, 'Closed', false);
     backsub = getPosition(h2);
     backgroundInd = sub2ind(size(handles.myImage), backsub(:, 2), backsub(:, 1));
     imshow(handles.myImage)
     handles.foregroundIndex = round(foregroundInd);
     handles.backgroundIndex = round(backgroundInd);
 end
 handles.RB1Status = RB1Status;
 handles.RB2Status = RB2Status;
 % save the updated handles object
 guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'uploadedImage')
    if handles.RB1Status == 1
        originalImage = handles.uploadedImage;
        imageFilled1 = regionfill(originalImage(:, :, 1), handles.xCoordinates, handles.yCoordinates);
        imageFilled2 = regionfill(originalImage(:, :, 2), handles.xCoordinates, handles.yCoordinates);
        imageFilled3 = regionfill(originalImage(:, :, 3), handles.xCoordinates, handles.yCoordinates);
        imageFilled(:, :, 1) = imageFilled1;
        imageFilled(:, :, 2) = imageFilled2;
        imageFilled(:, :, 3) = imageFilled3;
        mask = handles.mask;
        mask = mat2gray(mask);
        psz = 15;
        [inpaintedImage, C, D, fillMovie] = inpainting(imageFilled, mask, psz);
        inpaintedImage = uint8(inpaintedImage);
        handles.modifiedImage1 = inpaintedImage;
        axes(handles.axes2)
        imshow(handles.modifiedImage1)
        implay(fillMovie);
    else
        originalImage = handles.uploadedImage;
        foregroundInd = handles.foregroundIndex;
        backgroundInd = handles.backgroundIndex;
        L = superpixels(originalImage, 500);
        BW = lazysnapping(originalImage, L, foregroundInd, backgroundInd);
        maskedImage = originalImage;
        maskedImage(repmat(~BW, [1 1 3])) = 0;
        H = fspecial('motion', 40, 65);
        MotionBlur = imfilter(originalImage, H, 'replicate');
        for i = 1:length(MotionBlur(:, 1, 1))
            for j = 1:length(MotionBlur(1, :, 1))
                if maskedImage(i, j, 1) == 0
                    maskedImage(i, j, 1) = MotionBlur(i, j, 1);
                    maskedImage(i, j, 2) = MotionBlur(i, j, 2);
                    maskedImage(i, j, 3) = MotionBlur(i, j, 3);
                end
            end
        end
        handles.modifiedImage2 = maskedImage;
        axes(handles.axes2);
        imshow(handles.modifiedImage2);
    end
    % save the updated handles object
    guidata(hObject,handles); 
end