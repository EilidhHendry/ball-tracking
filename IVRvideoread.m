
file_dir = 'Video2/'; %put here one of the folder locations with images;
filenames = dir([file_dir '*.jpg']);

frame = myrgb2gray(imread([file_dir filenames(1).name]));
figure(1); h1 = imshow(frame);

edges = zeros(256,1);
  for i = 1 : 256;
    edges(i) = i-1;
  end

show = 1;
  
bckgrnd = myrgb2gray(imread([file_dir filenames(5).name]));
bckgrnd = double (bckgrnd);
[R,C] = size(bckgrnd);
bckgrndVec = reshape(bckgrnd,1,R*C);      % turn image into long array
hist = histc(bckgrndVec,edges)';        % do histogram
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
    frame = myrgb2gray(imread([file_dir filenames(k).name]));
    frame = double(frame);
    frameVec = reshape(frame,1,480*640);
    
    % Divide image with background frame
    frameDiff = frame./bckgrnd;
    
    % Object/background relative brightness threshold
    thresh = 0.8;
    
    object = (frameDiff <= thresh);
    %object = reshape(object,480,640);
    object = 255*object;
    
    set(h1, 'CData', object);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end