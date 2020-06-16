function SeparatePlot1_Callback(hObject, eventdata, handles)
%ֻ�е�ǰͼ������ʾ��ͼƬ�����ǲ�ִ�С�����ɶҲ���ɡ�
if ~isempty(findobj(handles,'Type','image'))       
    img = handles.UserData.img;
    figure
    if ndims(img) == 3
        himage = imshow(img);
    elseif ndims(img) == 2
        himage = imshow(img,handles.UserData.cmap);
        c = colorbar;
        c.Label.String = '��������Ӧ��ɫ';
        c.Label.FontWeight = 'bold'; 
        M = handles.UserData.M;
        
        c.Ticks = 0.5:1:M+0.5;       %�̶���λ��
        c.TicksMode = 'Manual';
        c.TickLabels = num2str([-1:M-1]'); %�̶���ֵ
        c.Limits = [1,M+1];
    end
end
end