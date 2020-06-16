function acc = classDemo(tableTrain, tableTest, type, varargin)

varargin = varargin{1}; %��cellת��Ϊstring����
p = inputParser;

% p.addRequired();
% p.addRequired( 'tableTrain',@(x) validateattributes(x, {'table'}, {'2d', 'ncols','>=',2, ...
%     'nrows','>=',2}, 'classDemo', 'tableTrain',1));
% ����д�����﷨���󣬴���λ����'ncols','>=',2�е�'>='��'>='���ܽ�����'ncols'���棬
% �����������ж�'ncols'�ķ�Χ����ֻ�������ж�x��Ԫ�صķ�Χ
% ���ԣ��﷨����ȷ��д����
% p.addRequired( 'tableTrain',@(x) validateattributes(x, {'table'}, {'2d', 'ncols',11, ...
%     'nrows',20000}, 'classDemo', 'tableTrain',1));
% ����������inputParser���ж�����������к����Ƿ���ڹ涨��ֵ������ôд��
validationFcn = @(x) (ndims(x) == 2) && isa(x,'table') && (size(x,1)>=2) && (size(x,2)>=2); % ������
p.addRequired( 'tableTrain', validationFcn);

% validationFcn = @(x) validateattributes(x, {'table'}, {'2d'}, 'classDemo', 'tableTest',2);%������
% validationFcn = @(x) (size(x,1)>=2) && (size(x,2)>=2); %������
validationFcn = @(x) (ndims(x) == 2) && isa(x,'table') && (size(x,1)>=2) && (size(x,2)>=2); % ������
p.addRequired( 'tableTest', validationFcn);

validStrings = {'BP','RBF','GA-BP','GA-RBF','PSO-BP','PSO-RBF'};

% validStrings = ["BP","RBF","GA-BP","GA-RBF","PSO-BP","PSO-RBF"];
% ����'type' ��ֵ��Ч������������Ч����һ����������Ϊ��ֵ���߼�ֵ��
validationFcn = @(x) any(validatestring(x, validStrings, 'classDemo','type',3)); 

% validationFcn = @(x) validatestring(x,validStrings);
% ����'type' ��ֵ��Ч�����������㺯��: @(x)validatestring(x,validStrings,'classDemo','type',3)��
% p.addRequired('type', @(x) any(validatestring(x, validStrings)));  %�����Ҳ���﷨��ȷ��
p.addRequired('type', validationFcn);  

% p.addRequired( 'type',@(x) any(validatestring(x,{'BP','RBF','GA-BP','GA-RBF','PSO-BP',...
%     'PSO-RBF'}, 'classDemo', 'type',3)));

% p.addOptional();
% p.addParameter();
defaultTrainFcn = 'trainscg';
p.addParameter( 'trainFcn',defaultTrainFcn, @(x) any(validatestring(x,{'trainscg','trainrp','traingdx'})));
defaultHiddenLayerNum = 1;
p.addParameter( 'hiddenLayerNum',defaultHiddenLayerNum,@(x) validateattributes(str2num(x),{'numeric'},...
                                     {'integer','positive','>=',1,'<=',5}));
defaultHiddenNum = 10;
p.addParameter( 'hiddenNum',defaultHiddenNum,@(x) validateattributes(str2num(x),{'numeric'},...
                                     {'integer','positive','>=',10,'<=',100}));

defaultHiddenNum1 = 10;
p.addParameter( 'hiddenNum1',defaultHiddenNum1,@(x) validateattributes(str2num(x),{'numeric'},{'integer','positive'}));
defaultHiddenNum2 = 10;
p.addParameter( 'hiddenNum2',defaultHiddenNum2,@(x) validateattributes(str2num(x),{'numeric'},{'integer','positive'}));
defaultHiddenNum3 = 10;
p.addParameter( 'hiddenNum3',defaultHiddenNum3,@(x) validateattributes(str2num(x),{'numeric'},{'integer','positive'}));
defaultHiddenNum4 = 10;
p.addParameter( 'hiddenNum4',defaultHiddenNum4,@(x) validateattributes(str2num(x),{'numeric'},{'integer','positive'}));

p.addParameter('transferFcn',@(x) any(validatestring(x,{'tansig','radbas','purelin'})));
p.addParameter('transferFcn1',@(x) any(validatestring(x,{'tansig','radbas','purelin'})));
p.addParameter('transferFcn2',@(x) any(validatestring(x,{'tansig','radbas','purelin'})));
p.addParameter('transferFcn3',@(x) any(validatestring(x,{'tansig','radbas','purelin'})));
p.addParameter('transferFcn4',@(x) any(validatestring(x,{'tansig','radbas','purelin'})));

p.addParameter('showWindow',@(x) validateattributes(x,{'logical'}));
p.addParameter('plotperform',@(x) validateattributes(x,{'logical'}));
p.addParameter('plottrainstate',@(x) validateattributes(x,{'logical'}));
p.addParameter('ploterrhist',@(x) validateattributes(x,{'logical'}));
p.addParameter('plotconfusion',@(x) validateattributes(x,{'logical'}));
p.addParameter('plotroc',@(x) validateattributes(x,{'logical'}));

p.parse(tableTrain, tableTest, type, varargin{:});
% %������Ϊvarargin��cell���͵ģ����Ϸ�������ֻ�����ַ������������ַ�����
% p.parse(tableTrain, tableTest, type); % ������

% ������������ϣ��������Ϊһ���ṹ�壬��p.Results��������ʾ��

% p.Results 
% ans =  
%   ���������ֶε� struct:
% 
%     hiddenLayerNum: '1'
%          hiddenNum: '20'
%         hiddenNum1: '20'
%         hiddenNum2: '20'
%         hiddenNum3: '20'
%         hiddenNum4: '20'
%      plotconfusion: 'true'
%        ploterrhist: 'true'
%        plotperform: 'true'
%            plotroc: 'true'
%     plottrainstate: 'true'
%         showWindow: 'true'
%          tableTest: [264499��11 table]
%         tableTrain: [113357��11 table]
%           trainFcn: 'trainscg'
%        transferFcn: 'tansig'
%       transferFcn1: 'tansig'
%       transferFcn2: 'tansig'
%       transferFcn3: 'tansig'
%       transferFcn4: 'tansig'
%               type: 'BP'

% ���Ҹýṹ����ֶ���ͬʱ����������һ����p.Parameters�У�1��N cell���飩

switch p.Results.type
    case 'BP'
        % ���ú���
        % ���в���Ϊ����table���һ��struct
        f_BP(tableTrain, tableTest,)
        acc = [];
    case 'RBF'
    case 'GA-BP'
    case 'GA-RBF'
    case 'PSO-BP'
    case 'PSO-RBF'
    otherwise
end
end

% function acc = f1()
% 
% end