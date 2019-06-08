clear;

img = rgb2gray(imread("normal-chest-x-ray.jpg"));
img_gauss = imgaussfilt(img, 2);

figure;
subplot(1, 2, 1);
imshow(img, []);
subplot(1, 2, 2);
imshow(img_gauss, []);