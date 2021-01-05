function bin = threshold_image(input, threshold)
    gray = rgb2gray(input);
    bin = gray > threshold;
end