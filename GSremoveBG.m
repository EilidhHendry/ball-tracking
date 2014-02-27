% Converts the image and background to grayscale then 
% divides the frame by the background. We use this result
% to test for values above a certain threshold which we include
% in a logical binary matrix of the image.

% Threshold must be between zero and one.

function binaryImage = GSremoveBG(frame, background, threshold)

    % Convert the frame values to floating point doubles
    frame = double(frame);
    
    % Convert the frame and background to grayscale
    grayBG = myrgb2gray(background);
    grayFrame = myrgb2gray(frame);
    
    % Divide image with background frame
    frameDiff = abs(grayFrame ./ grayBG);
    
    % Binary image of filtered objects
    binaryImage = (frameDiff <= threshold) .* 255;

end

