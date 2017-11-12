# ImageInpainting-and-SelectiveBlur
This was done as a part of the coursework for EE604A (Image Processing) at IIT Kanpur.  
MATLAB implementation of the inpainting algorithm as proposed by Criminisi et al. in 2004, and that of selective motion blur.  

# The GUI: Image Inpainting
![alt Inpainting1](https://github.com/TheGalileo/ImageInpainting-and-SelectiveBlur/blob/master/images/GUINothing.JPG)
![alt Inpainting2](https://github.com/TheGalileo/ImageInpainting-and-SelectiveBlur/blob/master/images/GUISolved.png)
![alt Inpainting3](https://github.com/TheGalileo/ImageInpainting-and-SelectiveBlur/blob/master/images/ImageWithOutput.JPG)

# The GUI: Selective Motion Blur
![alt MotionBlur1](https://github.com/TheGalileo/ImageInpainting-and-SelectiveBlur/blob/master/images/OrgImage1.JPG)
![alt MotionBlur2](https://github.com/TheGalileo/ImageInpainting-and-SelectiveBlur/blob/master/images/Something.png)
![alt MotionBlur3](https://github.com/TheGalileo/ImageInpainting-and-SelectiveBlur/blob/master/images/ImgOutput.JPG)

# Sample Output Images


# How to Run
## Requirements:
The Inpainting algorithm will work (and has been tested) on MATLAB 2015b and MATLAB 2017a. It shouldn't be a problem to get it running on the versions that came in between these two (and the ones that are about to come).  
The selective motion blur will work only on MATLAB 2017a (and beyond) as it makes use of Lazy Snapping, which was introduced very recently.

## Steps:
### Image Inpainting
 - Run `GraphicalUserInterface.m`.  
 - Select the radio button corresponding to 'Remove Object'.
 - Click on the 'Upload Image' button and navigate to the directory that contains that image you want to process. Select the image.
 - Use the freehand tool to select the boundary of the object that is to removed. You don't have to close the selection entirely; it does that on its own by looking for the shortest path (a straight line) between the points where you started and left.
 - Click on 'Process!' and wait for a while.  
  
Unsatisfied? Try changing the patch size, given by `psz`, in line number 170 of `GraphicalUserInterface.m`. It should be an odd number. According to Criminisi et al. : The size of the template window must be slightly larger than the largest distinguishable texture element, in the source region.

### Selective Motion Blur
 - Run `GraphicalUserInterface.m`.
 - Select the radio button corresponding to 'Remove Object'.
 - Click on the 'Upload Image' button and navigate to the directory that contains that image you want to process. Select the image.
 - Select multiple pixels from the foreground (these are the initial seeds that you are providing, for segmentation). When you are done selecting the seed-pixels from the foreground, right click to get out of the selection mode.
 - Now, select multiple pixels from the background. When you are done selecting the seed-pixels from the foreground, right click to get out of the selection mode.
 - Click on 'Process!' and wait for a while.  
  
Unsatisfied? Try modifying the seeds that you provided in the foreground and the background. Initialization is considerably important here.

# Detailed Report
Is available in the directory titled `Report`.

# Acknowledgements
I would like to thank the [Course Instructor](http://home.iitk.ac.in/~tanaya/Home.html) for giving us the space to think that we can keep our style. I would also like to thank [Ikuo Degawa](https://ikuwow.github.io/), a Web Engineer in Tokyo as I referred to his implementation of inpainting whenever I found myself stuck.

# References
1. Criminisi, Antonio, Patrick Perez, and Kentaro Toyama. ”Object removal by exemplar-based inpainting.” Compute Vision and Pattern Recognition, 2003. Proceedings. 2003 IEEE Computer Society Conference on. Vol.
2. Li, Y., Sun, J., Tang, C.K. and Shum, H.Y., 2004, August. Lazy snapping. In ACM Transactions on Graphics (ToG) (Vol. 23, No. 3, pp. 303-308). ACM.
