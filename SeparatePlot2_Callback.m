function SeparatePlot2_Callback(hObject, eventdata, handles)
% ����������(ԭʼ��С)��
%ֻ�е�ǰͼ������ʾ��ͼƬ�����ǲ�ִ�С�����ɶҲ���ɡ�
if ~isempty(findobj(handles,'Type','image')) 
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
    hscrollpanel = imscrollpanel(p, himage);  
end    
  

end