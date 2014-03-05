function [points1, points2] = updatePaths2(points1, points2, binImage, blobFinder)

[area,centers] = step(blobFinder, binImage);

size1 = length(find(points1(:,1)));
size2 = length(find(points2(:,1)));

[object1Present, object2Present] = isObjectPresent2(points1, points2, centers);

% Initialise path1 (Y coordinate must be less than 460)
if object1Present && size1 == 0
    if centers(1,2) < 460
        points1(1,:) = centers(1,:);
    end
end
   
% Initialise path2 (Y coordinate must be less than 460)
if object1Present && object2Present && size2 == 0
    if centers(2,2) < 460 && euclidDist(points1(size1),centers(1,:)) < 30       % to be adjusted
        points2(1,:) = centers(2,:);
    elseif centers(1,2) < 460
        points2(1,:) = centers(1,:);
    end
end

thisCentroid1 = [0 0];
thisCentroid2 = [0 0];

% Update path1
if object1Present && ~object2Present && length(centers(:,1)) == 1 ...
    && size1 > 0
    thisCentroid1 = centers(1,:);
    points1(size1 + 1,:) = thisCentroid1;
end

% Update path2

% Clear path1
if object1Present && thisCentroid1(2) > 460
    points1 = zeros(size(points1));
end


end

