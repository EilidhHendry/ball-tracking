function frame = detectBalls( binaryImage2D, frame )

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
    % orig values: cAR = 0.95, aR = 0.67, area = 0.94
    % objects(i,6,1) > 0.94 && axisRatio > 0.67 ...
               % &&
    for i=1 : length(find(objects(:,1,1)))
        axisRatio = objects(i,4,1) / objects(i,3,1);
        convexAreaRatio = objects(i,1,1) / objects(i,5,1);
        if objects(i,6,1) > 0.5
            frame = drawRect(frame,objects(i,2,:), 199, 238, 235);
        end
    end

end

