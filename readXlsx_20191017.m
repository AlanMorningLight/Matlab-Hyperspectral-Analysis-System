%% ������ӱ���е�����
% ���ڴ����µ��ӱ�������ݵĽű�:
%
%    ������: D:\MA��ҵ����\ATrain_Record\20191002\��ά����ͳ��.xlsx
%    ������: Sheet1
%
% �� MATLAB �� 2019-10-17 03:26:19 �Զ�����

%% ���õ���ѡ���������
opts = spreadsheetImportOptions("NumVariables", 15);

% ָ��������ͷ�Χ
opts.Sheet = "Sheet1";
opts.DataRange = "A2:O35";

% ָ�������ƺ�����
opts.VariableNames = ["VarName1", "no_dims", "max_iterations", "sigma", "k", "eig_impl", "finetune", "t", "kernel", "perplexity", "initial_dims", "type", "lambda", "no_analyzers", "percentage"];
opts.VariableTypes = ["string", "double", "double", "double", "double", "categorical", "string", "double", "string", "double", "double", "string", "double", "double", "double"];

% ָ����������
opts = setvaropts(opts, ["VarName1", "finetune", "kernel", "type"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["VarName1", "eig_impl", "finetune", "kernel", "type"], "EmptyFieldRule", "auto");

% ��������
paraTable_dr = readtable("D:\MA��ҵ����\ATrain_Record\20191002\��ά����ͳ��.xlsx", opts, "UseExcel", false);


%% �����ʱ����
clear opts