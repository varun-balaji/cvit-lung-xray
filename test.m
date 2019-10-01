clear;

img = (imread('/home/varun/cvit/lung_xray/resources/Chest xray dataset/annotated images/00001027_000.png'));

img_histeq = histeq(img);
img_contrast = imadjust(img_histeq, stretchlim(img_histeq, [0.05, 0.95]),[]);

imshow(img_contrast);