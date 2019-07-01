clear;

img = rgb2gray(imread("normal-chest-x-ray.jpg"));

img_gauss = imgaussfilt(img, 2);

otsu_threshold = graythresh(img_gauss);

%t = 186;
t = otsu_threshold;
img_contrasted = img_gauss - (t - img_gauss);
img_canny_contrasted = edge(img_contrasted, 'Canny');


figure;
subplot(1, 2, 1);
imshow(img_contrasted, []);
subplot(1, 2, 2);
imshow(img_canny_contrasted, []);