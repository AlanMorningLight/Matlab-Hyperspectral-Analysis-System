function h = reNewContent(hObject,handles,axes1)
% ���Ŀ¼�е�ĳһ�����������������Ŀ�Ѿ�չ����������
% �⽫������ȫ�����¼�����Ŀ�������ж��ٸ��㼶��
% �������Ŀδչ������չ����һ��Ŀ¼��

hObject.UserData.stringOld = hObject.UserData.stringNew;
hObject.UserData.levelOld = hObject.UserData.levelNew;
hObject.UserData.valueOld = hObject.UserData.valueNew;
hObject.UserData.isFolderOld = hObject.UserData.isFolderNew;

    val = hObject.Value;        %��ǰ��listbox�е������Ŀ��ţ��кţ�
    string = hObject.String;    %��ǰlistbox����ʾ������
    input_level = hObject.UserData.levelOld;%��ǰlistbox����ʾ�ļ���/�ļ�������ȼ���1��ʾ��߼�
    isFolder = hObject.UserData.isFolderOld; %��ǰlistbox����ʾ�������Ƿ����ļ���

    selectedPath = hObject.UserData.selectedPath; %����·������ѡ����ļ���
    
    %�������ļ�����ʱ��isFolder(val)==1��������ļ�����һ�����ļ��У���Ȼ��1
    %���ֱ�ӵ����ļ��ϣ���Ȳ�ִ��չ��Ҳ��ִ�����𡣴�ʱisFolder(val)==0
if isFolder(val) %    
    if val<numel(input_level) && input_level(val)<input_level(val+1)
        %val<numel(input_level)˵�����еĲ������һ������(val+1)���ᳬinput_level�ı߽�
        %input_level(val)<input_level(val+1)��˵����ѡ�����»������Ѿ�չ��������Ŀ
    % ��ִ��������Ŀ¼����
        %�����ɵ�ǰ·��
        %1.ƴ��·��
        current_path = string{val}(input_level(val)*2+1:end);
        currentLevel = input_level(val);
        count = 0;
        if val > 1 
            for k = val-1 : -1 :1      %����Ѱ�Ұ�����ǰ�ļ��еĸ���һ�����ļ�������
                %�㼶��input_level(val)-1 : 1
                if input_level(k) == 1
                    count = count + 1;%�������ȼ�Ϊ1����˵���Ѿ���������ļ���
                end
                if count == 2
                    break
                end
                if (input_level(k)<currentLevel)  %����Ѱ�ҹ����У�������ȼ�С�ڵ�ǰѡ�е��ļ��е�����ȼ���
                                                                %��˵���ҵ����ļ���Ϊ�����ļ��У������Ҫ�����ļ�������ƴ�ӵ�
                                                                %current_path��ǰ��
                    current_path = fullfile(string{k}(input_level(k)*2+1:end), current_path);
                    currentLevel = input_level(k);  %��ַƴ����ɺ��µ�ַ������ȼ�Ҳ���£���Ѱ�Ҹ��ߵȼ����ļ���������ƴ��
                else
                    continue
                end               
            end
        end
        
% %��ƴ�ӵ�ַǰ��������selectedPath������������ַ
        currentPath = fullfile(selectedPath, current_path);
        %��ͳ�Ƹ���Ŀ���ж�����չ��������Ŀ�������val��ʼ��ֵ��1,2,3,4,3,4,5,2,1
        %ֻҪ�������һ�����Ͳ�����������������
        try
            i = 1;
            while(input_level(val)<input_level(val+i))
                i = i+1;
            end
            % ��������ԭʼ�ǣ��������������һ���ļ����Ҹ��ļ�����������չ��������
            % ��input_level(val+i)���������������߽�Ĵ���
        catch
            n = numel(input_level);
            i = 1;
            while(input_level(val)<input_level(n+1-i))
                i = i+1;
            end
        end
        N2 = i-1;
        N1 = numel(string);
        
        N = N1- N2;
        string1 = cell(N,1);
        
        % ����string
        for i = 1 : val
        string1{i} = string{i};
        end
        for i = 1 : N-val
            string1{i+val} = string{val+N2+i};
        end
        string = string1;
        
        % ����level
        level = zeros(N,1);
        level(1 : val) = input_level(1 : val);
        level(val+1 : N) = input_level(val+N2+1 : N1);
        % ����isFolder
        oldContent = hObject.UserData.isFolderOld;
        is_folder = false(N,1);
        is_folder(1 : val) = oldContent(1 : val);
        is_folder(val+1 : N) = oldContent(val+N2+1 : N1);
    else 
        
    % ��ִ��չ����Ŀ¼����  
        
        %��ȡ��һ����Ŀ¼
