% ����handles��ȡ��matPath��gtPath���������ݺ�ת������Ӧ��ά����
%����άmatתΪ��ά(x3תΪx2)����ά��ǩת��Ϊһά����(lbs2תΪlbs)
function [x3,x2,lbs2,lbs,matInfo,gtInfo] = dataProcess2(handles)
    matPath = handles.UserData.matPath;
    gtPath = handles.UserData.gtPath;
    % ��ȡx3��3ά��ʽ�ĸ߹�������
    load(matPath);
    S = whos('-file',matPath);
    matInfo = S;
    x3 = eval((S.name));
    n_dims = ndims(x3);
    % ��ά����ת��Ϊ��ά����
    if  n_dims == 3
        m = size(x3,1)*size(x3,2);%21025
        n = size(x3,3);
        x2 = reshape(x3,m,n); %��ԭͼ������ֵ����ȡ����ƴ�ӳ�һ����������
                                           %x2��ʶ2ά����
    elseif n_dims == 2
        x2 = x3;    %��ѡ��mat����Ϊ��άmat
        x3 = [];
    end
    
    % ��ȡlbs2��2ά�ı�ǩ����
    load(gtPath);
    S = whos('-file',gtPath);
    gtInfo = S;
    lbs2 = eval((S.name));
    lbs2 = double(lbs2);
    % ��ά��ǩת��Ϊһά��ǩ
    n_dims = ndims(lbs2);
    if n_dims == 1                %��ѡ���ǩ����Ϊһά��ǩ
        lbs = lbs2;
%         while (min(lbs(:))==0)  %ʹlbs��СֵΪ1
%             lbs = lbs+1;
%         end
        lbs2 = [];
    elseif n_dims == 2
        lbs = reshape(lbs2,m,1);%����ǩ����ȡ����ƴ�ӳ�һ��������
                                            %lbs��ʾһά��ǩ
%         while (min(lbs(:))==0)  %ʹlbs��СֵΪ1
%             lbs = lbs+1;
%         end                                            
    elseif n_dims == 3
        lbs = [];
        str = {'��ѡ���ǩ�ļ����������⣬ά��Ϊ3.';'�ɲ鿴hmenu4_1.UserData.lbs2'};
        warndlg(str);
    end
end