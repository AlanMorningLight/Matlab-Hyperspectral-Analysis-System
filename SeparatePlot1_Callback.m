function SeparatePlot1_Callback(hObject, eventdata, handles)
%ֻ�е�ǰͼ������ʾ��ͼƬ�����ǲ�ִ�С�����ɶҲ���ɡ�
if ~isempty(findobj(handles,'Type','image'))       
    himage = findobj(handles,'Type','image');
    
    figure()
    if ~isempty(findobj(handles,'Tag','imscrollpanel'))
        if ~isempty(findobj(handles,'Type','colorbar'))
            %���µ�figure����ʾGTͼƬ
            himage = plot1(handles);
        else
            %���µ�figure����ʾ��ͨͼƬ
            himage = imshow(himage.CData);
        end
    else %��������ͼ����û�й�����
        hmenu3_1 = hObject.Parent.Children(4);%Ҳ��[��Ӧ����]
        if ~hmenu3_1.UserData.imgGT     %��ѯ����Ӧ���ڡ������Ķ�������ͨͼ����GTͼ
        %  ���µ�figure����ʾ��ͨͼƬ
            himage = imshow(himage.CData);
        else
            %���µ�figure����ʾGTͼƬ
            himage = plot1(handles);
        end
    end   
end
end