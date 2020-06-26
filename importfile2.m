function paraTable_dr = importfile2(workbookFile, sheetName, dataLines)
%IMPORTFILE1 ������ӱ���е�����
%  UNTITLED = IMPORTFILE1(FILE) ��ȡ��Ϊ FILE �� Microsoft Excel
%  ���ӱ���ļ��ĵ�һ�Ź������е����ݡ�  �Ա���ʽ�������ݡ�
%
%  UNTITLED = IMPORTFILE1(FILE, SHEET) ��ָ���Ĺ������ж�ȡ��
%
%  UNTITLED = IMPORTFILE1(FILE, SHEET,
%  DATALINES)��ָ�����м����ȡָ���������е����ݡ����ڲ��������м�����뽫 DATALINES ָ��Ϊ������������ N��2
%  �������������顣
%
%  ʾ��:
%  Untitled = importfile1("D:\MA��ҵ����\ATrain_Record\20191002\��ά����ͳ��.xlsx", "Sheet1", [2, 35]);
%
%  ������� READTABLE��
%
% �� MATLAB �� 2019-10-17 03:36:47 �Զ�����

%% ���봦��

% ���δָ���������򽫶�ȡ��һ�Ź�����
if nargin == 1 || isempty(sheetName)
    sheetName = 1;
end

% ���δָ���е������յ㣬��ᶨ��Ĭ��ֵ��
if nargin <= 2
    dataLines = [2, 7];
end

%% ���õ���ѡ���������
%opts1 = detectImportOptions(workbookFile,'sheet',sheetName);
opts = spreadsheetImportOptions("NumVariables", 22);

% ָ��������ͷ�Χ
opts.Sheet = sheetName;
%opts.RowNamesRange = "A" + dataLines(1, 1) + ":A" + dataLines(1, 2);
opts.RowNamesRange = "A2";
opts.DataRange = "B" + dataLines(1, 1) + ":W" + dataLines(1, 2);


% ָ�������ƺ�����
opts.VariableNames = ["dimReduce", "rate","app" ,"executionTimes" "trainFcn","hiddenNum","transferFcn","showWindow",...
"plotperform", "plottrainstate", "ploterrhist", "plotconfusion", "plotroc", "hiddenLayerNum"...
	"hiddenNum1","transferFcn1","hiddenNum2","transferFcn2","hiddenNum3", ...
    "transferFcn3","hiddenNum4","transferFcn4"];

opts.VariableTypes = ["logical",   "double","double","double",           "string",  "double",         "string",        "logical",...
"logical",        "logical",            "logical",       "logical",            "logical",  "double", ...
	"double",         "string",           "double",         "string",          "double", ...
    "string",          "double",           "string"];

% ָ���ļ�������
opts.ImportErrorRule = 'omitvar';
opts.MissingRule = 'omitvar';

% ��������

paraTable_dr = readtable(workbookFile, opts, 'ReadRowNames',true, "UseExcel", false);

end