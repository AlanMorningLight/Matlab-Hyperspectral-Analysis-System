function [W,B,val] = gadecod(x)
global Var sumNet sumTransferFcn 
%Var��һ��struct��������Excel�е�����������Ϣ����ȻҲ����������ṹ��Ϣ
%sumNet��һ��array������������ĸ�����Ԫ����
%sumTransferFcn��һ���ַ���cell array���������������Ĵ��ݺ���


%% II. ����ȫ�ֱ���
global p     % ѵ������������
global t     % ѵ�����������
global inputNum     % ������Ԫ����
global outputNum    % �����Ԫ����
global S1    % ����1��Ԫ����(������1������)
global S2    % ����2��Ԫ����
global S3    % ����3��Ԫ����
global S4    % ����4��Ԫ����
global S5    % ����5��Ԫ����
% ǰinputNum*S1������ΪW1

% ����Var.hiddenLayerNum����ֵ��ȷ���м�������
n = Var.hiddenLayerNum;
endIndex1 = [1,sumNet].*[sumNet,1];
endIndex = endIndex1(2:end-1); %[200,400,340]
cutIndex = endIndex+1;              %[201,401,341]
% W1 = x(1:endIndex(1));
% W2 = x(endIndex(1)+1:endIndex(2));
% W3 = x(endIndex(2)+1:endIndex(3));
% xÿ�θ�W��ֵ֮��ͻᱻ�ض�

%��xת��Ϊһ��
x = x';
    %�� Wk = x(1:endIndex(k));
    W = cell(1,n+1); %W���ڷ���ȫ����Ȩ�ؾ���
for k = 1:n+1
    estr = ['W{',num2str(k),'} = x(1 : endIndex(',num2str(k),'));']; %��ȡһ�����ȵ���ֵ
    eval(estr);
    %Wk = reshape(Wk,sumNet(k),sumNet(k+1))';                   %��һ����ֵ����Ϊ2ά����
    estr = ['W{',num2str(k),'} = transpose(reshape(W{',num2str(k),'}, sumNet(',num2str(k),'), sumNet(',num2str(k+1),')));'];
    eval(estr);
    x = x(cutIndex(k):end);   %�ض�x
end

endIndex = sumNet(2:end);
cutIndex = endIndex+1;
    B = cell(1,n+1); %B���ڷ���ȫ����ƫ������
for k = 1:n+1
    estr = ['B{',num2str(k),'} = x(1 : endIndex(',num2str(k),'));'];
    eval(estr);    
    x = x(cutIndex(k):end);   %�ض�x
end

%% W1 = x(1:inputNum*S1);
% for i = 1 : S1
%     for k = 1 : inputNum
%         W1(i,k) = x(inputNum*(i-1)+k);
%     end
% end
% ���ŵ�S1*S2������(����inputNum*S1����ı���)ΪW2
%% W2 = x(inputNum*S1+1 : inputNum*S1+S1*S2);
% for i = 1 : S2
%     for k = 1 : S1
%         W2(i,k) = x(S1*(i-1)+k+inputNum*S1);
%     end
% end
% ���ŵ�S1������(����inputNum*S1+S1*S2����ı���)ΪB1
%% B1 = x(inputNum*S1+S1*S2+1 : inputNum*S1+S1*S2+S1);
% for i = 1 : S1
%     B1(i,1) = x((inputNum*S1+S1*S2)+i);
% end
% ���ŵ�S2������(����inputNum*S1+S1*S2+S1����ı���)ΪB2
%% B2 = x(inputNum*S1+S1*S2+S1+1 : inputNum*S1+S1*S2+S1+S2)
% for i = 1 : S2
%     B2(i,1) = x((inputNum*S1+S1*S2+S1)+i);
% end

%% ����S1��S2������
% A1 = tansig(W1*p+B1);    % A1����[-1,1]֮��
% A2 = purelin(W2*A1+B2); % A2
% ��ȡ�������в�Ĵ��ݺ���

A = p;
for k = 1:n+1
    estr1 = ['A','=',sumTransferFcn{k},'(W{',num2str(k),'}*A+B{',num2str(k),'});'];
    eval(estr1);
    estr2 = ['C{',num2str(k),'}= A;',];%C���ڱ�������ÿһ��ļ�������
    eval(estr2);                                %��C{1}���������A1��C{2}���������A2���Դ�����
end



%% �������ƽ����
% SE = sumsqr(t-A2);
% SE = sumsqr(t-softmax(A));
A = softmax(A);
% A4 = vec2ind(A3);
% A5 = ind2vec(A4);
cross = -t.*log(A)+(1-t).*log(1-A);
SE = sum(cross(:));
% �Ŵ��㷨����Ӧֵ
val = 1/SE;
end