%������ʵ����α��ɫͼ����ʾ������򣬼���Matͼ��GTͼ�ص���һ��
function img = stack_image(imgMat, imgGT, cmap, M)
% id1 = imgGT~=0;    %512��614 logical
% id2 = imgGT~=[0,0,0];  %�ᱨ������ά�ȱ���һ�¡�
% id3 = imgGT(:)~=0; %314368��1 logical
% id4 = imgGT(:)~=[0,0,0]; %314368��3 logical
% a = [min(imgMat(:)),max(imgMat(:)),min(imgGT(:)),max(imgGT(:))]
% imgMat(id1)=imgGT(id1);   %395 587
%�����ֵ���ֻ���൱�ڸı���imgMat�ĵ�һҳ����imgMat(:,:,2)��imgMat(:,:,3)δ�ı�

for i = 2:M
    id1 = (imgGT==i-1);  
%     [row,col]=find(imgGT==(i-1));
%     imgMat(row,col,:)=cmap(i,:);   %�޷�ִ�и�ֵ����Ϊ���Ĵ�СΪ 761��761��3���Ҳ�Ĵ�СΪ 1��3��
%     imgMat(row,col,:) = reshape(cmap(i,:),1,1,[]);
%     imgMat((imgGT==i-1))= reshape(cmap(i,:),1,1,[]);
%     c = reshape(cmap(i,:),1,1,[]);
%     d = repmat(c,numel(row),numel(col),1);

%�Ȳ�⣬�����顣���Ƚ�3άͼƬ���Ϊ3��2άͼƬ��ÿ��2άͼƬ��ʹ���߼�������ֵ��
    imgMat1 = imgMat(:,:,1);
    imgMat1(id1) = cmap(i,1);             %imgGT==1�ĵ��ܹ���761��
    imgMat2 = imgMat(:,:,2);
    imgMat2(id1) = cmap(i,2);             %imgGT==1�ĵ��ܹ���761��
    imgMat3 = imgMat(:,:,3);
    imgMat3(id1) = cmap(i,3);             %imgGT==1�ĵ��ܹ���761��
% 3��2άͼƬ��ֵ��Ϻ��ٽ�3��2άͼƬ����Ϊһ��3άͼƬ��
    imgMat(:,:,1) = imgMat1;
    imgMat(:,:,2) = imgMat2;
    imgMat(:,:,3) = imgMat3;
end

p = figure();
% axes1 = axes('Parent',p,'Tag','axes1');
himage = imshow(imgMat);%,'Parent',axes1);
hscrollpanel = imscrollpanel(p, himage); 
end