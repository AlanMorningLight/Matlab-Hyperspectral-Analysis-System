function SeparatePlot3_Callback(img,cmap,M)

    p = figure();
    axes1 = axes('Parent',p,'Tag','axes1');
    if ndims(img) == 3
        himage = imshow(img,'Parent',axes1);
    elseif ndims(img) == 2
%         img = ind2rgb(img+1,cmap);
%         himage = imshow(img,'Parent',axes1);  %img��double����ֵ1��Ӧ��cmap��һ����ɫ��img������ֵ����ֵ0��Ӧ��cmap��һ����ɫ
%         colormap(axes1,cmap);
        himage = imshow(img+1,cmap,'Parent',axes1); 
        c = colorbar;
        c.Label.String = '��������Ӧ��ɫ';
        c.Label.FontWeight = 'bold'; 
        
        c.Ticks = 0.5:1:M+0.5;       %�̶���λ��
        c.TicksMode = 'Manual';
        c.TickLabels = num2str([-1:M-1]'); %�̶���ֵ
        c.Limits = [1,M+1];
    end  
    hscrollpanel = imscrollpanel(p, himage); 

end