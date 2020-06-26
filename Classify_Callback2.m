%%���û�ѡ��ClassDemo������󣬱���������
function Classify_Callback2(hObject, eventdata, handles) %��113��
global x3 lbs2 x2 lbs mappedA Inputs Targets Inputs1 Inputs2 Inputs3 t0 t1 t2 mA mA1 mA2
%% ���ݴ�����άmatת��ά����άgtתһά��
% hmenu4 = findobj(handles,'Tag','Analysis');
hmenu4_1 = findobj(handles,'Label','��������');
hmenu4_3 = findobj(handles,'Label','ִ�н�ά');

if isempty(hmenu4_3.UserData) || ~isfield(hmenu4_3.UserData, 'drData') || isempty(hmenu4_3.UserData.drData)
    mappedA = hmenu4_1.UserData.x2;         %������δ����ά���ӡ��������ݡ�����ȡ����
    disp('ע�⣺����δ����ά����ֱ�ӷ��������Ҫ���ĸ���ʱ�䣡');
else
    mappedA = hmenu4_3.UserData.drData;  %�������Ѿ����˽�ά���ӡ�ִ�н�ά������ȡ����
end
disp('���ࣺ������Ч�Լ��............');
% if isfield(hmenu4_1.UserData, 'x2') || ~isempty(hmenu4_1.UserData.x2)
try
    x2 = hmenu4_1.UserData.x2;
catch
    feedData(hmenu4_1,handles);%����������δ�ɹ�
    return;
end

try
    lbs = hmenu4_1.UserData.lbs; 
catch
    feedData(hmenu4_1,handles);%����ǩ��������δ�ɹ�
    return;
end

try
    type = hmenu4_1.UserData.cAlgorithm;%��δѡ������㷨
catch
    feedData(hmenu4_1,handles);
    return;
end

%������ѵ�����Ͳ��Լ�������������
%     prompt = ['������ѵ�����Ͳ��Լ�����������������ǰ����Ϊ',num2str(hObject.UserData.rate)];
%     dlg_title = 'ָ��ѵ��������Լ�������������';
%     an = inputdlg(prompt,dlg_title,1);%resize��������Ϊon
%     if ~isempty(an{:})
%         rate = str2double(an{:}); 
%     end

% ��ѡ����㷨���Ƽ����
type = hmenu4_1.UserData.cAlgorithm;
val = hmenu4_1.UserData.cValue;
% ������Ŷ�ȡĬ�ϲ���
dataLines = [val+1, val+1];%��val���㷨��Ӧ��excel�ĵ�val+1��
% dataLines = val+1;

workbookFile = fullfile(handles.UserData.mFilePath,"ParametersForDimReduceClassify.xlsx");
try
    paraTable_c = importfile2(workbookFile, "Sheet2", dataLines);
catch    
    paraTable_c = importfile2(workbookFile, "Sheet2", [2,2]);
end
t = table2cell(paraTable_c);
ss = table2struct(paraTable_c);
n = numel(t); 
para = cell(1,2*n);
for i = 1:n
	para{2*i} = t{i};
	para{2*i-1} = paraTable_c.Properties.VariableNames{i};
end

% �õ����շ���׼ȷ��acc
% hyperDemo_1(hmenu4_1.UserData.x3);
% hyperDemo_detectors_1(hmenu4_1.UserData.x3);
% һά���෽��
timerVal_1 = tic;
disp('����׼��.......................................................................');

rate = paraTable_c.rate;

if min(lbs(:))==0
    lbs = lbs(lbs~=0);
end
% vector_lbs2 = ind2vec(lbs2); % �����������ֻ����һά

