 new_miu 
 
for i=1:200
        for j=1:200
            
            d = zeros(1,5); 
            for p=1:k
            
                dif=im(i,j,:)-new_miu(p,1,:);
                dif=dif(:);
                d(1,p)=norm(dif)^2;
            end
            
            d_min=min(d);

            for q = 1:k
                dif=im(i,j,:)-new_miu(q,1,:);
                dif=dif(:);
                d=norm(dif)^2;
                
                if (d == d_min)
                    im(i,j,:)= new_miu(q,1,:);
                end
            end
        end
 end