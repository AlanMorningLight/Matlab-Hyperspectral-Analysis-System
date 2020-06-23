function [hbox, himage] = newPlotGT(img, handles)
    
   
    if ndims(img)==2
        M = numel(unique(img(:)));
    end
   
    hbox = findobj(handles, 'Tag','hbox');
 
% %     img = hObject.UserData.img;
    if ~isempty(findobj(hbox,'Tag','imscrollpanel'))
        delete(findobj(hbox,'Tag','imscrollpanel'));
        axes1 = axes('Parent',hbox,'Tag','axes1');
    elseif ~isempty(findobj(hbox,'Type','axes'))
        axes1 = findobj(hbox,'Type','axes');
    else
        axes1 = axes('Parent',hbox,'Tag','axes1');
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
    himage = imshow(img+1,cmap,'Parent',axes1);
    hscrollpanel = imscrollpanel(hbox, himage); 
    
% imshow(X,map)���ر�˵��
% X - ����ͼ��
% m��n ��������
% ����ͼ��ָ��Ϊ m��n ��������
% 
% ����� X ָ��Ϊ�����������͵����飬��ֵ 0 ��Ӧ����ɫͼ map �еĵ�һ����ɫ�����ڰ��� c ����ɫ����ɫͼ��ͼ�� X ��ֵ�ᱻ�ü�����Χ [0, c-1] �ڡ�
% 
% ����� X ָ��Ϊ single �� double �������͵����飬��ֵ 1 ��Ӧ����ɫͼ�еĵ�һ����ɫ�����ڰ��� c ����ɫ����ɫͼ��ͼ�� X ��ֵ�ᱻ�ü�����Χ [1, c] �ڡ�
%     

    c = colorbar;
    c.Label.String = '��������Ӧ��ɫ';
    c.Label.FontWeight = 'bold'; 
    
    c.Ticks = 0.5:1:M+0.5;       %�̶���λ��
    c.TicksMode = 'Manual';
    c.TickLabels = num2str([-1:M-1]'); %�̶���ֵ
    c.Limits = [1,M+1];

    
    pwidthmax = -1;
    set( hbox, 'Widths', [pwidthmax,-5] );
    
    handles.UserData.himage = himage;
    handles.UserData.M = M;
    handles.UserData.aPosition = axes1.Position;
    
end