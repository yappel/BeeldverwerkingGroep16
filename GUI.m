function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 21-Jan-2015 13:40:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible. 
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
axes(handles.axes13);
image(imread('resources/GUI/titel.png'));
set(handles.axes13,'XTick', [])
set(handles.axes13,'YTick', [])

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in buttonload.
function buttonload_Callback(hObject, eventdata, handles)
% hObject    handle to buttonload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%videoSrc = vision.VideoFileReader('Trainingsvideo.avi', 'ImageColorSpace', 'Intensity');
[name, path] = uigetfile('*.avi');
set(handles.uitable1,'Data',{})
vid = VideoReader(name);
frame = readFrame(vid);
axes(handles.framevideo);
image(frame)
set(handles.framevideo,'XTick', [])
set(handles.framevideo,'YTick', [])

axes(handles.frametresholded);
image(frame)
set(handles.frametresholded,'XTick', [])
set(handles.frametresholded,'YTick', [])
% set(handles.text2, 'String', vid.CurrentTime);
handles.vid=vid;
guidata(hObject,handles);



% nFrames = vid.NumberOfFrames;
% vidHeight = vid.Height;
% vidWidth = vid.Width;
% mov(1:nFrames) = ...
% struct('cdata',zeros(vidHeight,vidWidth, 3,'uint8'),...
%            'colormap',[]);
% hf = handles.axes1;
% for k = 1 : nFrames
%     mov(k).cdata = read(vid,k);
%
% end
%
% %set(hf, 'position', [150 150 vidWidth vidHeight])
% movie(hf, mov, 1, vid.FrameRate);




% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','gray');
end


% --- Executes on button press in buttonplay.
function buttonplay_Callback(hObject, eventdata, handles)
% hObject    handle to buttonplay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% profile on


%------------INIT AXES-------------
axes(handles.frameplate)
image(imread('resources/GUI/Nummerplaat.png'));
set(handles.frameplate,'XTick', [])
set(handles.frameplate,'YTick', [])
axes(handles.framechar1)
charimg = false(150,150);
image(charimg);
set(handles.framechar1,'XTick', [])
set(handles.framechar1,'YTick', [])
axes(handles.framechar2)
image(charimg);
set(handles.framechar2,'XTick', [])
set(handles.framechar2,'YTick', [])
axes(handles.framechar3)
image(charimg);
set(handles.framechar3,'XTick', [])
set(handles.framechar3,'YTick', [])
axes(handles.framechar4)
image(charimg);
set(handles.framechar4,'XTick', [])
set(handles.framechar4,'YTick', [])
axes(handles.framechar5)
image(charimg);
set(handles.framechar5,'XTick', [])
set(handles.framechar5,'YTick', [])
axes(handles.framechar6)
image(charimg);
set(handles.framechar6,'XTick', [])
set(handles.framechar6,'YTick', [])
%-----------------------------
framecounter = 1;
sceneframe= 1;
set(handles.uitable1,'Data',{})
starttime = cputime;
tic
newscene = 1;
means = zeros(3,2);
savedPlates = [''];
platecounter = zeros(10,1);
testOud = {};


while(hasFrame(handles.vid))
    data = readFrame(handles.vid);
    h = get(handles.framevideo,'Children');
    set(h,'CData', data);
    
    [plate1, boxed] = getPlate(data);
    
    h2 = get(handles.frametresholded,'Children');
    set(h2,'CData', boxed);
    % set(handles.text2, 'String', round(handles.vid.CurrentTime, 2));
    
    %
    %     means(1,1) = means(1,2);
    %     means(2,1) = means(2,2);
    %     means(3,1) = means(3,2);
    %     means(1,2) = mean(mean(data(:,:,1)));
    %     means(2,2) = mean(mean(data(:,:,2)));
    %     means(3,2) = mean(mean(data(:,:,3)));
    %     newscene = means(1,1)-means(1,2) > 10;
   
    
    
    %----------------------Optional, disable for speed --------------------
    h = get(handles.frameplate,'Children');
    set(h,'CData', imresize(plate1, [NaN(1) 588 ]));
    %----------------------------------------------------------------------
    
    [chars, id] = CharSegmentation(plate1);
    if id > 4 && id < 8
        result{1} = showchar(chars, 1, handles.char1, get(handles.framechar1, 'Children'));
        result{2} = showchar(chars, 2, handles.char2, get(handles.framechar2, 'Children'));
        result{3} = showchar(chars, 3, handles.char3, get(handles.framechar3, 'Children'));
        result{4} = showchar(chars, 4, handles.char4, get(handles.framechar4, 'Children'));
        result{5} = showchar(chars, 5, handles.char5, get(handles.framechar5, 'Children'));
        result{6} = showchar(chars, 6, handles.char6, get(handles.framechar6, 'Children'));
        
        plate = determinePlate(result, id); newscene = 0;
        [m,~] = size(savedPlates);
    if m>1 && ~strcmp(plate, '')
        lastPlate = savedPlates(end,:);
        lastlastPlate = savedPlates(end-1,:);
        
        difference = zeros(8,2);
        
        for n=1:8
            difference(n,1) = strcmp(lastlastPlate(n), lastPlate(n));
            difference(n,2) = strcmp(lastlastPlate(n), plate(n));
        end
       
        sumDiffPlates = sum(difference(:,1));
        sumDiffPlates1 = sum(difference(:,2));
