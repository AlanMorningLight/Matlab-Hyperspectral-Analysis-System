%���û�ѡ��nprtool������󣬱���������
function Classify_Callback4(hObject, eventdata, handles) %��113��
global Inputs Targets Inputs1 Targets1 Inputs2 Targets2 Inputs3 Targets3 mA1 mA2 Inputs_1 Targets_1 Inputs_2 Targets_2
% �ڴ˴��������������ʼλ������Ϊȫ�ֱ�����������nprtool����������ѡ����п�����Ӧ����

%% ���ݴ�����άmatת��ά����άgtתһά��
% hmenu4 = findobj(handles,'Tag','Analysis');
hmenu4_1 = findobj(handles,'Label','��������');
hmenu4_3 = findobj(handles,'Label','ִ�н�ά');

if isempty(hmenu4_3.UserData) || ~isfield(hmenu4_3.UserData, 'drData') || isempty(hmenu4_3.UserData.drData)
    mappedA = hmenu4_1.UserData.x2;         %������δ����ά
else
    mappedA = hmenu4_3.UserData.drData;  %�������Ѿ����˽�ά
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



%% nprtool��������Ҫ������׼���������ǽ����ݺͱ�ǩ�ֿ���

% Inputs��Targets��Ϊnprtool׼���ĵ�1������(ͨ���������δ��ά������)
    Inputs = x2';
    if min(lbs(:))==0
        lbs = lbs(lbs~=0);
    end
% vector_lbs2 = ind2vec(lbs2); % �����������ֻ����һά
    Targets = ind2vec(lbs');

% ���������ţ������������ݼ�
    n = size(x2,1);        % ��������
    m = randperm(n);  % ����1��n�����������������
    k = round(rate*n);  % ��ȡѵ������������
    ind1 = m(1:k);
    ind2 = m(k+1:end);

% ׼����2�����ݣ�ind1ռ��Ϊ rate��
    Inputs_1 = Inputs(:, ind1);
    Targets_1 = Targets(:, ind1);

% ׼����3�����ݣ�ind1ռ��Ϊ rate��
    Inputs_2 = Inputs(:, ind2);
    Targets_2 = Targets(:, ind2);
% 1. nnstart >> nprtool��Pattern Recognition and Classification��
% ��Ϊÿ��App׼�����ʵ�"���ݽṹ"������GUI�����н����ܿ�������ѡ�ı���
% �����������ÿһ��Ϊһ������
% �ŵ㣺
% nprtool��ȱ�㣺ֻ��һ�������㣬��ִ��ѵ����ʱ��ֻ���ǵ��߳�
% ׼����2������ (ͨ����������Ѿ���ά������)
    Inputs1= mappedA';
    Targets1 = Targets';
% ׼����3�����ݣ�����2�����ݻ���Ϊ���ݣ���������ռ��Ϊ��1-rate����  
    Inputs2 = table2array(mA1(:, 1:end-1))';  %�������ֵ�Ӽ�(���ų�categorical�м�����ֵ��)ת��Ϊ����
    Targets2 = table2array(mA1(:, end))';
    Targets2 = ind2vec(double(Targets2));
% ׼����4�����ݣ�����2�����ݻ���Ϊ���ݣ���������ռ��Ϊ rate��      
    Inputs3 = table2array(mA2(:, 1:end-1))';
    Targets3 = table2array(mA2(:, end))';
    Targets3 = ind2vec(double(Targets3));
    
    time1 = toc(timerVal_1);
    disp({['����׼����ϣ���ʱ',num2str(time1),'��.',...
    hmenu4_1.UserData.matPath,' ��ʼִ�з���']});

    nprtool;

end
