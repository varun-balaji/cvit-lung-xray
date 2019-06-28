clear;

img = rgb2gray(imread("normal-chest-x-ray.jpg"));

img_gauss = imgaussfilt(img, 2);

t = 168;
img_contrasted = img_gauss - (t - img_gauss);

imshow(img_contrasted);