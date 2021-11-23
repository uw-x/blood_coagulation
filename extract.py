import sys
import os
import cv2
import time

def extract(fname):
	if not os.path.exists(fname):
		os.mkdir(fname)
		vidcap = cv2.VideoCapture('./'+fname+'.mp4')
		success,image = vidcap.read()
		count = 0
		while success:
		  cv2.imwrite("./"+fname+"/frame%d.jpg" % count, image)      
		  success,image = vidcap.read()
		  print (fname,count)
		  count += 1
t=time.time()
extract('video')
print (time.time()-t)