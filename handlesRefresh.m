
% �ڿؼ���UserData�п��Ա������ݣ�ʾ���������£�
%   sval = hObject.Value;
% 	diffMax = hObject.Max - sval;
% 	data = struct('val',sval,'diffMax',diffMax);
% 	hObject.UserData = data;
function handles = handlesRefresh(handles,x2,currentPath,img,himage,...
    ind,cmap)
%         if ~isempty(handles.UserData)
%             data = handles.UserData;
%         else
%             data = struct(); 
%         end

		data = struct();
		data.matdata = x2;       
        data.dim = numel(size(x2)); % �ж���2ά����3ά����
		data.currentPath = currentPath; 
		data.img = img;
		data.himage = himage;
% 		data.scrollpanelH = hscrollpanel;
        
        if data.dim==3
            data.ind = ind;	
        elseif data.dim==2
            data.cmap = cmap;	
            
            M = numel(unique(x2(:)));
            data.M = M;
            numInClass = zeros(1,M);
            for i = 1:M
                numInClass(i) = numel(find(x2(:)==i));
            end            
            data.numInClass = numInClass;
            
            data.colorLimits=[1,M];              
        end        
		handles.UserData = data;
end