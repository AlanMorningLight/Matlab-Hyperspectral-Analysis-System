%���û�ѡ�����ܷ��ࡿ����󣬳��������û���Excel�����õĲ�����app����ֵ
%�Լ������Ƿ��Ѿ�������ά�������������ú��ַ�ʽ��ClassDemo\Classification Learner\nprtool�����з��ࡣ
function Classify_Callback1(hObject, eventdata, handles) %��113��

hmenu4_1 = findobj(handles,'Label','��������');
% ��ѡ����㷨���Ƽ����
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

% ������ʹ��δ��ά����ֱ�ӷ��࣬��Ϊ��ʱ�����ʱ��̫���ˡ�����4Сʱ
elseif paraTable_c.app==3
% 3. ClassDemo
% ���� '��ά����ͳ��.xlsx' sheet2 �еĲ������ǰ����ǳ��������������
% �ŵ㣺�������ö�������㣬�������ø���Ĵ��ݺ�������Ԫ����
% ȱ�㣺����Բ�������Ҫ�Լ���������������
hmenu4_4_2 = findobj(handles,'Label','ClassDemo'); 
Classify_Callback2(hmenu4_4_2, eventdata, handles); %��������������hmenu4_4_2
else
    disp(['ParametersForDimReduceClassify.xlsx�е�3������app���ô���']);
end
