function saveAllFigure(folderName,handles,fmt)
%��������ͼƬ
if 1
    gc = gcf;
    ik = gc.Number;
    for i = ik:-1:2
        figure(i)
%         filename = generateFilename('20200627', handles, ['_',num2str(i),'.fig']);
        filename = generateFilename(folderName, handles, ['_',num2str(i),fmt]);
        saveas(gcf, filename);              
    end
end
if 0
    %����k��ͼƬ
    in = k;
    gc = gcf;
    ik = gc.Number+1-in;
    for i = ik:(ik+in-1)
        figure(i)
        gc = gcf;
        filename = generateFilename('20200627', handles, ['_',num2str(gc.Number),'.fig']);
        saveas(gc, filename);              
    end
end