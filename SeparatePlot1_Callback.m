function SeparatePlot1_Callback(hObject, eventdata, handles)
% ����������(����Ӧ)��
%ֻ�е�ǰͼ������ʾ��ͼƬ�����ǲ�ִ�С�����ɶҲ���ɡ�
if 0&&~isempty(findobj(handles,'Type','image')) 
    himage = findobj(handles,'Type','image');
    hmenu3_1 = hObject.Parent.Children(4);
    p = figure();
    if isempty(findobj(handles,'Type','colorbar')) && ~hmenu3_1.UserData.imgGT
    %�Ȳ�����colorbar��imgGT�ֲ�����1����˵����ǰ������Ϊ��ͨͼƬ
    %���µ�figure����ԭʼ��С��ʾ��ͨͼƬ
        himage = imshow(himage.CData,'Parent',gca);     
    else
    %���µ�figure����ԭʼ��С��ʾGTͼƬ
        himage = plot1(handles);
    end
end

if 1&&~isempty(findobj(handles,'Type','image'))       
    himage = findobj(handles,'Type','image');
    
    figure()
    if ~isempty(findobj(handles,'Tag','imscrollpanel'))
        if ~isempty(findobj(handles,'Type','colorbar'))
            %���µ�figure����ʾGTͼƬ
            himage = plot1(handles);
        else
            %���µ�figure����ʾ��ͨͼƬ
            himage = imshow(himage.CData);%�������飬�������,'InitialMagnification',200��ͼƬҲ�޷���ʾ��ԭʼ��С
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