function[sol,val]=gabpEval(sol,options)
% �����������ô�󾢣�����Ϊ�˼���val����115�е�ֵ
% ������˵����sol��ǰS������ȡ������ֵ��x��
% Ȼ��x���ݸ�gadecod()�������봦��
% ��ν������Ǵ�x������ȡ��Ԫ�ذѿվ���W1��W2��B1��B2���������裺
% ��xǰS1*R������ΪW1�����ŵ�S2*S1��(����S1*R�����)����ΪW2��
% ���ŵ�S1��(����S1*R+S2*S1�����)����ΪB1��
% ���ŵ�S2��(����S1*R+S2*S1+S1�����)����ΪB2��
%% ����S1��S2������
% A1 = tansig(W1*p+B1);                     %ԭ����A1 = tansig(W1*p,B1); 
% ע�⣺tansig()��˫������s�ʹ��ݺ���������tansig()ֻ��һ���������
% ����ԭ���B1��ȫ��û���õ��ģ�
% 
% A2 = purelin(W2*A1+B2);    %ԭ����A2 = purelin(W2*A1,B2);
%% �������ƽ����
% SE = sumsqr(t-A2);
%% �Ŵ��㷨����Ӧֵ
% val = 1/SE;
%[ pop(i,:), pop(i,xZomeLength)] = gabpEval(pop(i,:),[0 evalOps]);

%Var��һ��struct��������Excel�е�����������Ϣ����ȻҲ����������ṹ��Ϣ
%sumNet��һ��array������������ĸ�����Ԫ����
% for i = 1 : S     % S: 114
%     x(i) = sol(i);
% end;
x = sol(1:end-1);
[W,B,val]=gadecod(x);
end