%��ǰ������ļ���������current_path
        current_path = string{val}(input_level(val)*2+1:end);
        currentLevel = input_level(val);
        count = 0;
        if val > 1 
            for k = val-1 : -1 :1      %����Ѱ�Ұ�����ǰ�ļ��еĸ���һ�����ļ�������
                %�㼶��input_level(val)-1 : 1
                if input_level(k) == 1
                    count = count + 1;%�������ȼ�Ϊ1����˵���Ѿ���������ļ���
                end
                if count == 2
                    break
                end
                if (input_level(k)<currentLevel)  %����Ѱ�ҹ����У�������ȼ�С�ڵ�ǰѡ�е��ļ��е�����ȼ���
                                                                %��˵���ҵ����ļ���Ϊ�����ļ��У������Ҫ�����ļ�������ƴ�ӵ�
                                                                %current_path��ǰ��
                    current_path = fullfile(string{k}(input_level(k)*2+1:end), current_path);
                    currentLevel = input_level(k);  %��ַƴ����ɺ��µ�ַ������ȼ�Ҳ���£���Ѱ�Ҹ��ߵȼ����ļ���������ƴ��
                else
                    continue
                end               
            end
        end
        
% %��ƴ�ӵ�ַǰ��������selectedPath������������ַ
        currentPath = fullfile(selectedPath, current_path);
        a=dir(currentPath);
        %�����Ƿ�Ϊ���ļ��з�Ϊ�������
        if ~isempty(a)
            contentname={a.name}';
            n = numel(contentname);%�ų���$��ͷ���ļ������ų�.��..
            %��ͳ����$��ͷ���ļ�������
            try
                count = 0;
                k = 1;
                while strcmp(contentname{k}(1),'$')
                    count = count + 1;
                    k = k+1;
                end   
                contentname=contentname(count+3:end);
                isFolder=[a.isdir]';
                isFolder=isFolder(count+3:end);
            catch
            end
            % Ŀ¼�ַ�����
            % �����µ�level
            % ����level
            N1 = numel(string);           %��Ŀ¼�е���Ŀ����
            N2 = numel(contentname);%��Ŀ¼�е��ļ���/�ļ���������
            N = N1 + N2;

            level = zeros(N,1);
            level(1 : val) = input_level(1 : val);
            level(val+1 : val+N2) = input_level(val)+1; 
            level(val+N2+1 : N) = input_level(val+1 : N1);
            % ����isFolder
            oldContent = hObject.UserData.isFolderOld;
            is_folder = false(N,1);
            is_folder(1 : val) = oldContent(1 : val);
            is_folder(val+1 : val+N2) = isFolder; 
            is_folder(val+N2+1 : N) = oldContent(val+1 : N1);

            str = changeToContent(isFolder, contentname, level);

            % ����string
            string1 = cell(N,1); 

            for i = 1 : val
                string1{i} = string{i};
            end

            for i = 1 : N2    % ����ո�
                string1{i+val} = [repmat(char(32),1,input_level(val)*2),str{i}];
            end

            for i = 1 : N1-val
                string1{val+N2+i} = string{val+i};
            end
            string = string1;
            t = hObject.ListboxTop;
            rowWidth = 352.9692/25;   %listboxÿһ���ڸ߶�����ռ������ֵ
            n1 = hObject.Position(4)/rowWidth;%listbox��ʾ���������ʾ������
            if n1<=N2+1 %��listbox��ʾ����С�ڽ�Ҫչ������Ŀ¼������ 
                hObject.ListboxTop = val;
            elseif n1<N-1  %��listbox��ʾ���ڲ�����ʾ��չ��֮���������
                hObject.ListboxTop = t+N2;
            end    
    %         elseif isa(isFolder,'logical') % isFolder, 0��1 logical
    %             disp('���ļ��У�');
    %         else

    %             % ����Ѿ�ѡ���ˣ�������ѡ��״̬���ٴε����
    %             % �����ļ��ĸ�ʽ��ʹ����Ӧ�ķ�ʽ��ʾ��
    %             %*.jpg, *.bmp, *.gif, *.fig, *.mat
    %              

    %             
    %         end
        end
    
    end
else
%% �����Ŀ¼��Ϊ���ڲ��ļ������ȡ���ļ�������·������
        %��ȡ��һ����Ŀ¼
%     currentPath = [handles.UserData.customPath];
    currentFileName = string{val}(input_level(val)*2+1-2:end);
    currentLevel = input_level(val);
    count = 0;
    if val > 1 
        for k = val-1 : -1 :1
            %�㼶��input_level(val)-1 : 1
            if input_level(k) == 1
                count = count + 1;
            end
            if count == 2
                break
            end
            if (input_level(k)<currentLevel)
                currentFileName = fullfile(string{k}(input_level(k)*2+1:end), currentFileName);
                currentLevel = input_level(k);
            else
                continue
            end               
        end
    end
        
        currentPath = fullfile(selectedPath, currentFileName);
        hObject.UserData.currentPath = currentPath;

    if (hObject.UserData.valueOld ~= val)
        disp('ѡ���ļ���');
    else
        disp('���ļ���');
        openFileInContent(hObject,handles);
        h = hObject;
        return 
    end    
end


    hObject.UserData.valueNew = val;
    hObject.Value = val;
    
try %���������Ϊ���ڲ��ļ�ʱ��ֱ��������157��ִ�У�
    % ��ʱ������level��is_folder����������ᱨ��
    % ���Է���try����   
    hObject.UserData.levelNew = level;
    hObject.UserData.isFolderNew = is_folder;
    % ��ʱhObject.UserData.stringNew == string
    hObject.UserData.stringNew = string;
    % ��ʱhObject.String == string;
    hObject.String = string;

catch
    
end
h = hObject;
end