function out = separable_diff(image, kx, ky)

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
    

    
    Iy = zeros(height, width);
    Ix = zeros(height, width);

    y_buffer = [];
    for j = round(ky_height/2):height-round(ky_height/2)+1
        %disp(j)
        for i = round(ky_width/2):width-round(ky_width/2)+1
            for k = 1:depth
                pixel = setfor_ky(img, ky, width, height, depth, ky_height, ky_width, i,j,k);
                %y_buffer(i-floor(ky_width/2),j-floor(ky_height/2),k) = pixel;
                Iy(i-floor(ky_width/2),j-floor(ky_height/2)) = pixel;
            end
        end
    end
    
    y_buffer;
    %figure
    %imshow(uint8(buffer))
    img = padarray(image,[floor(kx_width/2) floor(kx_height/2)]);
    [width, height, depth] = size(img);
    
    x_buffer = [];
    for j = round(kx_height/2):height-round(kx_height/2)+1
        %disp(j)
        for i = round(kx_width/2):width-round(kx_width/2)+1
            for k = 1:depth
                pixel = setfor_kx(img, kx, width, height, depth, kx_height, kx_width, i,j,k);
                %x_buffer(i-floor(kx_width/2),j-floor(kx_height/2),k) = pixel;
                Ix(i-floor(kx_width/2),j-floor(kx_height/2)) = pixel;
            end
        end
    end
    
    %comb_buffer = sqrt(x_buffer.^2 + y_buffer.^2);
    comb_buffer = sqrt(Ix.^2 + Iy.^2);
    
    x_buffer;
    y_buffer;
    out = comb_buffer;
end