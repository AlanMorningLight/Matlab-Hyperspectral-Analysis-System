function [hbox, himage] = openMatInContent(hObject, handles)
 % hObjectΪlistbox1   

        load(hObject.UserData.currentPath);
        S = whos('-file',hObject.UserData.currentPath);
		x = eval((S.name));

        n_dims = ndims(x);
        if (n_dims==3)&&(size(x,3)>1)&&(size(x,1)>1)&&(size(x,2)>1)
			%�ж���������Ϊ*.mat
            %��mat
%             hObject.UserData.matdata = x;
            handles.UserData.matdata = double(x);
			[hbox, himage] = openMat(double(x), handles);
            
            %���ñ�־ֵ
            hmenu3_1 = findobj(handles,'Label','��Ӧ����');
            hmenu3_1.UserData.imgGT=0;

            %��ʾѡ���ļ��ĵ�ַ
            text = findobj(handles,'Style','edit');
            text.String = handles.UserData.currentPath;            
% 		elseif (numel(size(x))==2)&&(size(x,1)>1)&&(size(x,2)>1) 
% 			%�ж���������Ϊgroundtruth
%             cmap = [];
% 			openGT(hObject, eventdata, handles, x, cmap, matfilename)%��*_gt.mat����
        elseif (n_dims==2)&&(size(x,1)>1)&&(size(x,2)>1)
            hbox = findobj(handles,'Tag','hbox');
            %��һ��������lbs2���ǽ�ά���mat
            p = size(x,1)/size(x,2);
            if p>50 || p<0.02
                %�ж�����Ϊ��ά�������
                if p>50
                    mappedA = x;
                else
                    mappedA = x';
                end
                hmenu4_3 = findobj(handles,'Label','ִ�н�ά');
                if isfield(hmenu4_3.UserData, 'matData') && isempty(hmenu4_3.UserData.matData)
                    hmenu4_3.UserData.drData = mappedA; % hmenu4_3
                    hmenu4_3.UserData.matPath = hObject.UserData.currentPath;
                    hmenu4_3.UserData.matData = mappedA; % hmenu4_3
                end
                    str1 = {'��ѡ��Ϊ��ά��Ķ�άmat���ݣ��Ѿ�������hmenu4_3.UserData.drData';...
                    '����������ִ�з�������������ѡ��һ�����mat����ƥ���ground truth��ǩ�ļ�';...
                    '�ٶ���ѡmat���ݵ�������Ϊ[abc***.mat]�����ǩ�ļ�������ͨ��Ϊ[abc_gt.mat]'};
                    str2 = {'mat������gt�������뱸������ִ�С�������>>��ִ�з��ࡿ'};
                if ~isfield(hmenu4_3.UserData, 'gtData') || isempty(hmenu4_3.UserData.gtData)
                    msg = str1;
                else
                    msg = str2;
                    hmenu4_4 = findobj(handles,'Label','ִ�з���');
                    hmenu4_4.Enable = 'on';
                    hmenu4_5 = findobj(handles,'Label','����ѡ���㷨');
                    hmenu4_5.Enable = 'on';
                    hmenu4_6 = findobj(handles,'Label','�����㷨');
                    hmenu4_6.Enable = 'on';
                end
                msgbox(msg);
%                 hmenu4_3.UserData.drAlgorithm = 'none'; % hmenu4                
            else
                %�ж���������Ϊ*_gt.mat
                %��mat
%                 cmap = [];
%                 hObject.UserData.cmap = cmap;
%                 hObject.UserData.gtdata=x;
                handles.UserData.gtdata = double(x);
                
                [hbox, himage] = newPlotGT(double(x), handles);
                
                text = findobj(handles,'Style','edit');
                text.String = handles.UserData.currentPath; 
            end
        elseif n_dims == 1 %�ж��Ƿ�Ϊһά�ı�ǩ����lbs
            a = unique(x);      %�ҳ�x�е�Ψһֵ�����Ұ�����������
            b = a(2:end)-a(1:end-1);
            if (a(1)==0 || a(1)==1) && unique(b)==1
                %��һ��Ԫ��Ϊ0����1
                %����Ԫ�صĲ�ֵΪ1
                str = {'��ѡ��Ϊһάground truth��ǩ���ݣ��Ѿ�������hmenu4_3.UserData.lbs';...
                    '����������ִ�з�������������ѡ��һ����ñ�ǩ����ƥ���mat�����ļ�';...
                    '�ٶ���ѡgt���ݵ�������Ϊ[*_gt.mat]����ѡ�ļ�������ͨ��Ϊ*.mat'};
                msgbox(str);
            end

        else
			%������ʾ���������ݸ�ʽ����
			msg = 'Input data format is wrong!';
			errordlg(msg);
			return
        end        
end
   
