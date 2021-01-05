function p = setfor_ky(img, filt, width, height, depth, filt_height, filt_width, i,j,k)
    
    size = filt_height*filt_width;
    sum = 0; 
    h = 0;
    w = 1;

    for p = i-floor(filt_width/2):i+floor(filt_width/2)
        h = h+1;     
        sum = sum + img(p,j,k)*filt(h,w);
    end
    p = sum;
end
