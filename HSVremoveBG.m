% Converts the background and frame to HSV, then
% subtracts the background from the frame and 
% produces a binary logical matrix for subtracted values
% above three corresponding HSV thresholds.

function binaryImage = HSVremoveBG(frame, background)

    % Convert the frame and background to doubles
    background = double(background);
    frame = double(frame);
    
    % Convert the frame and background to HSV
    hsvBG = rgb2hsv(background);
    hsvFrame = rgb2hsv(frame);
    
    % Hue, Saturation and Value thresholds
    Hthresh = 0.1;
    Sthresh = 0.1;                         % These need to be configured
    Vthresh = 0.1;
    
    % Subtract frame from background
    frameDiff = abs(hsvBG-hsvFrame);
    
    % Logical matrix encoding HSV values above the corresponding thresholds
    binaryImage(:,:,1) = (frameDiff(:,:,1) > Hthresh);
    binaryImage(:,:,2) = (frameDiff(:,:,2) > Sthresh);
    binaryImage(:,:,3) = (frameDiff(:,:,3) > Vthresh);

end

