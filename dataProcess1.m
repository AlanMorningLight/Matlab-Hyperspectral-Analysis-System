% ����handles��ȡ��matPath��gtPath���������ݺ�ת������Ӧ��ά����
%����άmatתΪ��ά(x3תΪx2)����ά��ǩת��Ϊһά����(lbs2תΪlbs)
function [x2,lbs,matInfo,gtInfo] = dataProcess1(handles)
    matPath = handles.UserData.matPath;
    gtPath = handles.UserData.gtPath;
    % ��ȡx3��3ά��ʽ�ĸ߹�������
    load(matPath);
    S = whos('-file',matPath);
    matInfo = S;
    x3 = eval((S.name));
    if ndims(x3) == 3
        % ��ά����ת��Ϊ��ά����
        m = size(x3,1)*size(x3,2);%21025
        n = size(x3,3);
        x2 = reshape(x3,m,n); %��ԭͼ������ֵ����ȡ����ƴ�ӳ�һ����������
                                           %x2��ʶ2ά����
    else
        x2 = x3;
    end
                                       
    % ��ȡlbs2��2ά�ı�ǩ����
    load(gtPath);
    S = whos('-file',gtPath);
    gtInfo = S;
    n_dims = ndims(lbs2);
    if n_dims == 1
        lbs = lbs2;
    elseif n_dims == 2
        lbs2 = eval((S.name));
        % ��ά��ǩת��Ϊһά��ǩ
        lbs = reshape(lbs2,m,1);%����ǩ����ȡ����ƴ�ӳ�һ��������
                                            %lbs��ʾһά��ǩ
    elseif n_dims == 3
        lbs = [];
    end
end