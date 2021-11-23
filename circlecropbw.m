function [out,mask]=circlecropbw(img,cx,cy,cr,invert)
img2=uint8(cat(3,img,img,img));
[out,mask]=circlecrop(img2,cx,cy,cr,invert);
out=out(:,:,1);
end