% 3. ClassDemo
% ���� '��ά����ͳ��.xlsx' sheet2 �еĲ������ǰ����ǳ��������������
% �ŵ㣺�������ö�������㣬�������ø���Ĵ��ݺ�������Ԫ����
% ȱ�㣺����Բ�������Ҫ�Լ���������������
    validateattributes(paraTable_c.hiddenLayerNum,{'numeric'},{'integer','positive','>=',1,'<=',5},'','hiddenLayerNum',12)

    time1 = toc(timerVal_1);
    disp({['����׼����ϣ���ʱ',num2str(time1),'��.',...
    hmenu4_1.UserData.matPath,' ��ʼִ�з���']});

    var = cellfun(@string, para(9:end)); %��cell array�е�����cellӦ��string

    if paraTable_c.dimReduce && ~isempty(hmenu4_3.UserData) && isfield(hmenu4_3.UserData, 'drData') && ~isempty(hmenu4_3.UserData.drData)

        % ִ��20�η��࣬�ͻ���20�����ݣ���������Ϊ�˾����ܵ�ʹ���ݻ��־���
        % ��ΪĿǰ��������pca��ά��������ص�������б������1���ɷ���ռ�ı���̫����
        % �����Ļ���������ڷ�����
        n = paraTable_c.executionTimes;
        racc = zeros(n,1);
        best_perf =  zeros(n,1); 
        best_vperf =zeros(n,1); 
        best_tperf = zeros(n,1);
        
        try
            MyPar = parpool; %������г�δ��������򿪲��д����
        catch
            MyPar = gcp; %������г��Ѿ��������򽫵�ǰ���гظ�ֵ��MyPar
        end
        
        racc = [];
        best_perf = []; 
        best_vperf = []; 
        best_tperf = [];    						
        for k = 1 : n
            [mA1,mA2, ind1, ind2] = createTwoTable(mappedA,lbs,rate);
            XTrain = table2array(mA1(:, 1:end-1))';
        %     TTrain = dummyvar(double(mA1.Class))';
            TTrain = ind2vec(double(mA1.Class)');
            XTest = table2array(mA2(:, 1:end-1))';
        %     TTest = dummyvar(double(mA2.Class))';
            TTest = ind2vec(double(mA2.Class)');
            disp(['��',num2str(k),'�μ���']);
            [err1, err2, err3, err4, tTest] = classDemo(XTrain, TTrain, XTest, TTest, type, var);%ǰ3��Ϊ�������������Ϊ��ѡ����
            %racc ����ʣ�������
            %best_perf ѵ����������ܣ���ɫ���ߣ�
            %best_vperf ��֤��������ܣ���ɫ���ߣ�
            %best_tperf ���Լ�������ܣ���ɫ���ߣ�
            %tTest ΪԤ�������ǩ������ 
        
            racc = [racc; err1];%racc ����ʣ�������
            best_perf = [best_perf; err2]; %best_perf ѵ����������ܣ���ɫ���ߣ�
            best_vperf = [best_vperf; err3]; %best_vperf ��֤��������ܣ���ɫ���ߣ�
            best_tperf = [best_tperf; err4];%best_tperf ���Լ�������ܣ���ɫ���ߣ�
      
        end
        %acc1��������Ϊ�ṹ���Ƿ���ʣ�
    %         time1 = toc(timerVal_1);
    %         disp({['����׼����ϣ���ʱ',num2str(time1),'��.'];...
    %         [hmenu4_1.UserData.matPath,' ��ʼִ�з���']});
        hObject.UserData.racc = racc;
        hObject.UserData.best_perf = best_perf;
        hObject.UserData.best_vperf = best_vperf;
        hObject.UserData.best_tperf = best_tperf;
%         hObject.UserData.lbsOrigin = lbs;
        lbsTest = lbs;
        lbsTest(ind2) = tTest;      %tTest ΪԤ�������ǩ������%��Ԥ��ֵ����lbs�е���ʵֵ
        hObject.UserData.lbsTest = lbsTest; %���������Ԥ��ֵ�ı�ǩ����
        
        gtdata = handles.UserData.gtdata;
        gtdata(gtdata~=0)=lbsTest;    %����ǩ�������г�GTͼ

        hObject.UserData.imgNew = double(gtdata);%����Ԥ�������GTͼ
        handles.UserData.imgNew = hObject.UserData.imgNew;
        %����Ԥ���GTͼ����ʵ��GTͼ
        SeparatePlot3_Callback(handles.UserData.imgNew, handles.UserData.cmap, handles.UserData.M);
        SeparatePlot3_Callback(handles.UserData.gtdata,    handles.UserData.cmap, handles.UserData.M);
        delete(MyPar) %������ɺ�رղ��д����
        
        % ������������>>>������
        figure()
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

        text(1,mean(racc(:,1))*1.030,['racc1:',num2str(mean(racc(:,1)))]);
        try %��racc�����У����Ż�ǰ������ݸ�ռһ�У��������������������2������
            plot([1, n],[mean(racc(:,2)), mean(racc(:,2))],'--','LineWidth',1.5);
            text(1,mean(racc(:,2))*1.030,['racc2:',num2str(mean(racc(:,2)))]);
            legend('best_perf1','best_perf2','best_vperf1','best_vperf2','best_tperf1','best_tperf2','racc1','racc2','Interpreter','none','Location','best');  
            %1��ʾ�Ż�ǰ�����ݣ�2��ʾ�Ż��������
        catch%��racc������һ�����ݣ�����һ�е���������ͼ��
            legend('best_perf','best_vperf','best_tperf','racc','Interpreter','none','Location','best');  
        end 
        hold off
        %��ʾ���շ�������racc��ʾ����Ĵ����ʣ�1-racc��ʾ����׼ȷ�ʡ�
        
        % ������������>>>>׼ȷ��
        figure()
        plot((1:n)',1-[best_perf, best_vperf, best_tperf, racc],'LineWidth',1.5);
            %racc ����ʣ�������
            %best_perf ѵ����������ܣ���ɫ���ߣ�
            %best_vperf ��֤��������ܣ���ɫ���ߣ�
            %best_tperf ���Լ�������ܣ���ɫ���ߣ�
            %tTest ΪԤ�������ǩ������        
        title('ѵ�����ܣ�acc_perf,acc_vperf,acc_tperf���뷺�����ܣ�acc)','Interpreter','none');
        xlabel('����');
        ylabel('׼ȷ��');
        
        hold on
        acc = 1-racc; %mean()����������ƽ�������Խ�����ʽת��������ʽ
        plot([1, n],[mean(acc(:,1)), mean(acc(:,1))],'--','LineWidth',1.5);
        text(1,mean(acc(:,1))*1.005,['acc1:',num2str(mean(acc(:,1)))]);
        try %��acc�����У����Ż�ǰ������ݸ�ռһ�У��������������������2������
            plot([1, n],[mean(acc(:,2)), mean(acc(:,2))],'--','LineWidth',1.5);
            text(1,mean(acc(:,2))*1.005,['acc2:',num2str(mean(acc(:,2)))]);
            legend('acc_perf1','acc_perf2','acc_vperf1','acc_vperf2','acc_tperf1','acc_tperf2','acc1','acc2','Interpreter','none','Location','best');  
            %1��ʾ�Ż�ǰ�����ݣ�2��ʾ�Ż��������
        catch%��acc������һ�����ݣ�����һ�е���������ͼ��
            legend('acc_perf','acc_vperf','acc_tperf','acc','Interpreter','none','Location','best');  
        end 
        hold off
        hmenu4_4 = findobj(handles,'Label','ִ�з���');    
        hmenu4_4.UserData
        
        % ��ʾ������ʱ
        time2 = toc(timerVal_1);
        disp({[hmenu4_1.UserData.matPath, ' �������! ��ʱ',num2str(time2-time1),'��.']});

    else  % �������������ϣ�δѡ��[ִ�н�ά]��ֱ��ѡ��[ִ�з���]��������classificationLearner
        if ~exist('t0','var') || isempty(t0) || size(x2,1)~=size(t0,1)
            t0 = createTable(x2, lbs);
            [t1,t2] = createTwoTable(x2,lbs,rate);
            mA = createTable(mappedA, lbs);
            [mA1,mA2] = createTwoTable(mappedA,lbs,rate);
        end
        classificationLearner
    end
end
