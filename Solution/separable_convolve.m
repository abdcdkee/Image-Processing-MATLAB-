function out = separable_convolve(image, kx, ky)

    img = double(image);
%     ky = flipud(ky);
%     kx = fliplr(kx);
    kx = double(kx);
    ky = double(ky);

    [kx_width, kx_height] = size(kx);
    [ky_width, ky_height] = size(ky);
    
    img = padarray(img,[floor(ky_width/2) floor(ky_height/2)]);
    %disp(kx_height/2)
    %disp(kx_width/2)
    [width, height, depth] = size(img);

    buffer = [];
    for j = round(ky_height/2):height-round(ky_height/2)+1
        %disp(j)
        for i = round(ky_width/2):width-round(ky_width/2)+1
            for k = 1:depth
                pixel = setfor_ky(img, ky, width, height, depth, ky_height, ky_width, i,j,k);
                buffer(i-floor(ky_width/2),j-floor(ky_height/2),k) = pixel;
            end
        end
    end
    buffer;
    %figure
    %imshow(uint8(buffer))
    img = padarray(buffer,[floor(kx_width/2) floor(kx_height/2)]);
    [width, height, depth] = size(img);
    
    new_buffer = [];
    for j = round(kx_height/2):height-round(kx_height/2)+1
        %disp(j)
        for i = round(kx_width/2):width-round(kx_width/2)+1
            for k = 1:depth
                pixel = setfor_kx(img, kx, width, height, depth, kx_height, kx_width, i,j,k);
                new_buffer(i-floor(kx_width/2),j-floor(kx_height/2),k) = pixel;
            end
        end
    end

    out = new_buffer;
end