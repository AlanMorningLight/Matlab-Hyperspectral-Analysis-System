function [hbox, himage] = newPlotFit(img,handles)
%����Ӧ���ڵķ�ʽ��ͼ��img��ʾ����
%����֮����Ҫ���ڣ���Ҫ��figure�е�hscrollpanel��ɾ���������´���������
%������ʾ����������ʾ��img������ͨͼƬ�ĸ�ʽ��
% GTͼ�Ǳ�����ΪͼƬ����img�еģ���Ϊcolorbar������ʾ��λ�ò��ԣ�û�취ֻ�ܽ����ˡ�
    hbox = findobj(handles, 'Tag','hbox');
    
    if ~isempty(findobj(hbox,'Tag','imscrollpanel'))
        delete(findobj(hbox,'Tag','imscrollpanel'));
        axes1 = axes('Parent',hbox,'Tag','axes1');
    elseif ~isempty(findobj(hbox,'Type','axes'))
        axes1 = findobj(hbox,'Type','axes');
    else
        axes1 = axes('Parent',hbox,'Tag','axes1');
    end
%         if strcmp(mark, 'reuse')
%             axes1 = findobj(handles,'Type','axes');
%         elseif strcmp(mark, 'delete')
%             delete(findobj(hbox,'Tag','imscrollpanel'));
%             axes1 = axes('Parent', hbox, ...  
%             'Units', 'Normalized', ...
%             'Position', [0.1,0.1,0.8,0.8], ...
%             'NextPlot', 'Replace', ...
%             'Box', 'Off', 'Visible','off', ...
%             'Tag', 'axes1');
%         else
%             axes1 = axes('Parent', hbox, ...  
%             'Units', 'Normalized', ...
%             'Position', [0.1,0.1,0.8,0.8], ...
%             'NextPlot', 'Replace', ...
%             'Box', 'Off', 'Visible','off', ...
%             'Tag', 'axes1');
%         end
% %         hbox = findobj(handles,'Tag','hbox');
% %         scrollpanel = findobj(hbox,'Tag','scrollpanel');
% %         if isempty(scrollpanel)
% %             scrollpanel = uix.ScrollingPanel( 'Parent', hbox, 'Tag', 'scrollpanel' );
% %         end
%         
% %         axes1 = axes('Parent',scrollpanel);
%         %ActivePositionProperty = 'outerposition';
%         %Outposition = [1.0000    1.0000  330.8333  373.0000];
%         %Position = [44.0300   42.0300  256.3583  303.9950];
%         %
        himage = imshow(img,'Parent',axes1,'InitialMagnification','fit');
%         himage = imshow(img);
% ����ʾ��ͼ��ʱ��ֻ�������д�����ʾ������Ϣʱ����˵��imshow()���ȳ���
% ��ԭʼ��ʽ��ʾͼ����
% ��������д��ڰ��������ģ��Ǿ�˵��imshow()ֱ�������˳�����ԭʼ��С��ʾ
% ͼ��Ĳ��裬���ܵ�ԭ��ο����¶�imshow()�Ĳ���InitialMagnification
% ����ϸ˵����
%-----------------------------------------------------------------------------------%
%  'InitialMagnification' - ͼ����ʾ�ĳ�ʼ�Ŵ���
% 100 ��Ĭ�ϣ� | ��ֵ���� | 'fit'
% �k
% ͼ����ʾ�ĳ�ʼ�Ŵ��ʣ�ָ��Ϊ���ŷָ��Ķ��飬���а��� 'InitialMagnification' ��һ����ֵ
% ������ 'fit'�������Ϊ 100���� imshow �� 100% �Ŵ�������ʾͼ��ÿ��ͼ�����ض�Ӧһ����Ļ
% ���أ��������Ϊ 'fit'���� imshow ��������ͼ�����ʺϴ��ڡ�
% ���ȣ�imshow �᳢����ָ���ķŴ�����ʾ����ͼ������Ŵ���ֵ�ܴ�������ͼ��̫����޷���
% ��Ļ����ʾ���� imshow ���ʺ���Ļ��С�����Ŵ�������ʾ��ͼ��
% ���ͼ����ʾ��ͼ����ʱ�� 'WindowStyle' ������Ϊ 'docked'���� imshow ���ʺ�ͼ����С�����
% �Ŵ�������ʾ��ͼ��
% ע�⣺���ָ����������λ�ã�ʹ�� subplot �� axes������ imshow ������������ָ�����κγ�ʼ��
% ���ʲ�Ĭ������Ϊ 'fit' ��Ϊ��
%-------------------------------------------------------------------------------------%
% 		hscrollpanel = imscrollpanel(hbox, himage); 
%     Ĭ�ϵ�'Tag' �� 'imscrollpanel'
% 
pwidthmax = -1;
set( hbox, 'Widths', [pwidthmax,-5] );
end