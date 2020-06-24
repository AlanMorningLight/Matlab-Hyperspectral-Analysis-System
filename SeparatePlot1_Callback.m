function SeparatePlot1_Callback(hObject, eventdata, handles)
%ֻ�е�ǰͼ������ʾ��ͼƬ�����ǲ�ִ�С�����ɶҲ���ɡ�
if ~isempty(findobj(handles,'Type','image'))       
    himage = findobj(handles,'Type','image');
    
    figure()
    if ~isempty(findobj(handles,'Tag','imscrollpanel'))
        if ~isempty(findobj(handles,'Type','colorbar'))
            %���µ�figure����ʾGTͼƬ
            img = handles.UserData.gtdata;
            %[hbox, himage] = newPlotGT(double(x), handles);
            if ndims(img)==2
                M = numel(unique(img(:)));
            end
            colorMap = handles.UserData.cmap;   

            if isempty(colorMap)
                colorBase = [[1,0,0]; [0,1,0]; [0,0,1]; [1,1,0]; [1,0,1]; [0,1,1]; ...
                                    [0.5,0,0]; [0,0.5,0];[0,0,0.5]; [0.25,0.75,0]; [0.85,0.5,0]; [0.5,0.5,0]; ... 
                                    [0.5,0,1]; [1,0,0.5]; [0.5,0,0.5]; [0.35,0.65,0.75]; [0,1,0.5]; [0,0.5,0.5]; ...
                                    [0.5,0.5,0.5];[0.1,0.1,0.1]];
                bkcGT = handles.UserData.bkcGT; %GTͼ�ϵı�����ɫ        
                colorMap = [bkcGT;colorBase];   %��ӱ������ص���ɫ
                cmap = colormap(colorMap);
                handles.UserData.cmap = cmap;
            end
    %     cmap = colormap(colorMap(1:M,:));
            cmap = colormap(colorMap);
            himage = imshow(img+1,cmap);        

            c = colorbar;
            c.Label.String = '��������Ӧ��ɫ';
            c.Label.FontWeight = 'bold'; 

            c.Ticks = 0.5:1:M+0.5;       %�̶���λ��
            c.TicksMode = 'Manual';
            c.TickLabels = num2str([-1:M-1]'); %�̶���ֵ
            c.Limits = [1,M+1];        
        else
            %���µ�figure����ʾ��ͨͼƬ
            himage = imshow(himage.CData);
        end
    else %��������ͼ����û�й�����
        hmenu3_1 = hObject.Parent.Children(4);%Ҳ��[��Ӧ����]
        if ~hmenu3_1.UserData.imgGT     %��ѯ����Ӧ���ڡ������Ķ�������ͨͼ����GTͼ
        %  ��ʾ��ͨͼƬ
            himage = imshow(himage.CData);
        else
            %��ʾGTͼƬ
            img = handles.UserData.gtdata;
            %[hbox, himage] = newPlotGT(double(x), handles);
            if ndims(img)==2
                M = numel(unique(img(:)));
            end
            colorMap = handles.UserData.cmap;   

            if isempty(colorMap)
                colorBase = [[1,0,0]; [0,1,0]; [0,0,1]; [1,1,0]; [1,0,1]; [0,1,1]; ...
                                    [0.5,0,0]; [0,0.5,0];[0,0,0.5]; [0.25,0.75,0]; [0.85,0.5,0]; [0.5,0.5,0]; ... 
                                    [0.5,0,1]; [1,0,0.5]; [0.5,0,0.5]; [0.35,0.65,0.75]; [0,1,0.5]; [0,0.5,0.5]; ...
                                    [0.5,0.5,0.5];[0.1,0.1,0.1]];
                bkcGT = handles.UserData.bkcGT; %GTͼ�ϵı�����ɫ        
                colorMap = [bkcGT;colorBase];   %��ӱ������ص���ɫ
                cmap = colormap(colorMap);
                handles.UserData.cmap = cmap;
            end
    %     cmap = colormap(colorMap(1:M,:));
            cmap = colormap(colorMap);
            himage = imshow(img+1,cmap);        

            c = colorbar;
            c.Label.String = '��������Ӧ��ɫ';
            c.Label.FontWeight = 'bold'; 

            c.Ticks = 0.5:1:M+0.5;       %�̶���λ��
            c.TicksMode = 'Manual';
            c.TickLabels = num2str([-1:M-1]'); %�̶���ֵ
            c.Limits = [1,M+1];        

        end
    end   
end
end