function closeFigure(varargin)%����Figure�ı�ţ��ر�ָ����Figure���������������
if ~isempty(varargin)
    n = numel(varargin{1});
    for i = 1:n
        close(figure(varargin{1}(i)));
    end
end
end