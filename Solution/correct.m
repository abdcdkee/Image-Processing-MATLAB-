function c = correct(img, h, w, p, q)
    if p<q
        for k=1:h
            for o=1:w
                if img(o,k) == q
%                     if p==57
%                        disp(10000000000000000000000000000000000000)
%                     end
                    img(o,k) = p;
                end
            end
        end    
    end    
    if q<p
        for r=1:h
            %disp(f)
            for f=1:w
                if img(f,r) == p
%                     if p==61
%                         disp(100000000000000000000000000000000000000000)
%                     end
                    img(f,r) = q;
                end
            end
        end    
    end   
    c = img;

end