%���û�ѡ�����ܷ��ࡿ����󣬳��������û���Excel�����õĲ�����app����ֵ
%�Լ������Ƿ��Ѿ�������ά�������������ú��ַ�ʽ��ClassDemo\Classification Learner\nprtool�����з��ࡣ
function Classify_Callback1(hObject, eventdata, handles) %��113��
global x3 lbs2 x2 lbs mappedA Inputs Targets Inputs1 Targets1 Inputs2 Targets2 Inputs3 Targets3 t0 t1 t2 mA mA1 mA2 Inputs_1 Targets_1 Inputs_2 Targets_2

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
%�����и������⣬ÿ���޸���xlsx�еĲ���ֵ���ұ����ˣ���Ϊʲô�����ȡ��ֵ�����޸�֮ǰ��ֵ��

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

Inputs = x2';
if min(lbs(:))==0
    lbs = lbs(lbs~=0);
end
% vector_lbs2 = ind2vec(lbs2); % �����������ֻ����һά
Targets = ind2vec(lbs');

% 1. nnstart >> nprtool��Pattern Recognition and Classification��
% ��Ϊÿ��App׼�����ʵ�"���ݽṹ"������GUI�����н����ܿ�������ѡ�ı���
% �����������ÿһ��Ϊһ������
% �ŵ㣺
% nprtool��ȱ�㣺ֻ��һ�������㣬��ִ��ѵ����ʱ��ֻ���ǵ��߳�
if paraTable_c.app==1
        
Classify_Callback4(hObject, eventdata, handles) 

% 2. classificationLearner
% ��Ϊÿ��App׼�����ʵ�"���ݽṹ"������GUI�����н����ܿ�������ѡ�ı���
% ��������Ϊtable���ͣ�ÿһ��Ϊһ�����ԣ����һ��Ϊcategorical���͵�����

% �ŵ㣺a.�����ֶ�ѡ��Ҫ������ģ���е�Ԥ�������b.�����������ɷַ�����ת��������ɾ������ά��
% c.����ָ������Ӧ��Ĵ���Ԥ��ķ���
% ȱ�㣺�������ݱ���Ϊһά������ִ�ж�ά���ݵķ���
elseif paraTable_c.app==2
    Classify_Callback3(hObject, eventdata, handles);

    str = {'��������δ��ά��table���͵�����t0,t1,t2�ͽ�ά��mA,mA1,mA2'; ...
        't0Ϊ�ܱ�����ȫ�����ݣ�t1��t2Ϊ��rate��ָ���ı���rate��ֵ��ӱ�.';
        'mAΪ�ܱ���Ӧ�ڽ�ά���t0��mA1��mA2Ϊ��rate��ָ���ı�������ӱ�.';
        '����6�����ݾ���������Classification App����ѵ����������Ԥ����';
        '�������ݿɷ���hmenu4_4.UserData.t0,hmenu4_4.UserData.t1��hmenu4_4.UserData.t2';
        'hmenu4_4.UserData.mA,hmenu4_4.UserData.mA1��hmenu4_4.UserData.mA2';
        '��Ҫ���²�����ݣ�����������ִ�У�[mA1,mA2] = createTwoTable(mappedA,lbs,rate); [t1,t2] = createTwoTable(x2,lbs,rate);��'};
    disp(str);
    classificationLearner
    end
% ������ʹ��δ��ά����ֱ�ӷ��࣬��Ϊ��ʱ�����ʱ��̫���ˡ�����4Сʱ
elseif paraTable_c.app==3
% 3. ClassDemo
% ���� '��ά����ͳ��.xlsx' sheet2 �еĲ������ǰ����ǳ��������������
% �ŵ㣺�������ö�������㣬�������ø���Ĵ��ݺ�������Ԫ����
% ȱ�㣺����Բ�������Ҫ�Լ���������������
Classify_Callback2(hObject, eventdata, handles);
else
    disp(['ParametersForDimReduceClassify.xlsx�е�3������app���ô���']);
end
