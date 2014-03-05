function [points1, points2] = updatePaths2(points1, points2, binImage, blobFinder)

[area,centers] = step(blobFinder, binImage);

size1 = length(find(points1(:,1)));
size2 = length(find(points2(:,1)));
init1 = false;   % Flag for indicating
init2 = false;

[object1Present, object2Present] = isObjectPresent2(points1, points2, centers);

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
    end
end
   
% Initialise path2 (Y coordinate must be less than 460)
if object1Present && object2Present && size2 == 0 && ~init1
    if centers(2,2) < 460 && euclidDist(points1(size1),centers(1,:)) < 30       % to be adjusted
        points2(1,:) = centers(2,:);
    elseif centers(1,2) < 460
        points2(1,:) = centers(1,:);
    end
    size2 = 1;
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

% Clear path1
if object1Present && thisCentroid1(2) > 460
    points1 = zeros(size(points1));
    % Clear path2 if it has been initialised erroneously
    if size2 == 1
        points2 = zeros(size(points2));
    end
end

% Clear path2
if object2Present && thisCentroid2(2) > 460
    points2 = zeros(size(points2));
end


end

