%���û�ѡ��Classification Learner������󣬱���������
function Classify_Callback3(hObject, eventdata, handles) %��113��
global x3 lbs2 x2 lbs mappedA Inputs Targets Inputs1 Inputs2 Inputs3 t0 t1 t2 mA mA1 mA2
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

%% ׼��������֮�������кü���˼·

if min(lbs(:))==0
    lbs = lbs(lbs~=0);
end
% vector_lbs2 = ind2vec(lbs2); % �����������ֻ����һά


% 2. classificationLearner
% ��Ϊÿ��App׼�����ʵ�"���ݽṹ"������GUI�����н����ܿ�������ѡ�ı���
% ��������Ϊtable���ͣ�ÿһ��Ϊһ�����ԣ����һ��Ϊcategorical���͵�����

% �ŵ㣺a.�����ֶ�ѡ��Ҫ������ģ���е�Ԥ�������b.�����������ɷַ�����ת��������ɾ������ά��
% c.����ָ������Ӧ��Ĵ���Ԥ��ķ���
% ȱ�㣺�������ݱ���Ϊһά������ִ�ж�ά���ݵķ���

    if ~exist('t0','var') || isempty(t0) || size(x2,1)~=size(t0,1)    
        t0 = createTable(x2, lbs);
        [t1,t2] = createTwoTable(x2,lbs,rate);
        mA = createTable(mappedA, lbs);
        [mA1,mA2] = createTwoTable(mappedA,lbs,rate);
    end
    str = {'��������δ��ά��table���͵�����t0,t1,t2�ͽ�ά��mA,mA1,mA2'; ...
        't0Ϊ�ܱ�����ȫ�����ݣ�t1��t2Ϊ��rate��ָ���ı���rate��ֵ��ӱ�.';
        'mAΪ�ܱ���Ӧ�ڽ�ά���t0��mA1��mA2Ϊ��rate��ָ���ı�������ӱ�.';
        '����6�����ݾ���������Classification App����ѵ����������Ԥ����';
        '�������ݿɷ���hmenu4_4.UserData.t0,hmenu4_4.UserData.t1��hmenu4_4.UserData.t2';
        'hmenu4_4.UserData.mA,hmenu4_4.UserData.mA1��hmenu4_4.UserData.mA2';
        '��Ҫ���²�����ݣ�����������ִ�У�[mA1,mA2] = createTwoTable(mappedA,lbs,rate); [t1,t2] = createTwoTable(x2,lbs,rate);��'};
    disp(str);    
    
    time1 = toc(timerVal_1);
    disp({['����׼����ϣ���ʱ',num2str(time1),'��.',...
    hmenu4_1.UserData.matPath,' ��ʼִ�з���']});
    
    classificationLearner

% ������ʹ��δ��ά����ֱ�ӷ��࣬��Ϊ��ʱ�����ʱ��̫���ˡ�����4Сʱ

end
