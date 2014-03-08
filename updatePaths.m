% Will initialise or update the paths of the objects being found
% by the blob finder in the binary image.

function [points1, points2,ballFrames1,ballFrames2,objectFrames1,objectFrames2] = updatePaths(points1, points2, binImage, blobFinder,ballFrames1,ballFrames2,objectFrames1,objectFrames2)

[area,centers] = step(blobFinder, binImage);

size1 = length(find(points1(:,1))); % Number of previous centroids
size2 = length(find(points2(:,1))); % in the path
init1 = false;   % Flag for indicating if object was 
init2 = false;   % initialised this frame

% Check which objects are present in the frame
[object1Present, object2Present] = isObjectPresent(points1, points2, centers);

% If initialising two objects at once, we want to initialise the highest
% point first.
minY = 1000;
for k=1 : length(centers(:,1))
    if centers(k,2) < minY
        highestcenter = centers(k,:);
        minY = centers(k,2);
    end
end


% Initialise path1 (Y coordinate must be less than 460)
if object1Present && size1 == 0
    if highestcenter < 460
        points1(1,:) = highestcenter;
        size1 = 1;
        init1 = true;
        ballFrames1 = 0;
        objectFrames1 = 0;
    end
end
   
% Initialise path2 (Y coordinate must be less than 460)
if object1Present && object2Present && size2 == 0 && ~init1
    if centers(2,2) < 460 && euclidDist(points1(size1,:),centers(1,:)) < 30       % to be adjusted
        points2(1,:) = centers(2,:);
        size2 = 1;
        init2 = true;
    elseif centers(1,2) < 460
        points2(1,:) = centers(1,:);
        size2 = 1;
        init2 = true;
        ballFrames2 = 0;
        objectFrames2 = 0;
    end    
end

thisCentroid1 = [0 0];
thisCentroid2 = [0 0];

% Update path1
if object1Present && ~object2Present && length(centers(:,1)) == 1 ...
    && ~init1
    thisCentroid1 = centers(1,:);
    points1(size1 + 1,:) = thisCentroid1;
end

% Update path2
if ~object1Present && object2Present && length(centers(:,1)) == 1 ...
    && ~init2
    thisCentroid2 = centers(1,:);
    points1(size2 + 1,:) = thisCentroid2;
end

% Update both paths
if object1Present && object2Present && length(centers(:,1)) >= 2 ...
    && ~init1 && ~init2 && size1 > 0 && size2 > 0
    min1 = 1000;
    min2 = 1000;
    % Use the euclidian distance to make sure the right
    % centers are being assigned to the right paths.
    for k=1 : length(centers(:,1))
        dist1 = euclidDist(centers(k,:),points1(size1,:));
        dist2 = euclidDist(centers(k,:),points2(size2,:));
        if dist1 < min1
            min1 = dist1;
            thisCentroid1 = centers(k,:);
            points1(size1 + 1,:) = thisCentroid1;
        end
        if dist2 < min2
            min2 = dist2;
            thisCentroid2 = centers(k,:);
            points2(size2 + 1,:) = thisCentroid2;
        end            
    end
end

% Clear path1
if object1Present && thisCentroid1(2) > 460
    points1 = zeros(size(points1));
    % Clear path2 if it has been initialised erroneously
    if size2 == 1 || ~object2Present
        points2 = zeros(size(points2));
    end
end

% Clear path2
if object2Present && thisCentroid2(2) > 460
    points2 = zeros(size(points2));
end


end

