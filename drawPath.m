% Draws the path of an object and calculates and draws
% its highest point.

function [image,highestReached, highestPoint,isBall1, isBall2] = drawPath(path,r,g,b, image, highestReached, highestPoint, ballFrames, objectFrames, isBall1, isBall2,ball1,ball2)

%if there is no path and the threshold is 1 set it to 0 again (to clear
%path)
if path(1)==0 && highestReached==1
    highestPoint = [5 5];           % If the path is empty initialise
    highestReached=0;
    isBall1 =0;                      % the highest point, and set the 
    isBall2 =0; 
end                                 % flag to false.

found = find(path(:,1));  % length of the path

for k=1 : length(found)
     
    center = path(k,:);
       
    % Only check for highest point if the path has at least 25 points
    if length(found)>25
        if k>3
            y=1;
            dist=euclidDist((path(k,:)),(path(k-1,:)));
            dist2=euclidDist((path(k-2,:)),(path(k-1)));
            totalDist=dist+dist2;

        % Check if the current point is lower than the previous point
        % Make sure distance of last three points is less than 4 pixels.
            if center(2)>path(k-1,2) && highestReached==0 && totalDist>4
                if ballFrames > objectFrames
                    pause(3);
                    if ball1
                        isBall1=1;   

                    elseif ball2
                        isBall2=1;
                    end
                end
                highestPoint=fliplr(uint16(center));
                highestReached=1;
            end
        end
    end

    % Flip and cast to int in order to draw
    flippedCenter = fliplr(uint16(center));

    % Draws path of object
    if flippedCenter(1) > 0 && flippedCenter(2) > 0
        
        image(flippedCenter(1), flippedCenter(2),:) = [r g b];
        % Draw highest point.
        if highestReached == 1 && ((isBall1 && ball1) || (isBall2 && ball2))
            image(highestPoint(1), highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)+1, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)+2, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)+3, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)-1, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)-2, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1)-3, highestPoint(2),:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)+1,:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)+2,:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)+3,:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)-1,:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)-2,:) = [255 255 255];
            image(highestPoint(1), highestPoint(2)-3,:) = [255 255 255];
        end
        
    end
end

end

