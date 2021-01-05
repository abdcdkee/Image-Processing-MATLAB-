function label = label_image(binary)
    bin = double(binary);

    [width, height] = size(bin);

    count = 2;  
    store = [];

    for j=1:height
        for i=1:width
           if bin(i,j)==1
               if j>1 && i>1
                   if bin(i,j-1)>1 && bin(i-1,j)>1
                       store(bin(i,j-1), bin(i-1,j)) = 1;
                       %store(bin(i-1,j), bin(i,j-1)) = 1;
                       if bin(i,j-1)<bin(i-1,j)
                           bin(i,j) = bin(i,j-1);
                       end
                       if bin(i-1,j)<bin(i,j-1)
                           bin(i,j) = bin(i-1,j);
                       end   
                       if bin(i-1,j)==bin(i,j-1)
                           bin(i,j) = bin(i-1,j);
                       end
                   elseif bin(i,j-1)>1
                       bin(i,j) = bin(i,j-1);
                   elseif bin(i-1,j)>1
                       bin(i,j) = bin(i-1,j);
                   else
                       bin(i,j) = count;
                       count = count + 1;
                   end
               end
               if j==1 && i==1
                   bin(i,j) = count;
                   count = count + 1;
               end
               if j==1 && i>1
                   if bin(i-1,j)>1
                       bin(i,j) = bin(i-1,j);
                   else
                       bin(i,j) = count;
                       count = count + 1;
                   end
               end
               if i==1 && j>1
                   if bin(i,j-1)>1
                       bin(i,j) = bin(i,j-1);
                   else
                       bin(i,j) = count;
                       count = count + 1;
                   end

               end
           end
        end
    end

    [store_height, store_width] = size(store);
 
    for x=1:30
        %disp(x)
        for i=1:store_height
            for j=1:store_width
                if store(i,j)==1
                    bin = correct(bin, height, width, i, j);
                end
            end
        end
    end
    
    label = bin;
end