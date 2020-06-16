% ldaPlot1()�������ǽ�������ĵ�ȥ������Ϊ������ĵ���������ĵ����ס��
% ���Կ��ǻ�Ч����������̫�� 
function ldaPlot1(x2,lbs,handles)
cmap = handles.UserData.cmap;
sz = 5;
% c = linspace(1,10,length(x));
% c = repmat([0,0,0],length(x),1);% ones(length(x),1);
% ʹlbs�е���Сֵ��Ϊ��
while(min(lbs))
    lbs = lbs - 1;
end
% ѡ��Ҫ��ʾ�ĵ�
x = x2(lbs>0,1);
y = x2(lbs>0,2);
lbs = lbs(lbs>0);


min_c = min(lbs);
max_c = max(lbs);
c = zeros(size(lbs,1), 3);
for j = min_c : max_c
    ind = find(lbs==j);
    l_ind = length(ind);
    c(ind, :) = repmat(cmap(j+1,:),l_ind,1);
end

figure
scatter(x,y,sz,c,'filled'); %�������е�
xlabel('Feature 1');
ylabel('Feature 2');
title(['Dimensionality Reduction Without Background'],'Interpreter','none');
% saveas(gcf,[str{i},'_LDAdimRed_allPoints_color','.bmp']);
% close figure(1)
end