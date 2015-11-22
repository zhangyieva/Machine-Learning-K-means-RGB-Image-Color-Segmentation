%loading image
raw_im =Tiff('trees.tif','r');
im = raw_im.readRGBAImage();
im = im2double(im(1:200,1:200,:));

imshow(im) %show image 


%initial values 
k=7;
itr=0;
ini_miu = rand(k,1,3) ;
new_miu = zeros(k,1,3);
disp(ini_miu);

%starting loop to find the best miu
while new_miu ~= ini_miu 
    if (itr ~= 0)
    ini_miu = new_miu;
    end
    count = zeros(k,1,3); 
    sum = zeros (k,1,3);
    for i=1:200
        for j=1:200
            d = zeros(1,k);  %initialize distance vector for each point 
            for p=1:k
            
                dif=im(i,j,:)-ini_miu(p,1,:);
                dif=dif(:); %vectorlize the point difference 
                d(1,p)=norm(dif)^2;
            end
            
            d_min=min(d);

            for q = 1:k
                dif=im(i,j,:)-ini_miu(q,1,:);
                dif=dif(:);
                d=norm(dif)^2;
                
                if (d == d_min)
                    
                   count(q,1,:)= count(q,1,:)+1;
                   sum(q,1,:) = sum(q,1,:) + im(i,j,:);
                end 
            end 
        end
        for r = 1:k 
            new_miu(r,1,:) = sum(r,1,:)./count(r,1,:);
        end
    end

    itr = itr+1;
    disp(itr)
    disp(new_miu)
end

%display an image where the pixel values are replaced by the nearest centroid mean value

for i=1:200
        for j=1:200
            
            d = zeros(1,k); 
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
 
figure
imshow(im)




