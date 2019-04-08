%import image
apple=imread('apple.bmp');      
subplot(3,3,1);
%��ʾԭʼͼ��
imshow(apple);  
title('ԭʼͼ');
%ת���Ҷ�ͼ 
apple_g = rgb2gray(apple);      
subplot(3,3,2);
%��ʾ�Ҷ�ͼ
imshow(apple_g);
title('�Ҷ�ͼ');  
%��Сֵ�˲�
apple_min = ordfilt2(apple_g,1,ones(3,3));      
subplot(3,3,3);
imshow(apple_min);
title('��Сֵ�˲�');

% apple_med = medfilt2(apple_g,[3,3]);      %��ֵ�˲�
% subplot(2,3,3);
% imshow(apple_med);
% title('��ֵ�˲�');
% apple_edge = edge(apple_min,'sobel', 0.02);     %��Ե���
% subplot(2,3,4);
% imshow(apple_edge);
% title('��Ե���');
%thresh = graythresh(apple_min);     %�Զ�ȷ����ֵ����ֵ��

%��ֵ������
thresh = 0.89;
apple_2 = im2bw(apple_min,thresh);      
subplot(3,3,4);
imshow(apple_2);
title('��ֵ��ͼ��');
%����
se = strel('disk',5);
apple_dilate = imdilate(apple_2,se);     
subplot(3,3,5);
imshow(apple_dilate);
title('����');
[m,n]=size(apple_dilate);
%����ֵȡ��
for i = 1:m
    for j = 1:n
        apple_dilate(i,j) = ~apple_dilate(i,j);
    end
end
subplot(3,3,6);
imshow(apple_dilate);
title('����ֵȡ��');
%imfill���
apple_imfill =  imfill(apple_dilate,'holes');   
subplot(3,3,7);
imshow(apple_imfill);
title('�������');
%������ ����С����
apple_open = imerode(apple_imfill,se);
apple_open = imdilate(apple_open,se);
subplot(3,3,8);
imshow(apple_open);
title('����������С����');
%����ֵȡ��
for i = 1:m
    for j = 1:n
        apple_open(i,j) = ~apple_open(i,j);
    end
end 
subplot(3,3,9);
imshow(apple_open);
title('����ֵȡ��');
imwrite(apple_open,'apple_result.bmp');


