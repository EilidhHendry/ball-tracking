file_dir = 'Video1/'; %put here one of the folder locations with images;
filenames = dir([file_dir '*.jpg']);

frame = imread([file_dir filenames(1).name]);
figure(1); h1 = imshow(frame);

show = 1;

bckgrnd = imread([file_dir filenames(5).name]);
bckgrnd = double(bckgrnd);

%bckgrnd = normalize(bckgrnd);

% Plotting the histogram:

% Read one frame at a time.
for k = 1 : size(filenames,1)
    
    % Create 1-D grayscale vector of image
    frame = imread([file_dir filenames(k).name]);
    frame = double(frame);   
    
    % Normalization  - this slows down the prgram a lot
    %frame = normalize(frame);
    
    % Object/background relative brightness threshold
    % if greater than thresh then background if less than 50 then change
    thresh = 10;
       
    frameDiff=abs(bckgrnd-frame);
    %frameDiff1=frameDiff(1:100);
    
    change = (frameDiff > thresh);
    
    change(:,:,1) = change(:,:,1) & change(:,:,2) & change(:,:,3);
    change(:,:,2) = change(:,:,1) & change(:,:,2) & change(:,:,3);
    change(:,:,3) = change(:,:,1) & change(:,:,2) & change(:,:,3);
    
    display = change .* frame;
    display = display ./ 255;
    
    % change1 = double(change(1:640));
    
    set(h1, 'CData', display);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end
