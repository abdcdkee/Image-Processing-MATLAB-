
clc
clear all
close all
%%%%%% Q1 part c

image = imread('Q1c.jpg');
%image = [1,2,3,4;1,4,5,6;3,7,8,9] %test image 

kx = 0.1*[1,2,4,2,1];      %Gaussian Filter 
ky = kx';

subplot 131
imshow(image);                     %displays input image
title('input image for part c')

test = convolve(image,kx,ky);      
test2 = separable_convolve(image,kx,ky);

subplot 132
imshow(uint8(test));
title('gaussian output with 2D convolution');
subplot 133
imshow(uint8(test2));
title('gaussian output with 1D convolution');
figure;

%%%%%%Q1 part d and e 

kx_g = [];                  %define gaussian filter

for i = -2:2
    kx_g(i+3) = (1/sqrt(2*pi*0.83^2))*exp((-i^2)/(2*0.83^2));
end

ky_g = kx_g';     

%apply gaussian filter

gauss = uint8(convolve(image,kx_g,ky_g));
subplot 131
imshow(image);
title('input image');
subplot 132
imshow(gauss);
title('gaussian filtered output for part d');

%Apply sharpening effects

sharp = image + 8.*(image-gauss);        %alpha = 8 determined arbitrarily

subplot 133
imshow(sharp);
title('sharpened output for part e');
figure

%%%%%%Q1 Part h

kx = 0.5*[1, 0, -1];       % defined kx and ky values as obtained in part f
ky = 0.5*([1, 0, -1]');

image_new = double(rgb2gray(imread('Q1h.jpeg')));
%image_new = [1,2,3,4;1,4,5,6;3,7,8,9] %test image 
gauss_new = convolve(image_new,kx_g,ky_g);
diff_image = separable_diff(image_new, kx, ky);
diff_gauss = separable_diff(gauss_new, kx, ky);

subplot 221
imshow(uint8(image_new))
title('input image')
subplot 222
imshow(uint8(gauss_new))
title('gaussian filtered image')
subplot 223
imshow(uint8(diff_image))
title('derivative of input image')
subplot 224
imshow(uint8(diff_gauss))
title('derivative of gaussian filtered image')

%%% We observe that the derivative for a gaussian image is much less noisy
%%% than the original image. The edges are much better pronounced in the
%%% gaussian derivative, and the outline of the original image clear. 
