% clear,close all hidden  %���Ҫ����ͬ���ĵ��ע�ϲ�ͬ����ɫ��
% clc
% �������ݣ�
% ��ά���mat����x2, ��ÿһ����һ�����ԣ�������
% һά�������ı�ǩ����lbs, 
% �پ���cmap
% ldaPlot��pcaPlot�ĺ��Ĵ��붼��һ����

% colorBase = [ [1,0,0]; [0,1,0]; [0,0,1]; [1,1,0]; [1,0,1]; [0,1,1]; ...
%                     [0.5,0,0]; [0,0.5,0];[0,0,0.5]; [0.5,1,0]; [1,0.5,0]; [0.5,0.5,0]; ... 
%                     [0.5,0,1]; [1,0,0.5]; [0.5,0,0.5]; [0,0.5,1]; [0,1,0.5]; [0,0.5,0.5]; ...
%                     [0.5,0.5,0.5]; [0.1,0.1,0.1]];
% str = {'Botswana','Indian_pines_corrected','KSC','Pavia','Salinas_corrected'};
% str1 = {'Botswana','Indian_pines','KSC','Pavia','Salinas'};
% 
% N = length(str);
% for i = 1 : N
% S = load([str{i},'_2d_LDA.mat'],'z'); % 
% input = getfield(S,'z');
% S1 = load([str1{i},'_gt_Colum.mat'],'lbs'); % 
% labels = getfield(S1,'lbs');
function ldaPlot(x2,lbs,handles)
cmap = handles.UserData.cmap;
x = x2(:,1);
y = x2(:,2);
sz = 5;
% c = linspace(1,10,length(x));
% c = repmat([0,0,0],length(x),1);% ones(length(x),1);
if ~min(lbs)
    lbs = lbs + 1;
end

min_c = min(lbs);
max_c = max(lbs);
c = zeros(size(lbs,1), 3);
for j = min_c : max_c
    ind = find(lbs==j);
    l_ind = length(ind);
    c(ind, :) = repmat(cmap(j,:),l_ind,1);
end

figure
scatter(x,y,sz,c,'filled'); %�������е�
xlabel('Feature 1');
ylabel('Feature 2');
title(['Dimensionality Reduction'],'Interpreter','none');
% saveas(gcf,[str{i},'_LDAdimRed_allPoints_color','.bmp']);
% close figure(1)
end