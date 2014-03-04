% Update the list of points for the two objects with the centroids
% of the current blobs in the frame.

function [points1, points2] = updatePaths( points1, points2, binImage, blobFinder )

    [area,centers] = step(blobFinder, binImage);
    centers = centers;
    
    % Check which centroid corresponds to which object
    
    found1 = find(points1(:,1));
    found2 = find(points2(:,1));
    
    [object1Present, object2Present] = isObjectPresent(points1, points2, centers);
    
    if ~object1Present & ~object2Present & length(centers(:,1)) >= 1
        points1(1,:) = centers(1,:);
    end

    if ~isempty(found1) | ~isempty(found2)
    
        for k=1 : length(centers(:,1))
            % Compare the distance of the new centroid to the last
            % found centroid for this item.
            if object1Present
                dist1 = euclidDist(centers(k,:), points1(length(found1),:));
            end
            if object2Present
                dist2 = euclidDist(centers(k,:), points2(length(found2),:));
            end

            % Assign the shortest distance centroid to the corresponding list
            % of points of the object.
            if object1Present & object2Present
                if dist1 <= dist2
                    points1(length(found1) + 1,:) = centers(k,:);
                else
                    points2(length(found2) + 1,:) = centers(k,:);
                end
            else
                if object1Present
                    points1(length(found1) + 1,:) = centers(k,:);
                    lastCentroid1 = points1(found1(length(found1)) + 1,:);
                end
                if object2Present
                    points2(length(found2) + 1,:) = centers(k,:);
                    lastCentroid2 = points1(found2(length(found2)) + 1,:);
                end
            end

        end

        if object1Present & lastCentroid1(2) > 470
            points1 = zeros(size(points1));
        end

        if object2Present &lastCentroid2(2) > 470
            points2 = zeros(size(points2));
        end
    end
    

end

