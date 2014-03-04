% Project Front-End for displaying main output.

% Location of image files
file_dir = 'Video2/';
filenames = dir([file_dir '*.jpg']);

% Initialise the display handle
frame = imread([file_dir filenames(1).name]);
figure(1); h1 = imshow(frame);

% Compute background to be used for background subtraction
% background = RGBmedianBG(file_dir, filenames, 50);
background = frame;

display = zeros(480,640,3);

% Cycle through each frame in the set of images
for k = 240 : size(filenames,1)
    
    % Read the frame from the source directory
    frame = imread([file_dir filenames(k).name]);
    
    % Retrieve the binary matrix corresponding to the
    % moving object pixels
    binaryImage3D = RGBremoveBG(frame, background, 30);
    
    % OR or AND together the RGB or HSV binary values
    % to return a 2D binary image matrix.
    binaryImage2D = ORthresh(binaryImage3D);
    %binaryImage2D = ANDthresh(binaryImage3D);
    
    display(:,:,1) = binaryImage2D;
    display(:,:,2) = binaryImage2D;
    display(:,:,3) = binaryImage2D;
    display = display .*255;
    %display = segmentColorImage(binaryImage2D, frame);
    
    blobFinder = vision.BlobAnalysis('AreaOutputPort',true,...
                                   'CentroidOutputPort',true,...
                                   'BoundingBoxOutputPort',true,...
                                   'MinimumBlobArea', 50);
                               
    [area,centers,box] = step(blobFinder, binaryImage2D);
    
    centers = uint16(fliplr(centers));
    
    display = drawPath(display, centers);
    display = display ./ 255;
    
    % Display image
    set(h1, 'CData', display);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end