%          testNew = {sumDiffPlates; sumDiffPlates1; plate; lastPlate; lastlastPlate}
%          if ~isequal(testNew,testOud)
%              testOud = testNew
%          end
        
        if sumDiffPlates < 6 && sumDiffPlates1 < 6 && (framecounter - sceneframe) >18
            newscene = 1;
        end
    end
    
        oldData = get(handles.uitable1,'Data');
        if strcmp(plate,'') == 0
            if newscene
                [~, index] = max(platecounter);
                newData = [{savedPlates(index,:) sceneframe+index int64(toc*1000)}; oldData];
                set(handles.uitable1,'Data',newData)
                savedPlates = [];
                platecounter = zeros(10,1);
                sceneframe = framecounter;
            else
                ind = 0;
                if ~isempty(savedPlates(:))
                    [m,~] = size(savedPlates);
                    for k = 1:m
                        if strcmp(savedPlates(k,:), plate)
                            ind = k;
                        end
                    end
                end
                if ind ~= 0
                    platecounter(ind) = platecounter(ind) +1;
                else
                    savedPlates=[savedPlates;plate];
                end
            end
            
            %                                 newData = [{plate framecounter cputime-starttime}; oldData];
            %                                 set(handles.uitable1,'Data',newData)
        end
        %savedPlates
        %         else
        %             newData = [oldData; {plate framecounter cputime-starttime}];
        
    end
    
    
    
    
    
    framecounter= framecounter +1;
    
end
sampleData = get(handles.uitable1,'Data');
checkSolution(sampleData, 'trainingSolutions.mat');

% profile viewer
% p = profile('info');
% profsave(p, 'profile_results')



% --- Executes on button press in buttonloadtest.
function buttonloadtest_Callback(hObject, eventdata, handles)
% hObject    handle to buttonloadtest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uitable1,'Data',{})
% [FileName,PathName,FilterIndex] = uigetfile('*.png','MultiSelect','on');
FileName = {'For_1.png'    'For_2.png'    'For_3.png'    'For_4.png'    'For_5.png'    'For_6.png'    'For_7.png'  'For_8.png'    'For_9.png'    'For_10.png'    'For_11.png'    'For_12.png'    'For_13.png'    'For_14.png' 'For_15.png'    'For_16.png'    'For_17.png'    'For_18.png'    'For_19.png'    'For_20.png'    'For_21.png' 'For_22.png'    'For_23.png'    'For_24.png'    'For_25.png'    'For_26.png'    'For_27.png'    'For_28.png' 'For_29.png'    'For_30.png' };
% FileName = {'For_10.png'};
PathName = 'resources/TrainingsIMGs/Foreground/';
%     axes(handles.frameplate);
%     imshow(imread([PathName, FileName{1}]))

axes(handles.frameplate)
image(imread('resources/GUI/Nummerplaat.png'));
axes(handles.framechar1)
% colormap(gray);
% charimg = imread('resources/GUI/letter.png');
charimg = false(150,150);
image(charimg);
axes(handles.framechar2)
image(charimg);
axes(handles.framechar3)
image(charimg);
axes(handles.framechar4)
image(charimg);
axes(handles.framechar5)
image(charimg);
axes(handles.framechar6)
image(charimg);


for K = 1:length(FileName)
    h = get(handles.frameplate,'Children');
    %         axes(handles.frameplate);
    %         set(h,'CData', imread([PathName, FileName{K}]));
    plate = imread([PathName, FileName{K}]);
    set(h,'CData', imresize(plate, [NaN(1) 588 ]));
    %         imshow(plate)
    [chars, id] = CharSegmentation(plate);
    result{1} = showchar(chars, 1, handles.char1, get(handles.framechar1, 'Children'));
    %         axes(handles.framechar2)
    result{2} = showchar(chars, 2, handles.char2, get(handles.framechar2, 'Children'));
    %         axes(handles.framechar3)
    result{3} = showchar(chars, 3, handles.char3, get(handles.framechar3, 'Children'));
    %         axes(handles.framechar4)
    result{4} = showchar(chars, 4, handles.char4, get(handles.framechar4, 'Children'));
    %         axes(handles.framechar5)
    result{5} = showchar(chars, 5, handles.char5, get(handles.framechar5, 'Children'));
    %         axes(handles.framechar6)
    result{6} = showchar(chars, 6, handles.char6, get(handles.framechar6, 'Children'));
    
    plate = determinePlate(result, id);
    oldData = get(handles.uitable1,'Data');
    newData = [oldData; {plate id 0}];
    set(handles.uitable1,'Data',newData)
    uiwait(handles.figure1);
end


function result = showchar(chars, i, h, himg)
result = CharRecogn (chars{i});
%----------------------Optional, disable for speed --------------------
set(himg, 'CData', imresize(chars{i}, [150 NaN(1) ]).*255)
set(h,'String',char(result(1,1)));
%----------------------------------------------------------------------




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1)



% Hint: place code in OpeningFcn to populate axes12
