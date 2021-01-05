function p = setfor_kx(img, filt, width, height, depth, filt_height, filt_width, i,j,k)
    
    size = filt_height*filt_width;
    sum = 0; 
    h = 1;
    w = 0;

    for q = j-floor(filt_height/2):j+floor(filt_height/2)
       w = w+1;          
       sum = sum + img(i,q,k)*filt(h,w);
    end
    p = sum;
end
