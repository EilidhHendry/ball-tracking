% Project Front-End for frameing main output.

% Location of image files
file_dir = 'Video5/';
filenames = dir([file_dir '*.jpg']);

% Initialise the frame handle
frame = imread([file_dir filenames(1).name]);
figure(1); h1 = imshow(frame);

% Compute background to be used for background subtraction
% background = RGBmedianBG(file_dir, filenames, 50);
background = frame;

path1 = zeros(500,2);
path2 = zeros(500,2);

highestReached1=0;
highestReached2=0;      % 0/1 bool for highest point reached or not
isBall1=0;
isBall2=0;

highestPoint1=[5 5];
highestPoint2=[5 5];    % initialise highest points

ballFrames1 = 0;
ballFrames2 = 0;
objectFrames1 = 0;
objectFrames2 = 0;

obj1 = [0 0];
obj2 = [0 0];

h2 = 1;

% Cycle through each frame in the set of images

for k = 1 : size(filenames,1)

    
    % Read the frame from the source directory
    frame = imread([file_dir filenames(k).name]);
    
    % Retrieve the binary matrix corresponding to the
    % moving object pixels
    binaryImage3D = RGBremoveBG(frame, background, 15, 15, 15);

    %HSV image
    %binaryImage3D = HSVremoveBG(frame, background);
    
    % OR or AND together the RGB or HSV binary values
    % to return a 2D binary image matrix.
    binaryImage2D = ORthresh(binaryImage3D);
    %binaryImage2D = ANDthresh(binaryImage3D);
          
    % Uncomment to display binary image
%     frame = zeros(size(frame));
%     frame(:,:,1) = binaryImage2D;
%     frame(:,:,2) = binaryImage2D;
%     frame(:,:,3) = binaryImage2D;
%     frame = frame .*255;
    
    %frame = segmentColorImage(binaryImage2D, frame);
    blobFinder = vision.BlobAnalysis('AreaOutputPort',true,...
                                   'CentroidOutputPort',true,...
                                   'BoundingBoxOutputPort',true,...
                                   'MinimumBlobArea', 120);
    
    % Update or initialise the object paths
    [path1, path2, ballFrames1,ballFrames2,objectFrames1,objectFrames2] = updatePaths(path1, path2, binaryImage2D, blobFinder,ballFrames1,ballFrames2,objectFrames1,objectFrames2);
    
    if ~isempty(find(path1))
        obj1 = path1(length(find(path1(:,1))),:);
    end
    if ~isempty(find(path2))
        obj2 = path2(length(find(path2(:,1))),:);
    end
    
    % Ball detection 
    [frame, ballFrames1, ballFrames2, objectFrames1, objectFrames2] = detectBalls(binaryImage2D, frame, ballFrames1, ballFrames2, objectFrames1, objectFrames2, obj1, obj2);
    
    % Draw object paths and get the highest point
    [frame,highestReached1,highestPoint1,isBall1,isBall2] = drawPath(path1,70,226,243,frame,highestReached1,highestPoint1,ballFrames1,objectFrames1,isBall1,isBall2,true,false);
    [frame,highestReached2,highestPoint2,isBall1,isBall2] = drawPath(path2,70,226,243,frame,highestReached2,highestPoint2,ballFrames2,objectFrames2,isBall1,isBall2,false,true);    
    
    % Uncomment to display binary image:
%     frame = frame ./ 255;
    
    % Display image
    set(h1, 'CData', frame);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end