function table_data = createTable(x,y)
% �������ݣ�x, 2ά����ÿһ��Ϊһ��������ÿһ��Ϊһ������
%                 y,��������Ϊxÿ���������������ֵ
%% ׼��ѵ�����ݱ�table1
		% Ϊÿ���۲�����n���������ɱ�����
	n = size(x, 2);
	VarNames = cell(1, n);
	for j = 1 : n
		% ���������Ч�����Ƿ��ʷ�ʽ��һ��    
% 		VarNames(j) = {['Input_all',num2str(j)]};  % ����cell array���еĵ�i��cell������������1��1 cell��
		VarNames{j} = ['Input_all',num2str(j)];% ����cell array���еĵ�i��cell������(����������1��10 char)
	end
		%VarNames(i)��1��1 cell
		%VarNames{i}��1��10 char
	table_data = array2table(x); %����ת��Ϊ��
	table_data.Properties.VariableNames = VarNames;%������������VariableNames
		% Ϊtable�������һ��
	table_data.Class = categorical(y);
		% table.Class = (y); �������ֵ�͵�yֱ�Ӹ�ֵ��table.Class��
        % ����Classification Learner�е�������ʱ������ʾ��
		% Response variable is numeric. Distinct values will be interpreted as class labels
end      