% Subtracts the background from the current image and 
% produces a binary logical matrix for subtracted values
% above a given threshold.

function binaryImage = RGBremoveBG(frame, background, Rthresh, Gthresh, Bthresh)
    
    % Convert the frame values to floating point doubles
    frame = double(frame);
    background = double(background);
    
    % Subtraction matrix
    frameDiff=abs(background-frame);
    
    % Logical matrix encoding RGB values above the threshold
    binaryImage(:,:,1) = frameDiff(:,:,1) > Rthresh;
    binaryImage(:,:,2) = frameDiff(:,:,2) > Gthresh;
    binaryImage(:,:,3) = frameDiff(:,:,3) > Bthresh;
    
    
end
