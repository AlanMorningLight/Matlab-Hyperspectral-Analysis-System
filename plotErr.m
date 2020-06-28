function plotErr(varargin) % ������������>>>������
best_perf = varargin{1};
best_vperf = varargin{2};
best_tperf = varargin{3};
racc = varargin{4};
[n, m] = size(best_perf);

if nargin==4 
    %������plotErr(best_perf, best_vperf, best_tperf, racc)���ַ�ʽ���á�
    %ÿһ�����ݻ���һ��ͼ�������Ż�ǰ����������ݸ�����best_perf��һ�У�
    %�򱾺����Ὣ�Ż�ǰ���Ż�������ݸ�����һ��ͼ��    
    for i = 1:m  
        figure()
        plot((1:n)',[best_perf(:, i), best_vperf(:, i), best_tperf(:, i), racc(:, i)],'LineWidth',1.5);
            %racc ����ʣ�������
            %best_perf ѵ����������ܣ���ɫ���ߣ�
            %best_vperf ��֤��������ܣ���ɫ���ߣ�
            %best_tperf ���Լ�������ܣ���ɫ���ߣ�
            %tTest ΪԤ�������ǩ������        
        title('ѵ�����ܣ�best_perf,best_vperf,best_tperf���뷺�����ܣ�racc)','Interpreter','none');
        xlabel('����');
        ylabel('������');

        hold on
        %mean()����������ƽ�������Խ�����ʽת��������ʽ
        plot([1, n],[mean(racc(:, i)), mean(racc(:, i))],'--','LineWidth',1.5);

        text(1.05,mean(racc(:, i))*1.030,['racc', num2str(i), ':', num2str(mean(racc(:, i)))]);
        legend({['best_perf', num2str(i)],['best_vperf', num2str(i)],['best_tperf', num2str(i)],['racc', num2str(i)]},...
            'Interpreter','none','Location','best');  
        hold off
    end
elseif nargin==5
    %������plotErr(best_perf, best_vperf, best_tperf, racc, K)���ַ�ʽ���á�
    %ÿһ�����ݻ���һ�����ߣ������Ż�ǰ����������ݸ�����best_perf��һ�У�
    %�򱾺����Ὣ�Ż�ǰ���Ż�������ݻ�����ͬһ��ͼ�ϡ�
    K = varargin{5};
    %% ֻ���Ʒ�������racc
    if K==1       
        %figure()
        plot((1:n)',racc,'LineWidth',1.5);
            %racc ����ʣ�������
            %best_perf ѵ����������ܣ���ɫ���ߣ�
            %best_vperf ��֤��������ܣ���ɫ���ߣ�
            %best_tperf ���Լ�������ܣ���ɫ���ߣ�
            %tTest ΪԤ�������ǩ������        
        title('�������ܣ�racc)','Interpreter','none');
        xlabel('����');
        ylabel('������');
        
        hold on
        %mean()����������ƽ�������Խ�����ʽת��������ʽ
        plot([1, n],[mean(racc(:,1)), mean(racc(:,1))],'--','LineWidth',1.5);

        text(1.05,mean(racc(:,1))*1.030,['racc1:',num2str(mean(racc(:,1)))]);
        try %��racc�����У����Ż�ǰ������ݸ�ռһ�У��������������������2������
            plot([1, n],[mean(racc(:,2)), mean(racc(:,2))],'--','LineWidth',1.5);
            text(1.05,mean(racc(:,2))*1.030,['racc2:',num2str(mean(racc(:,2)))]);
            legend('racc1','racc2','Interpreter','none','Location','best');  
            %1��ʾ�Ż�ǰ�����ݣ�2��ʾ�Ż��������
        catch%��racc������һ�����ݣ�����һ�е���������ͼ��
            legend('racc','Interpreter','none','Location','best');  
        end 
        hold off 
    %% ������ѵ��������best_perf �ͷ������� racc   
    elseif K==2
        %figure()
        plot((1:n)',[best_perf, racc],'LineWidth',1.5);
            %racc ����ʣ�������
            %best_perf ѵ����������ܣ���ɫ���ߣ�
            %best_vperf ��֤��������ܣ���ɫ���ߣ�
            %best_tperf ���Լ�������ܣ���ɫ���ߣ�
            %tTest ΪԤ�������ǩ������        
        title('ѵ�����ܣ�best_perf���뷺�����ܣ�racc)','Interpreter','none');
        xlabel('����');
        ylabel('������');
        
        hold on
        %mean()����������ƽ�������Խ�����ʽת��������ʽ
        plot([1, n],[mean(racc(:,1)), mean(racc(:,1))],'--','LineWidth',1.5);

        text(1.05,mean(racc(:,1))*1.030,['racc1:',num2str(mean(racc(:,1)))]);
        try %��racc�����У����Ż�ǰ������ݸ�ռһ�У��������������������2������
            plot([1, n],[mean(racc(:,2)), mean(racc(:,2))],'--','LineWidth',1.5);
            text(1.05,mean(racc(:,2))*1.030,['racc2:',num2str(mean(racc(:,2)))]);
            legend('best_perf1','best_perf2','racc1','racc2','Interpreter','none','Location','best');  
            %1��ʾ�Ż�ǰ�����ݣ�2��ʾ�Ż��������
        catch%��racc������һ�����ݣ�����һ�е���������ͼ��
            legend('best_perf','racc','Interpreter','none','Location','best');  
        end 
        hold off 
    %% ����ѵ������ best_perf �������� best_tperf �ͷ������� racc    
    elseif K==3
        %figure()
        plot((1:n)',[best_perf, best_tperf, racc],'LineWidth',1.5);
            %racc ����ʣ�������
            %best_perf ѵ����������ܣ���ɫ���ߣ�
            %best_vperf ��֤��������ܣ���ɫ���ߣ�
            %best_tperf ���Լ�������ܣ���ɫ���ߣ�
            %tTest ΪԤ�������ǩ������        
        title('ѵ�����ܣ�best_perf, best_tperf���뷺�����ܣ�racc)','Interpreter','none');
        xlabel('����');
        ylabel('������');
        
        hold on
        %mean()����������ƽ�������Խ�����ʽת��������ʽ
        plot([1, n],[mean(racc(:,1)), mean(racc(:,1))],'--','LineWidth',1.5);

        text(1.05,mean(racc(:,1))*1.030,['racc1:',num2str(mean(racc(:,1)))]);
        try %��racc�����У����Ż�ǰ������ݸ�ռһ�У��������������������2������
            plot([1, n],[mean(racc(:,2)), mean(racc(:,2))],'--','LineWidth',1.5);
            text(1.05,mean(racc(:,2))*1.030,['racc2:',num2str(mean(racc(:,2)))]);
            legend('best_perf1','best_perf2', 'best_tperf1','best_tperf2','racc1','racc2','Interpreter','none','Location','best');  
            %1��ʾ�Ż�ǰ�����ݣ�2��ʾ�Ż��������
        catch%��racc������һ�����ݣ�����һ�е���������ͼ��
            legend('best_perf','best_tperf','racc','Interpreter','none','Location','best');  
        end 
        hold off
   %% ����ѵ������ best_perf ��֤���� best_vperf �������� best_tperf �ͷ������� racc     
    elseif K==4
        %figure()
        plot((1:n)',[best_perf, best_vperf, best_tperf, racc],'LineWidth',1.5);
            %racc ����ʣ�������
            %best_perf ѵ����������ܣ���ɫ���ߣ�
            %best_vperf ��֤��������ܣ���ɫ���ߣ�
            %best_tperf ���Լ�������ܣ���ɫ���ߣ�
            %tTest ΪԤ�������ǩ������        
        title('ѵ�����ܣ�best_perf,best_vperf,best_tperf���뷺�����ܣ�racc)','Interpreter','none');
        xlabel('����');
        ylabel('������');
        
        hold on
        %mean()����������ƽ�������Խ�����ʽת��������ʽ
        plot([1, n],[mean(racc(:,1)), mean(racc(:,1))],'--','LineWidth',1.5);

        text(1.05,mean(racc(:,1))*1.030,['racc1:',num2str(mean(racc(:,1)))]);
        try %��racc�����У����Ż�ǰ������ݸ�ռһ�У��������������������2������
            plot([1, n],[mean(racc(:,2)), mean(racc(:,2))],'--','LineWidth',1.5);
            text(1.05,mean(racc(:,2))*1.030,['racc2:',num2str(mean(racc(:,2)))]);
            legend('best_perf1','best_perf2','best_vperf1','best_vperf2','best_tperf1','best_tperf2','racc1','racc2','Interpreter','none','Location','best');  
            %1��ʾ�Ż�ǰ�����ݣ�2��ʾ�Ż��������
        catch%��racc������һ�����ݣ�����һ�е���������ͼ��
            legend('best_perf','best_vperf','best_tperf','racc','Interpreter','none','Location','best');  
        end 
        hold off
        %��ʾ���շ�������racc��ʾ����Ĵ����ʣ�1-racc��ʾ����׼ȷ�ʡ�
    end
end