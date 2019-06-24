clear;

img = rgb2gray(imread("normal-chest-x-ray.jpg"));

img_gauss = imgaussfilt(img, 2);


t = 168;
imshow(img_gauss - (t - img_gauss));