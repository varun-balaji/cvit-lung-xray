clear;

img = rgb2gray(imread("normal-chest-x-ray.jpg"));

img_stretched = imadjust(img, stretchlim(img, [28/255, 180/255]),[]);
img_histeq = histeq(img);

imshow(img_stretched);