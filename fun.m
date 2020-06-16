%% �ӳ���function
% ���ܣ�1.����x��������net��ֵ
%           2. ������Ӧ�ȵ�ֵval
function [val, net] = fun(x, inputNum, hiddenNum, outputNum, net, p_train, t_train)
	%��ȡBP�������ʼȨֵ����ֵ��xΪ����
	% ��x����
    sumNet = [inputNum, hiddenNum, outputNum];
    k = numel(sumNet);
    W = cell(1,k-1);  
    B = cell(1,k-1);
    for i = 1:k-1
        ind = sumNet(i)*sumNet(i+1);
        e1str = ['W{',num2str(i),'}=x(1 : ind);']; %д��cell array����ʽW{1}Ҫ��W1������ʽ����������
        eval(e1str);
        x = x(ind+1:end); %�׵��Ѿ���ȡ�Ĳ���
        ind = sumNet(i+1);
        e1str = ['B{',num2str(i),'}=x(1 : ind);'];
        eval(e1str); 
        x = x(ind+1:end); %�׵��Ѿ���ȡ�Ĳ���        
        net.b{i} = B{i}';
    end
    
   %����Ȩֵ��ֵ
    net.iw{1,1}=reshape(W{1},sumNet(2),sumNet(1));
% net.lw{2,1} = reshape(W{2}, sumNet(3), sumNet(2));
% net.lw{3,2} = reshape(W{3}, sumNet(4), sumNet(3));
    for i = 2:k-1  
        net.lw{i, i-1} = reshape(W{i},sumNet(i+1),sumNet(i));
    end
    
	y=sim(net,p_train);

	% ���ظ���net.performcn��net.performram����ֵ������������ܡ� 
	%perf = perform(net,t,y); t-ѵ�����ݵı�ǩ��y-Ԥ������Ľ��
	%perf = perform(net, t_train, y);
    perf = crossentropy(net, t_train, y);
	val = 1/perf;
end
