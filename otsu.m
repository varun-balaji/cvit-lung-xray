clear;

img = rgb2gray(imread("normal-chest-x-ray.jpg"));

img_gauss = imgaussfilt(img, 2);
otsu_threshold = graythresh(img_gauss);
img_otsu = imbinarize(img_gauss, otsu_threshold);

imshow(img_otsu, []);