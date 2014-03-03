% Project Front-End for displaying main output.

% Location of image files
file_dir = 'Video1/';
filenames = dir([file_dir '*.jpg']);

% Initialise the display handle
frame = imread([file_dir filenames(1).name]);
figure(1); h1 = imshow(frame);

% Compute background to be used for background subtraction
background = RGBmedianBG(file_dir, filenames, 50);

% Cycle through each frame in the set of images
for k = 240 : size(filenames,1)
    
    % Read the frame from the source directory
    frame = imread([file_dir filenames(k).name]);
    
    % Retrieve the binary matrix corresponding to the
    % moving object pixels
    binaryImage = RGBremoveBG(frame, background, 30);
    
    % Compare the binary threshold with the original frame
    % to retrieve the original colours of the image.
    display = ORthresh(binaryImage, frame);
    %display = ANDthresh(binaryImage, frame);
    
    center = getCenter(display);
    
    if center(1) > 1 && center(2)  > 1
        frame(center(1),center(2),:) = [255 255 255];
        frame(center(1)+1,center(2),:) = [255 255 255];
        frame(center(1)-1,center(2),:) = [255 255 255];
        frame(center(1),center(2)+1,:) = [255 255 255];
        frame(center(1),center(2)-1,:) = [255 255 255];
    end
    
    % Display image
    set(h1, 'CData', frame);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end