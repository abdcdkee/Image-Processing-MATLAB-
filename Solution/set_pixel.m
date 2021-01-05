function p = set_pixel(img, filt, width, height, depth, filt_height, filt_width, i,j,k)
    
    size = filt_height*filt_width;
    sum = 0; 
    h = 0;
    w = 0;

    for p = i-floor(filt_width/2):i+floor(filt_width/2)
        h = h+1;
        w = 0;
        for q = j-floor(filt_height/2):j+floor(filt_height/2)
            w = w+1;          
            sum = sum + img(p,q,k)*filt(h,w);
        end
    end
    p = sum;
end
