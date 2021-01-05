function center = calculate_centroid(label)
    [height, width] = size(label);

    area = [];
    x = [];
    y = [];

    for i = 1:height
        for j = 1:width
            if label(i,j)~=0 

                [a_h, a_w] = size(area);
                if a_w<label(i,j)
                    area(1,label(i,j)) = 1;
                else
                    area(1,label(i,j)) = area(1,label(i,j))+1;
                end

                [x_h, x_w] = size(x);
                if x_w<label(i,j)
                    x(1,label(i,j)) = 0;
                    x(1,label(i,j)) = x(1,label(i,j)) + j;
                else
                    x(1,label(i,j)) = x(1,label(i,j)) + j;
                end            

                [y_h, y_w] = size(y);
                if y_w<label(i,j)
                    y(1,label(i,j)) = 0;
                    y(1,label(i,j)) = y(1,label(i,j)) + i;
                else
                    y(1,label(i,j)) = y(1,label(i,j)) + i;
                end     

            end
        end
    end

    [random, length] = size(area);

    x_new = [];
    y_new = [];
    area_new = [];
    count = 1;

    for i=1:length
        if area(1,i)~=0
            x_new(1,count) = x(1,i);
            y_new(1,count) = y(1,i);
            area_new(1,count) = area(1,i);
            count = count + 1;
        end
    end

    centroid = [];
    for i=1:count-1
        centroid(1,i) = x_new(1,i)/area_new(1,i);
        centroid(2,i) = y_new(1,i)/area_new(1,i);
    end

    center = centroid;
end