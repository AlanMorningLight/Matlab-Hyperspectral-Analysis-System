% clear,close%���ƹ��׷����ʵ����ߣ���ȡͬһ���ص������ͨ�����Ƴ�һ������
% clc

function spectralReflectivity(hmenu4_1)  %��'��������'
    timerVal_1 = tic;
    disp('���׷�������.....................................................');
try
    cmap = hmenu4_1.UserData.cmap;
catch
        cmap = handles.UserData.cmap;   
end

    N = hmenu4_1.UserData.M-1;
    x2 = hmenu4_1.UserData.x2;
    lbs = hmenu4_1.UserData.lbs;
    chs = size(x2,2);
    
%% ÿһ�ֹ��׻���һ��figure    
    for i = 1 : N 
        row = find(lbs==i);
        %����Ϊʲô��Ҫ��find����Ϊ��Ҫͳ�Ƹ���
        % �������ͳ�Ƹ����Ļ��Ͳ���find��ֱ�����߼�ֵ����
        if numel(row)>50
            row = row(1:50);
        end
        figure
        plot(1:chs, x2(row,:), 'color', cmap(i+1,:));
        xlabel('Channels');
        ylabel('Reflective coeff');
        xlim([1,chs]);
    %     saveas(gcf,['Class_',num2str(i),'.png']);
    end


%% ��subplot��ͼ����ʽ�����й��׻�����һ��figure��
    M = ceil(sqrt(N));
    if N == M^2
        d = [M,M];
    elseif N>(M-1)*M
        d = [M-1,M+1];
    else
        d = [M-1,M];
    end
    figure
    for i = 1:N 
        row = find(lbs==i);
        if numel(row)>50
            row = row(1:50);
        end
        ax = subplot(d(1),d(2),i);
        plot(ax, 1:chs, x2(row,:), 'color', cmap(i+1,:));
%         xlabel('Channels');
%         ylabel('Reflective coeff');
        xlim([1,chs]); 
    end
%     saveas(gcf,['Class_1~',num2str(N),'.bmp']);
    time1 = toc(timerVal_1);
    disp(['���׷�����ɣ���ʱ',num2str(time1),'��.']);
end