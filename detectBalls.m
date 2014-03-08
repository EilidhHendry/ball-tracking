% Draws a rectangle around the ball objects for a frame
% and its corresponding binary image.

function [frame, ballFrames1, ballFrames2, objectFrames1, objectFrames2] = detectBalls(binaryImage2D, frame, ballFrames1, ballFrames2, objectFrames1, objectFrames2, obj1, obj2)

    % Get the regions in the binary image
    ballFinder = regionprops(binaryImage2D,'Area','BoundingBox', ...
        'MajorAxisLength', 'MinorAxisLength', 'ConvexHull', ...
        'ConvexArea', 'Solidity', 'Perimeter');
    
    % Convert the struct into cell arrays for the features
    itemProps = struct2cell(ballFinder);
    
    % Split the features into separate vectors
    areas = cell2mat(itemProps(1,:));
    boxes = zeros(10,4);
    for i=1 : length(itemProps(1,:))
        boxes(i,:) = cell2mat(itemProps(2,i));
    end    
    bigAxes = cell2mat(itemProps(3,:));
    smallAxes = cell2mat(itemProps(4,:));
    convexArea = cell2mat(itemProps(6,:));
    solidities = cell2mat(itemProps(7,:));
    perimeters = cell2mat(itemProps(8,:));
    
    objects = zeros(2,5,4);
    
    count = 1;
    
    % Initialise the objects with their features
    % Include only reagions with a mininum number of pixels
    for i=1 : length(itemProps(1,:))
        if areas(i) > 100            
            objects(count,1,:) = areas(i);
            objects(count,2,:) = boxes(i,:);            
            objects(count,3,:) = bigAxes(i);
            objects(count,4,:) = smallAxes(i);
            objects(count,6,:) = convexArea(i);
            objects(count,7,:) = solidities(i);
            objects(count,8,:) = perimeters(i);
            
            hullPoints = cell2mat(itemProps(5,i,:));
            hullLength = 0;
            for j=1: length(hullPoints(:,1)) - 1
                hullLength = hullLength + euclidDist(hullPoints(j,:), ...
                    hullPoints(j+1,:));
            end                
            objects(count,5,:) = hullLength;
            count = count + 1;
        end
    end
    
    % Iterate over number of objects in image
    for i=1 : length(find(objects(:,1,1)))
        pos = [objects(i,2,1), objects(i,2,2)];
        dist1 = euclidDist(obj1, pos);
        dist2 = euclidDist(obj2, pos);
        convexity = objects(i,5,1) / objects(i,8,1);
        axisRatio = objects(i,4,1) / objects(i,3,1);
        % Check the solidity and axisRatio of the object
        if objects(i,7,1) > 0.94 && axisRatio > 0.67 %&& convexity > 0.92
            frame = drawRect(frame,objects(i,2,:), 199, 238, 235);
            if dist1 < dist2
                if obj1(1) ~= 0
                    ballFrames1 = ballFrames1 + 1;
                end
            else
                if obj2(1) ~= 0
                    ballFrames2 = ballFrames2 + 1;
                end
            end
        else
            if dist1 < dist2
                if obj1(1) ~= 0
                    objectFrames1 = objectFrames1 + 1;
                end
            else
                if obj2(1) ~= 0
                    objectFrames2 = objectFrames2 + 1;
                end
            end
        end
    end

end

