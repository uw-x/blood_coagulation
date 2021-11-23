function [out,mask]=circlecrop(img,cx,cy,cr,invert)

[rows, columns, numberOfColorChannels] = size(img);

rgbImage2=uint8(zeros(rows,columns,3));

rgbImage2 = imresize(rgbImage2, [rows, columns]);

imageSize = size(img);
ci = [cx, cy, cr];
[xx,yy] = ndgrid((1:imageSize(1))-ci(1),(1:imageSize(2))-ci(2));
mask = (xx.^2 + yy.^2) < ci(3)^2;
if invert==1
    mask=~mask;
end

redChannel1 = img(:, :, 1);
greenChannel1 = img(:, :, 2);
blueChannel1 = img(:, :, 3);
redChannel2=rgbImage2(:,:,1);
greenChannel2=rgbImage2(:,:,2);
blueChannel2=rgbImage2(:,:,3);
redChannel2(mask) = redChannel1(mask);
greenChannel2(mask) = greenChannel1(mask);
blueChannel2(mask) = blueChannel1(mask);
out = cat(3, redChannel2, greenChannel2, blueChannel2);

end