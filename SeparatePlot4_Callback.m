function SeparatePlot4_Callback(img1, img2, cmap, M)
%��3�ַ�ʽ��ʵ�ֻ�����ʵ��ǩͼ��Ԥ���ǩͼ

%subplot()��ʽ���Ʋ��ŵ�˫��ͼ
    p = figure();
    axes1 = subplot(1,2,1);
    if ndims(img1) == 3
        himage1 = imshow(img1,'Parent',axes1);
    elseif ndims(img1) == 2
        himage1 = imshow(img1+1,cmap,'Parent',axes1); 
        c = colorbar;
        c.Label.String = '��������Ӧ��ɫ';
        c.Label.FontWeight = 'bold'; 
        
        c.Ticks = 0.5:1:M+0.5;       %�̶���λ��
        c.TicksMode = 'Manual';
        c.TickLabels = num2str([-1:M-1]'); %�̶���ֵ
        c.Limits = [1,M+1];
    end  
%     hscrollpanel = imscrollpanel(p, himage); 
    axes2 = subplot(1,2,2);
    if ndims(img2) == 3
        himage2 = imshow(img2,'Parent',axes2);
    elseif ndims(img2) == 2
        himage2 = imshow(img2+1,cmap,'Parent',axes2); 
        c = colorbar;
        c.Label.String = '��������Ӧ��ɫ';
        c.Label.FontWeight = 'bold'; 
        
        c.Ticks = 0.5:1:M+0.5;       %�̶���λ��
        c.TicksMode = 'Manual';
        c.TickLabels = num2str([-1:M-1]'); %�̶���ֵ
        c.Limits = [1,M+1];
        disp('��ͼ��ɣ�');
    end 
    
    % �ϳ�˫ͼ1��img1��img2�Ⱥϳ�һ��ͼ��Ȼ������ʾ����
    p1 = figure();
    if ndims(img1) == 2 && ndims(img2) == 2
        gap = min(img1(:))*ones(size(img1,1), 5);
        %���������ˮƽ��������
%         img = cat(2,img1, gap, img2);
        img = [img1, gap, img2];
        himage3 = imshow(img+1,cmap); 
        c = colorbar;
        c.Label.String = '��������Ӧ��ɫ';
        c.Label.FontWeight = 'bold'; 
        
        c.Ticks = 0.5:1:M+0.5;       %�̶���λ��
        c.TicksMode = 'Manual';
        c.TickLabels = num2str([-1:M-1]'); %�̶���ֵ
        c.Limits = [1,M+1];  
        hscrollpanel = imscrollpanel(p1, himage3); 
    end
    
    %�ϳ�˫ͼ2�������Ժϳɾ���˫ͼ flip(A,2)��������A��ÿһ�з�ת
    if 1
        p2 = figure();
        img = [img1, gap, flip(img2,2)];
        himage4 = imshow(img+1,cmap); 
        c = colorbar;
        c.Label.String = '��������Ӧ��ɫ';
        c.Label.FontWeight = 'bold'; 
        
        c.Ticks = 0.5:1:M+0.5;       %�̶���λ��
        c.TicksMode = 'Manual';
        c.TickLabels = num2str([-1:M-1]'); %�̶���ֵ
        c.Limits = [1,M+1];  
        hscrollpanel = imscrollpanel(p2, himage4); 
    end
end