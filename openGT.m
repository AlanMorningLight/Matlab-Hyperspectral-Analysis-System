function [hbox, himage] = openGT(x, handles)%��*_gt.mat����

	[hbox, himage] = newPlotGT(x,handles);
    %���ñ�־ֵ
    hmenu3_1 = findobj(handles,'Label','��Ӧ����');
    hmenu3_1.UserData.imgGT=1;
			
end
