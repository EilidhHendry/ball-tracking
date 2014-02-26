file_dir = 'Video1/'; %put here one of the folder locations with images;
filenames = dir([file_dir '*.jpg']);

%frame = myrgb2gray(imread([file_dir filenames(1).name]));
frame = rgb2hsv(imread([file_dir filenames(1).name]));
figure(1); h1 = imshow(frame);

edges = zeros(256,1);
  for i = 1 : 256;
    edges(i) = i-1;
  end

show = 1;

bckgrnd = imread([file_dir filenames(5).name]);

%gray:
%bckgrnd = normalize(bckgrnd);                   
%grayBG = myrgb2gray(bckgrnd);              
%grayBG = double (grayBG);

%hsv:
bckgrnd = normalize(bckgrnd);
hsvBG = rgb2hsv(bckgrnd);
hsvBG = double (hsvBG);

% Plotting the histogram:

% [R,C] = size(hsvBG);
% bckgrndVec = reshape(bckgrnd,1,R*C);      % turn image into long array
% hist = histc(bckgrndVec,edges)';        % do histogram
%   if show > 0
%       figure(show)
%       clf
%       pause(0.1)
%       plot(edges,hist)
%       axis([0, 255, 0, 1.1*max(hist)])
%       imshow(before)
%   end

% Read one frame at a time.
for k = 1 : size(filenames,1)
    
    % Create 1-D grayscale vector of image
    frame = imread([file_dir filenames(k).name]);
    
    % Normalization  - this slows down the prgram a lot
     frame = normalize(frame);
    
    %HSV:
    hsvframe = rgb2hsv(frame);
    hsvframe = double(hsvframe);

    % Divide image with background frame
    frameDiff = hsvframe./hsvBG;
    
    % Object/background relative brightness threshold
    thresh = 0.4;
    
    object = (frameDiff <= thresh);
        
    set(h1, 'CData', object);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end
