clear;

img = rgb2gray(imread("normal-chest-x-ray.jpg"));

img_gauss = imgaussfilt(img, 2);
img_histeq = histeq(img_gauss);

img_cannyedges_histeq_gauss = edge(img_histeq, 'Canny');
img_cannyedges_gauss = edge(img_gauss, 'Canny');

figure;
subplot(1, 2, 1);
imshow(img_cannyedges_gauss, []);
subplot(1, 2, 2);
imshow(img_cannyedges_histeq_gauss, []);