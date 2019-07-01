clear;

img = rgb2gray(imread("normal-chest-x-ray.jpg"));

img_gauss = imgaussfilt(img, 1);

img_otsu = imbinarize(img);
%img_gauss results in lesser noise

imshow(img_otsu);