%% �ӳ���function
function [val, net] = fun(x, inputNum, hiddenNum, outputNum, net, p_train, t_train)
	%��ȡBP�������ʼȨֵ����ֵ��xΪ����
	% ��x����
    sumNet = [inputNum, hiddenNum, outputNum];
    k = numel(sumNet);

    for i = 1:k-1
        ind = sumNet(i)*sumNet(i+1);
        e1str = ['W',num2str(i),'=x(1 : ind);'];
        eval(e1str);
        x = x(ind+1:end); %�׵��Ѿ���ȡ�Ĳ���
        ind = sumNet(i+1);
        e1str = ['B',num2str(i),'=x(1 : ind);'];
        eval(e1str); 
        x = x(ind+1:end); %�׵��Ѿ���ȡ�Ĳ���,ԭ��������һ��        
        e1str = ['net.b{',num2str(i),'} = reshape(B',num2str(i),',sumNet(',num2str(i+1),'),1);'];
        eval(e1str);

    end
    
   %����Ȩֵ��ֵ
    net.iw{1,1}=reshape(W1,sumNet(2),sumNet(1));
    sumNet = sumNet(2:end);
    k = numel(sumNet);
    for i = 1:k-1  
        e1str = ['net.lw{',num2str(i+1),',',num2str(i),'} = reshape(W',num2str(i+1),',sumNet(',num2str(i+1),'),sumNet(',num2str(i),'));'];	
        eval(e1str);
    end
    
	y=sim(net,p_train);

	% ���ظ���net.performcn��net.performram����ֵ������������ܡ� 
	%perf = perform(net,t,y); t-ѵ�����ݵı�ǩ��y-Ԥ������Ľ��
	%perf = perform(net, t_train, y);
    perf = crossentropy(net, t_train, y);
	val = 1/perf;
end
