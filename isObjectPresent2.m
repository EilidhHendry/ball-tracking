function [object1Present, object2Present] = isObjectPresent2(points1, points2, centers)

% Case where no centroids are detected
object1Present = false;
object2Present = false;

% Case where 2 or more centroids are detected
if length(centers(:,1)) >= 2
    object1Present = true;
    object2Present = true;
end

% Case where 1 centroid is detected
if length(centers(:,1)) == 1
    if ~isempty(find(points1))
        lastCentroid1 = points1(length(find(points1)));
    else
        lastCentroid1 = []; % If the path is empty return empty;
    end
    if ~isempty(find(points2))
        lastCentroid2 = points2(length(find(points2)));
    else
        lastCentroid2 = [];
    end
    
    % If one of the paths is empty then the object that is present
    % is the one without the empty path
    % If both paths are empty, then object1 is present by default
    if euclidDist(lastCentroid1,centers(1,:)) <= euclidDist(lastCentroid2,centers(1,:))
        object1Present = true;
    else
        object2Present = true;
    end
end

end

