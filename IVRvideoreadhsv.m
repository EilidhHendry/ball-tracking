file_dir = 'Video1/'; %put here one of the folder locations with images;
filenames = dir([file_dir '*.jpg']);

frame = imread([file_dir filenames(1).name]);
figure(1); h1 = imshow(frame);

edges = zeros(256,1);
  for i = 1 : 256;
    edges(i) = i-1;
  end

show = 1;

bckgrnd = imread([file_dir filenames(5).name]);

%hsv:
% bckgrnd = normalize(bckgrnd);
hsvBG = rgb2hsv(bckgrnd);

% Plotting the histogram:

%[R,C] = size(hsvBG);
 %bckgrndVec = reshape(bckgrnd,1,R*C);      % turn image into long array
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
    frame = double(frame);
   
    % Normalization  - this slows down the prgram a lot
    % frame = normalize(frame);

    %HSV:
    hsvframe = rgb2hsv(frame);
    
    % Object/background relative brightness threshold
    % if greater than thresh then background if less than thresh then object
    HSthresh = 0.1;
    Vthresh = 2;
    
    %subtract frame from background
    frameDiff = abs(hsvBG-hsvframe);
    
    %check if the subtraction is greater than the threshold
    change(:,:,1) = (frameDiff(:,:,1) > HSthresh);
    change(:,:,2) = (frameDiff(:,:,2) > HSthresh);
    change(:,:,3) = (frameDiff(:,:,3) > Vthresh);
    
    change(:,:,1) = change(:,:,1) & change(:,:,2) & change(:,:,3);
    change(:,:,2) = change(:,:,1) & change(:,:,2) & change(:,:,3);
    change(:,:,3) = change(:,:,1) & change(:,:,2) & change(:,:,3);   
    
    display = change .* frame;
    display = display ./ 255;
    
    set(h1, 'CData', display);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end
