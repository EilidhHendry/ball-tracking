file_dir = 'Video1/'; %put here one of the folder locations with images;
filenames = dir([file_dir '*.jpg']);

frame = myrgb2gray(imread([file_dir filenames(1).name]));
figure(1); h1 = imshow(frame);

edges = zeros(256,1);
  for i = 1 : 256;
    edges(i) = i-1;
  end

show = 1;

bckgrnd = imread([file_dir filenames(5).name]);
hsvBG = rgb2hsv(bckgrnd);
V = histeq(hsvBG(:,:,3));
hsvBG(:,:,3) = V;
rgbBG = hsv2rgb(hsvBG);
grayBG = myrgb2gray(rgbBG * 255);
grayBG = double (grayBG);


% Plotting the histogram:

% [R,C] = size(bckgrnd);
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
    
    % Normalization
    hsvframe = rgb2hsv(frame);
    V = histeq(hsvframe(:,:,3));
    hsvframe(:,:,3) = V;
    rgbframe = hsv2rgb(hsvframe);
    
    grayframe = myrgb2gray(rgbframe*255);
    grayframe = double(grayframe);
    frameVec = reshape(grayframe,1,480*640);
    
    % Divide image with background frame
    frameDiff = grayframe./grayBG;
    
    % Object/background relative brightness threshold
    thresh = 0.8;
    
    object = (frameDiff <= thresh);
    object = reshape(object,480,640);
    object = 255*object;
    
    set(h1, 'CData', object);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end
