clear;

img = rgb2gray(imread("normal-chest-x-ray.jpg"));

img_gauss = imgaussfilt(img, 1);

otsu_threshold = graythresh(img);
img_otsu = imbinarize(img, otsu_threshold);

imshow(img_otsu, []);