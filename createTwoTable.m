% ������ά��mat���ݺ�һά��gt���ݣ��ú����Զ���������table
% �ֱ�������Classification App����ѵ����������ʹ��ѵ���õķ�����ģ��Ԥ����

function [table1,table2,ind1,ind2] = createTwoTable(x2,lbs,rate) 
% �������ݣ�x, 2ά����ÿһ��Ϊһ��������ÿһ��Ϊһ������
%                 y,��������Ϊxÿ���������������ֵ
%                 rate��������0��1����ָ��ѵ������ռ�İٷֱ�

n = size(x2,1);        % ��������
m = randperm(n);  % ����1��n�����������������
k = round(rate*n);  % ��ȡѵ������������
table1 = createTable(x2(m(1:k),:), lbs(m(1:k)));%ѵ����
ind1 = m(1:k);
table2 = createTable(x2(m(k+1:end),:), lbs(m(k+1:end)));%���Լ�
ind2 = m(k+1:end);
% ����t1��t2��������Classification App����ѵ����������Ԥ����