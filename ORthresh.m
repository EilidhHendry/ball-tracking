% Creates a 2D binary image of the moving objects without
% the background.

% The three channels of the binary matrix are logical
% OR'd together to obtain a 2D binary image.

% OR produces better recall but results in more background
% noise.

function binaryImage2D =ORthresh(binaryImage3D)  

    % We logical OR the matrices for each channel together
    % In order to preserve the original output for the included pixels
    binaryImage2D = binaryImage3D(:,:,1) | binaryImage3D(:,:,2) | binaryImage3D(:,:,3);
    
end

