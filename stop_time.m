clear

tic
y=920;
x=500;
r=200;
fps=60;

fname='video';
n=length(dir(strcat(fname)))-3;
n=floor(n/fps)*fps-(fps/10);

met=[];
for start=0:(fps/10):n
    img1=imread(strcat(fname,'/frame',int2str(start),'.jpg'));
    sz=size(img1);
    if sz(1)==1080
        img1=rot90(rgb2gray(img1),3);
    end
    img1=circlecropbw(img1,y,x,r,0);
    img1=img1(y-r:y+r,x-r:x+r,:);
    
    img2=imread(strcat(fname,'/frame',int2str(start+(fps/10)),'.jpg'));
    sz=size(img2);
    if sz(1)==1080
        img2=rot90(rgb2gray(img2),3);
    end
    img2=circlecropbw(img2,y,x,r,0);
    img2=img2(y-r:y+r,x-r:x+r,:);

    cc=abs(img1-img2);
    
    met=[met sum(sum(cc))];
    [num2str((start/n)*100) '% complete']
end
dlmwrite(strcat('stop_time_',fname,'.txt'),met);
toc



























