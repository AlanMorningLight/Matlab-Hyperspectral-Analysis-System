function SeparatePlot2_Callback(hObject, eventdata, handles)
% newPlotGT(hObject, handles);
%ֻ�е�ǰͼ������ʾ��ͼƬ�����ǲ�ִ�С�����ɶҲ���ɡ�
if ~isempty(findobj(handles,'Type','image'))   
    img = handles.UserData.img;
    p = figure();
    axes1 = axes('Parent',p,'Tag','axes1');
    if ndims(img) == 3
        himage = imshow(img,'Parent',axes1);
    elseif ndims(img) == 2
        himage = imshow(img,handles.UserData.cmap,'Parent',axes1);
        c = colorbar;
        c.Label.String = '��������Ӧ��ɫ';
        c.Label.FontWeight = 'bold'; 
        
        M = handles.UserData.M;
        
        c.Ticks = 0.5:1:M+0.5;       %�̶���λ��
        c.TicksMode = 'Manual';
        c.TickLabels = num2str([-1:M-1]'); %�̶���ֵ
        c.Limits = [1,M+1];
    end  
    hscrollpanel = imscrollpanel(p, himage); 
end
end