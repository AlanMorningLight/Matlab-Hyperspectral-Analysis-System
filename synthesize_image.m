function img = synthesize_image(x3,ind)
%1. ͨ�����պ���������ֵ��img
    ind = sort(ind, 'descend'); 
    img = double(x3(:,:,ind));
%2. ��ȡ����3��ͨ�����ֲ���һ��
    xmin = min(img(:));
    xmax = max(img(:));
    % y = (ymax-ymin)*(x-xmin)/(xmax-xmin) + ymin;
    img = (1-0)*(img-xmin)/(xmax-xmin)+0; %�ֲ���һ��
%3. ��3�������ֱ���ֱ��ͼ���⻯������Ϊhisteq��Ҫ�Ƕ�ǿ��ͼ��������
    img(:,:,1) = histeq(img(:,:,1));
    img(:,:,2) = histeq(img(:,:,2));
    img(:,:,3) = histeq(img(:,:,3)); 
end
