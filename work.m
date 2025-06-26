clc;
clear;
clearvars;


function out = stretch_histogram_gray(img,max_val,min_val)
    img = im2double(img);
    min_val = min_val;
    max_val = max_val;
	out = (img - min_val) / (max_val - min_val);
end
img=imread("C:\Users\Titi\Desktop\img proj\New images\Margan.png"); 
img=im2double(img);
enhanced_img = zeros(size(img));
for c = 1:3
    channel = img(:,:,c);
    min_val = prctile(channel(:), 2);
    max_val = prctile(channel(:), 98);
    enhanced_img(:,:,c) = stretch_histogram_gray(channel, max_val, min_val);
end
uu=enhanced_img;
hsi=rgb2hsv(enhanced_img);
q=imgaussfilt(hsi(:,:,3),.5);
I=hsi(:,:,3)-q;
hsi(:,:,3)=hsi(:,:,3)+I;
hsi(:,:,3)=q;
hsi = min(max(hsi, 0), 1);
hsi = real(hsi);
enhanced_img = hsv2rgb(hsi);
subplot(1,3,1); imshow(img); title("before");
subplot(1,3,2); imshow(uu); title("after streching");
subplot(1,3,3); imshow(enhanced_img); title("after sharpinning and smoothing ");
