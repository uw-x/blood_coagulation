clear

fname='video';
fps=60;

%% read particle motion curve and note length of video
end_video=dlmread(strcat('stop_time_',fname,".txt"));
end_video=movmean(end_video,10);

sz=size(end_video);
t=linspace(0,(length(end_video)*(fps/10))/fps,sz(2));

%% calculate start time
% read start_time file
begin_video=dlmread(strcat("start_time_",fname,".txt"));

% find knee point of pipette motion curve
kp=knee_pt(movmean(begin_video,10));

% crop from start to knee point
begin_video=begin_video(1:kp);
xstart=linspace(0,(length(begin_video)*(fps/10))/fps,length(begin_video));

% find most prominent peak in cropped range
% then identify start time
[pks,locs,~,p]=findpeaks(begin_video);
[prom,startp]=max(p);
startloc=locs(startp);
begin_time=t(startloc);

%% calculate end time

% offset the start point by 10 seconds from when measurement starts
offset=startloc+(10*10);
end_video=end_video(offset:end);

% normalize motion curve between [0,1]
% trim off end of motion curve
end_video=(end_video-min(end_video))/(max(end_video)-min(end_video));
f=find(end_video<.01);
end_video=end_video(1:f(1));

kp=knee_pt(end_video)+offset;
end_time=t(kp);

% %% calculate PT and INR
pt=end_time-begin_time;
pt_normal=12;
isi=1.31;
alpha=-0.31;
inr=(pt/pt_normal).^(isi-alpha);

sprintf('PT: %.1f\nINR: %.1f',pt,inr)

































