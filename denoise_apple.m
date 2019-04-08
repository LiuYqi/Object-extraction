%import image
apple=imread('apple.bmp');      
subplot(3,3,1);
%显示原始图像
imshow(apple);  
title('原始图');
%转化灰度图 
apple_g = rgb2gray(apple);      
subplot(3,3,2);
%显示灰度图
imshow(apple_g);
title('灰度图');  
%最小值滤波
apple_min = ordfilt2(apple_g,1,ones(3,3));      
subplot(3,3,3);
imshow(apple_min);
title('最小值滤波');

% apple_med = medfilt2(apple_g,[3,3]);      %中值滤波
% subplot(2,3,3);
% imshow(apple_med);
% title('中值滤波');
% apple_edge = edge(apple_min,'sobel', 0.02);     %边缘检测
% subplot(2,3,4);
% imshow(apple_edge);
% title('边缘检测');
%thresh = graythresh(apple_min);     %自动确定二值化阈值；

%二值化处理
thresh = 0.89;
apple_2 = im2bw(apple_min,thresh);      
subplot(3,3,4);
imshow(apple_2);
title('二值化图像');
%膨胀
se = strel('disk',5);
apple_dilate = imdilate(apple_2,se);     
subplot(3,3,5);
imshow(apple_dilate);
title('膨胀');
[m,n]=size(apple_dilate);
%像素值取反
for i = 1:m
    for j = 1:n
        apple_dilate(i,j) = ~apple_dilate(i,j);
    end
end
subplot(3,3,6);
imshow(apple_dilate);
title('像素值取反');
%imfill填充
apple_imfill =  imfill(apple_dilate,'holes');   
subplot(3,3,7);
imshow(apple_imfill);
title('像素填充');
%开运算 消除小物体
apple_open = imerode(apple_imfill,se);
apple_open = imdilate(apple_open,se);
subplot(3,3,8);
imshow(apple_open);
title('开运算消除小物体');
%像素值取反
for i = 1:m
    for j = 1:n
        apple_open(i,j) = ~apple_open(i,j);
    end
end 
subplot(3,3,9);
imshow(apple_open);
title('像素值取反');
imwrite(apple_open,'apple_result.bmp');


