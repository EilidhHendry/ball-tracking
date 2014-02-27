% Subtracts the background from the current image and 
% produces a binary logical matrix for subtracted values
% above a given threshold.

function binaryImage = RGBremoveBG(frame, background, threshold)
    
    % Convert the frame values to floating point doubles
    frame = double(frame);   
    
    % Subtraction matrix
    frameDiff=abs(background-frame);
    
    % Logical matrix encoding RGB values above the threshold
    binaryImage = (frameDiff > threshold);
    
end
