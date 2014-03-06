% Project Front-End for frameing main output.

% Location of image files
file_dir = 'Video2/';
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
highestReached2=0;
highestPoint1=[5 5];
highestPoint2=[5 5];    % initialise highest point

h2 = 1;

% Cycle through each frame in the set of images

for k = 250 : size(filenames,1)

    
    % Read the frame from the source directory
    frame = imread([file_dir filenames(k).name]);
    
    % Retrieve the binary matrix corresponding to the
    % moving object pixels
    binaryImage3D = RGBremoveBG(frame, background, 25);
    
    % OR or AND together the RGB or HSV binary values
    % to return a 2D binary image matrix.
    binaryImage2D = ORthresh(binaryImage3D);
    %binaryImage2D = ANDthresh(binaryImage3D);
          
    % Uncomment to display binary image
    frame = zeros(size(frame));
    frame(:,:,1) = binaryImage2D;
    frame(:,:,2) = binaryImage2D;
    frame(:,:,3) = binaryImage2D;
    frame = frame .*255;
    
    %frame = segmentColorImage(binaryImage2D, frame);
    
    blobFinder = vision.BlobAnalysis('AreaOutputPort',true,...
                                   'CentroidOutputPort',true,...
                                   'BoundingBoxOutputPort',true,...
                                   'MinimumBlobArea', 100);
                               
    [path1, path2] = updatePaths(path1, path2, binaryImage2D, blobFinder);    
    
    [frame,highestReached1,highestPoint1] = drawPath(path1,255,0,0,frame,highestReached1,highestPoint1);
    [frame,highestReached2,highestPoint2] = drawPath(path2,0,0,255,frame,highestReached2,highestPoint2);
    
    % Ball detection 
    
    ballFinder = regionprops(binaryImage2D,'Area','BoundingBox', ...
        'MajorAxisLength', 'MinorAxisLength', 'ConvexArea', 'Solidity');
    itemProps = struct2cell(ballFinder);
    areas = cell2mat(itemProps(1,:));
    boxes = zeros(10,4);
    for i=1 : length(itemProps(1,:))
        boxes(i,:) = cell2mat(itemProps(2,i));
    end    
    bigAxes = cell2mat(itemProps(3,:));
    smallAxes = cell2mat(itemProps(4,:));
    convexArea = cell2mat(itemProps(5,:));
    solidities = cell2mat(itemProps(6,:));
    
    objects = zeros(2,5,4);
    
    count = 1;
    
    for i=1 : length(itemProps(1,:))
        if areas(i) > 100            
            objects(count,1,:) = areas(i);
            objects(count,2,:) = boxes(i,:);            
            objects(count,3,:) = bigAxes(i);
            objects(count,4,:) = smallAxes(i);
            objects(count,5,:) = convexArea(i);
            objects(count,6,:) = solidities(i);
            count = count + 1;
        end        
    end
    
    % Iterate over number of objects in image
    for i=1 : length(find(objects(:,1,1)))
        axisRatio = objects(i,4,1) / objects(i,3,1);
        convexAreaRatio = objects(i,1,1) / objects(i,5,1);
        if objects(i,6,1) > 0.94 && axisRatio > 0.67 ...
                && convexAreaRatio > 0.95
            frame = drawRect(frame,objects(i,2,:), 0, 0, 255);
        end
    end
    
    % Uncomment to display binary image:
    frame = frame ./ 255;
    
    % Display image
    set(h1, 'CData', frame);
    drawnow('expose');
    disp(['showing frame ' num2str(k)]);
end