file_dir = 'Video1/'; %put here one of the folder locations with images;
filenames = dir([file_dir '*.jpg']);

frame = rgb2hsv(imread([file_dir filenames(1).name]));
figure(1); h1 = imshow(frame);

edges = zeros(256,1);
  for i = 1 : 256;
    edges(i) = i-1;
  end

show = 1;

%bckgrnd = imread([file_dir filenames(5).name]);
%bckgrnd = double(bckgrnd);

red = zeros(480,640,50);
blue = zeros(480,640,50);
green  = zeros(480,640,50);
for k = 1 : 50
    
    frame = imread([file_dir filenames(k).name]);
    red(:,:,k) = frame(:,:,1);
    blue(:,:,k) = frame(:,:,2);
    green(:,:,k) = frame(:,:,2);
    
end

medred = median(red,3)
medblue = median(blue,3)
medgreen = median(green,3)

bckgrnd = zeros(480,640,3);
bckgrnd(:,:,1) = medred;
bckgrnd(:,:,2) = medblue;
bckgrnd(:,:,3) = medgreen;
bckgrnd = normalize(bckgrnd);

% Read one frame at a time.
for k = 1 : size(filenames,1)
    
    % Create 1-D grayscale vector of image
    frame = imread([file_dir filenames(k).name]);
    frame = double(frame);   
    
    % Normalization  - this slows down the prgram a lot
    %frame = normalize(frame);
    
    % Object/background relative brightness threshold
    % if greater than thresh then background if less than 50 then change
    thresh = 45;
       
    frameDiff=abs(bckgrnd-frame);
    
    frameDiff1=frameDiff(1:100);
    
    change = (frameDiff > thresh);
    change1 = double(change(1:640));
 
            
    set(h1, 'CData', change);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end
