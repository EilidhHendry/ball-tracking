% returns a specified RGB image as greyscale 

% T.Breckon, 15/10/04

% For details on how this works and for general work 
% with greyscale images in matlab see: 
% http://www.mathworks.com/access/helpdesk/help/techdoc/creating_plots/chimag15.html

function greyscaleImage = myrbg2gray(rgbImage)
  
  
  % for each pixel in the original RGB image
  % create a new greyscale pixel in the new 
  % image

        % calculate the monochrome luminance (i.e. greyscale) by 
        % combining the RGB values according to the 
        % NTSC standard, which applies coefficients 
        % related to the eye's sensitivity to RGB colors.

        greyscaleImage = uint8(.2989 * double(rgbImage(:,:,1))  + .5870 * double(rgbImage(:,:,2))  + .1140 * double(rgbImage(:,:,3)));
