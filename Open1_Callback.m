function Open1_Callback(hObject, eventdata, handles)
% % ��Ҫ��ʼ��hObject
% l = findobj(handles,'Style', 'listbox');
% 
% hObject.UserData.customPath = l.UserData.customPath;
% hObject.UserData.ind = l.UserData.ind;
% hObject.UserData.matdata = [];
% hObject.UserData.gtdata = [];
% hObject.UserData.cmap = [];
% 
% handles.UserData.customPath = l.UserData.customPath;%handle�������洢���µ���Ϣ��listbox1,
% handles.UserData.ind = l.UserData.ind;
% %Ĭ�ϴ򿪵�ַ����MVC_test.m�����ļ���
% %�Զ���򿪵�ַ��uigetfile��һ����������Ϊ��{'D:\MA��ҵ����\ATrain_Record\20190909\*.mat'}
% %     customPath = {'D:\MA��ҵ����\ATrain_Record\20190909\*.mat'};
    customPath = handles.UserData.customPath;
    [matfilename, matpathname, FilterIndex] = uigetfile(customPath, 'Select a mat file');
    if (~isempty(matfilename) && (FilterIndex==1))
        %ѡ�����ļ������ҵ����ȷ�������ǲŻ�����������ʲôҲ������
        %������״ε������ļ���>>���򿪡�������ɾ��ǰһ��ͼ����Ϊ�����ڣ�
        %������״�֮�󵥻����ļ���>>���򿪡�������ɾ��ǰһ��ͼ�񣬱����ص���

        load([matpathname,matfilename]);
        S = whos('-file',[matpathname,matfilename]);
		x = eval((S.name));
        
        
		if (numel(size(x))==3)&&(size(x,3)>1)&&(size(x,1)>1)&&(size(x,2)>1)
            %�ж���������Ϊ*.mat
            hObject.UserData.currentPath = [matpathname,matfilename];
            handles.UserData.matdata = double(x); % handles�б������µ�ѡ������
            handles.UserData.currentPath = hObject.UserData.currentPath; % handles�б������µ�ѡ������
            %��mat
			[hbox,himage] = openMat(double(x), handles);
            %��ʾѡ���ļ��ĵ�ַ
            text = findobj(handles,'Style','edit');
            text.String = handles.UserData.currentPath;            
% 		elseif (numel(size(x))==2)&&(size(x,1)>1)&&(size(x,2)>1) 
% 			%�ж���������Ϊgroundtruth
%             cmap = [];
% 			openGT(hObject, eventdata, handles, x, cmap, matfilename)%��*_gt.mat����
		else
			%������ʾ���������ݸ�ʽ����
			msg = 'Input data format is wrong!';
			errordlg(msg);
			return
		end
    end
end