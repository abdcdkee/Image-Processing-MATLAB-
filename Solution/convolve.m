function out = convolve(image, kx, ky)

    img = double(image);
    filter = ky*kx;
    filter = flipud(filter);
    filter = fliplr(filter);
    filt = double(filter);

    [filt_width, filt_height] = size(filt);
    img = padarray(img,[floor(filt_height/2) floor(filt_width/2)]);

    [width, height, depth] = size(img);


    buffer = [];

    for j = round(filt_height/2):height-round(filt_height/2)+1
        %disp(j)
        for i = round(filt_width/2):width-round(filt_width/2)+1
            for k = 1:depth
                pixel = set_pixel(img, filt, width, height, depth, filt_height, filt_width, i,j,k);
                buffer(i-floor(filt_width/2),j-floor(filt_height/2),k) = pixel;
            end
        end
    end

    out = buffer;
end