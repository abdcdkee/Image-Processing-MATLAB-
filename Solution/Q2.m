
clc
clear all
close all

%Q2 part a 

image = imread('objects.png');
subplot 211
imhist(rgb2gray(image))
title('histogram of input image')
threshold = 10;                                 %% for objects.png, obtained through experimentation
binary = threshold_image(image,threshold);

subplot 212
imshowpair(image,binary,'montage')
title('input image versus binary output, threshold = 10')

%Q2 part b 

label = label_image(binary);

out = label2rgb(label);
figure
imshowpair(uint8(image),uint8(out),'montage');
title('input image and labelled output are shown')

%Q2 part c 

centroid = calculate_centroid(label);
center = center_objects(label);
figure
imshow(uint8(label2rgb(center)))
title('Centers of each object are shown')

%Q2 part d 

%part 1
%
%There are 13 objects in the image. These can easily be counted else we can
%take the length of the output vector from the calculate_centroid fiction. 

[null, length] = size(centroid);

%length is 13 confirmed.

%part 2
%
%Already accomplished when we produce a centroid. Thus can be the
%descriptor of the location of each object


%part 3
%
%The area can be calculated by just iterating the area vector and noting
%the maximum area, and generating a black center at the object with the
%maximum area. 

area_max = calculate_max_area(label);

figure;
imshow(uint8(label2rgb(area_max)));
title('The center of the object with maximum area has been highlighted.')


%part 4
%
image = imread('ducks.png');
figure
subplot 211
imhist(rgb2gray(image))
title('histogram for ducks image input')
threshold = graythresh(rgb2gray(image));  %for ducks
BW = imbinarize(rgb2gray(image),threshold);
subplot 212
imshowpair(image,BW,'montage')
title('input image versus binary output')
%Threshold values both obtained experimentally and throug the MATLAB built
%in function fail to give a good binary images with 6 distinct objects.
%This shows that it is not possible to segment the image and count the
%objects with the current image pipeline, unless we involve some sort of
%preprocessing e.g. smoothing to make the image threshold more prominent,
%making it easy to separate the background form the objects.


%part 5 
%
%There can be several approaches employed to determine the geometrical
%shape of given objects. The essential factor is extracting features out of
%shaps. 
%One such feature could be the signature of the object which basically
%determines the distance of a centroid from edge. Each corner of the shape
%gives a peak. We can count the number of peaks, and subsequently determine
%the shape of the object based on known facts about the numbers of corners 
%they have for e.g. we know that a triangle with 3 peaks, square and rectangle 
%with 4 peaks, pentagon with 5 peaks etc. We can apply smoothing techniques 
%since peaks may not be smooth.
%Similarly, we can also configure bounding boxes that surroung the objects
%in the image and assist in shape detection. For e.g. for 4 peaks we can
%have either a square or a rectangle, but the size dimensions of a bounding
%box will allow us to determine which specific shape it is. 
%We are of course free to extract features more than just the corners. For
%example the edges, angles etc. are often useful. 

%I will let this answer rest for now because I think this is sufficient
%information on one popular, and common sense technique. Of course,
%multiple other variants are possible involving machines learning, pattern
%recognition, fourier descriptors, chain codes etc. but which seem a bit
%beyond the scope of this answer. 


%%%%%%%%%%%% Afterword Note

%I hope the amount of explanations given for each part seem sufficient. I 
%even planned to actually code an algorithm for Q2 part d part 5, but lack
%of time and other impending assignment and deadline made it impossible. I
%was unable to actually devote this assignment the amount of time I wanted
%to, even though this was the most fun assignment I've had this semester.
%Though Computer Vision assignment 3 does come close where we used GAN
%techniques to generate images out of nothing, deepfakes are amazing! 

%Thank you for a wonderful course. Hasta la Vista. 






%%%%%%%%%%%%% Appendix

% Matrices below were used for testing the algorithms above

% bin = [1,0,0,0,0,0,0,0;
%        0,1,1,0,1,1,0,0;
%        0,1,1,1,1,0,0,0;
%        0,1,0,0,0,0,0,0;
%        0,0,0,0,0,0,1,0;
%        1,0,0,0,0,0,1,1;
%        0,1,0,1,0,0,0,0;
%        0,1,1,0,0,0,0,0];
%    
% bin = [0,0,0,0,0,0,0,0,0,0,0,0,0;
%        0,1,1,1,0,0,0,0,0,0,0,0,0;
%        0,1,1,1,0,0,0,0,0,0,0,0,0;
%        0,1,1,1,0,0,0,0,0,0,0,0,0;
%        0,0,0,0,0,0,0,0,0,0,0,0,0;
%        0,0,0,0,0,1,0,0,1,1,0,0,0;
%        0,0,0,0,0,1,0,0,1,1,0,0,0;
%        0,0,0,0,0,1,1,1,1,1,0,0,0;
%        1,1,0,0,0,1,1,1,1,1,1,1,0;
%        1,1,0,0,0,1,1,1,1,1,1,1,0;
%        0,0,0,0,0,0,0,0,0,0,0,0,0];


%For some reason I thought Q2 part 5 was asking to determine object
%orientation not shape and wrote all of the below paragraph before
%realizing it was wrong. I didn't have the heart to delete it. 

%The determination of orientation basically has to do with utilizing the
%second moment of the objects. Orientation can be defined in terms of an
%axis through the object such that second moment about the axis is minimal.
%This also requires parameterization of a line since the minimal axis has
%to be considered w.r.t all possible lines through the object in the image.
%
%We will then obtain a line that passes through the center of mass of the
%object by minimizing the second moment by taking its derivative and
%equating it to zero. We can then substitute a change of coordinates of the
%line passing through image centroid and with arithmetic manipulation
%obtain a formula for theta defining the orientation of the object as 

%           tan 2*theta = 2*C_{11} / (C_{20} - C_{02})

%This is inspired from the topic Representation: Orientation outlined in
%Slides  18 - Feature Extraction.
