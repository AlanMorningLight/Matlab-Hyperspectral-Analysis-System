function [hbox, himage] = openMat(x3,handles)
%��*.mat����

% 	x3 = hObject.UserData.matdata; %�����ݼ��ڵı�����ͳһΪx2; %���������˲����ڵ��ֶ�mat
		%% ���Ʋ�ɫͼ
	% �õ�3��ͨ�����
    ind = handles.UserData.ind;    %���������˲����ڵ��ֶ�ind
	% �ϳ���ǿͼ�� 
	img = synthesize_image(x3, ind);   
    handles.UserData.imgMat = img;

    [hbox, himage] = newPlot(img, handles);

end