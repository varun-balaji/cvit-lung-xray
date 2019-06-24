img = rgb2gray(imread('House.jpg'));
imshow(img);
edgeimg = edge(img, 'Canny');
imshow(edgeimg);