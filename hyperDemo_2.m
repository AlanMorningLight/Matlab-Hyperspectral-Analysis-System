%%hyperDemo.m�ĸ����
% ֱ������ԭ��߹���ԭʼ���ݶ�ȡ����
% ʹ��Cuprite.mat�����滻ԭ��Ķ��������

% function hyperDemo_1(hObject, handles)
function hyperDemo_2(M)  % x3
% HYPERDEMO Demonstrates the hyperspectral toolbox
timerVal_1 = tic;
disp('ִ�С�Ŀ����1�� .....................');
%% ���ṩ��������ʹ���ṩ�ģ���û���ṩ�������ݣ���ʹ������Ԥ�����ݡ�
if nargin == 0
filename1 = 'D:\MA��ҵ����\ATrain_Record\20191002\f970620t01p02_r03_sc03.a.bip';
% Read in an HSI image and display one band
slice = hyperReadAvirisRfl(filename1, [1 100], [1 614], [132 132]);
elseif nargin == 1
    try
        slice = M(:,:,132);
    catch
        slice = M(:,:,29);
    end
end
figure; imagesc(slice); axis image; colormap(gray);
    title('Band 33');


% Read part of AVIRIS data file that we will further process
if nargin == 0
    M = hyperReadAvirisRfl(filename1, [1 100], [1 614], [1 224]);
end
%{
% Read AVIRIS .spc file
% lambdasNm = hyperReadAvirisSpc(sprintf('%s\\f970620t01p02_r03.a.spc', dataDir));
% filename2 = 'D:\MA��ҵ����\ATrain_Record\20191002\sample-data-master\92AV3C.spc';
% filename2 = 'D:\MA��ҵ����\ATrain_Record\20191002\f970620t01p02_r03_sc03.a.hdr';
lambdasNm = hyperReadAvirisSpc(filename2);
figure; plot(lambdasNm, 1:length(lambdasNm)); title('Band Number Vs Wavelengths'); grid on;
    xlabel('Wavelength [nm]'); ylabel('Band Number');
 %}   
% lambdasNm 1��220 double; lambdasNm(1) =400.02, lambdasNm(end) = 2499;
% ����'92AV3C.spc'����֪hyperReadAvirisSpc()����������ԭ������ֵlambdasNm�ľ������
% lambdasNm������������Ԫ��Ϊ����ֵ������'92AV3C.spc'�еĲ�����ֻ��220������'*.a.bip'��
% ͨ����224����ƥ�䡣����Ϊ��ƥ��'*.a.bip'��������ȡ'*.a.hdr'�еĲ�������
% ����Ϊ�µ�lambdasNm
%
filename2 = 'D:\MA��ҵ����\ATrain_Record\20191002\f970620t01p02_r03_sc03.a.hdr';
info = read_envihdr(filename2);
lambdasNm = 1e3*info.wavelength';
figure; plot(lambdasNm, 1:length(lambdasNm)); title('Band Number Vs Wavelengths'); grid on;
    xlabel('Wavelength [nm]'); ylabel('Band Number');
    
    
% NDVI - I believe this should ideally be done with radiance data and no
% reflectance as we are doing here.
ir = M(:,:,59);
r = M(:,:,27);
ndvi = (ir - r) ./ (ir + r);
figure; imagesc(ndvi); title('NDVI of Image'); axis image; colorbar;

% Isomorph
[h, w, p] = size(M);
M = hyperConvert2d(M);


% Resample AVIRIS image.
desiredLambdasNm = 401:(2400-401)/(224-1):2400;
[s1,s2] = size(lambdasNm);
[s3,s4] = size(desiredLambdasNm);
length1 = max(s1,s2);
length2 = max(s3,s4);
d = lambdasNm(:,end)-lambdasNm(:,end-1);
if length1<length2 %��lambdasNm����desiredLambdasNm����β����չ
    if s2 < s1
        lambdasNm = lambdasNm'; %ת��Ϊ������
    end
        c =  lambdasNm(:,end)+d : d : lambdasNm(:,end)+d*(length2-length1);
        lambdasNm = [lambdasNm,c];
    if s2 < s1
        lambdasNm = lambdasNm'; %ת��Ϊԭ����״
    end
elseif length1 > length2%��lambdasNm����desiredLambdasNm����β���ض�
    if s2 < s1
        lambdasNm = lambdasNm'; %ת��Ϊ������
    end    
    lambdasNm = lambdasNm(:,1:length2);
    if s2 < s1
        lambdasNm = lambdasNm'; %ת��Ϊԭ����̬
    end
end

M = hyperResample(M, lambdasNm, desiredLambdasNm);

% Remove low SNR bands.
goodBands = [10:100 116:150 180:216];
M = M(goodBands, :);
p = length(goodBands);


% Demonstrate difference spectral similarity measurements
M = hyperConvert3d(M, h, w, p);
target = squeeze(M(32, 107, :));
figure; plot(desiredLambdasNm(goodBands), target); grid on;
    title('Target Signature; Pixel (32, 107)');
   
% Spectral Angle Mapper
if ~isa(M,'double')
    M = double(M);
end

M = hyperConvert3d(M, h, w, p);
target = squeeze(M(32, 107, :));

r = zeros(h, w);
for i=1:h
    for j=1:w
        r(i, j) = abs(hyperSam(squeeze(M(i,j,:)), target));
    end
end
figure; imagesc(r); title('Spectral Angle Mapper Result [radians]'); axis image;
    colorbar;

% Spectral Information Divergence
r = zeros(h, w);
for i=1:h
    for j=1:w
        r(i, j) = abs(hyperSid(squeeze(M(i,j,:)), target));
    end
end
figure; imagesc(r); title('Spectral Information Divergence Result'); axis image;
    colorbar;
    
% Normalized Cross Correlation
r = zeros(h, w);
for i=1:h
    for j=1:w
        r(i, j) = abs((hyperNormXCorr(squeeze(M(i,j,:)), target)));
    end
end
figure; imagesc(r); title('Normalized Cross Correlation [0, 1]'); axis image;
    colorbar;        
    
% PPI
U = hyperPpi(hyperConvert2d(M), 50, 1000);
figure; plot(U); title('PPI Recovered Endmembers'); grid on;
    
time1 = toc(timerVal_1);
disp(['��Ŀ����1��ִ����......�Ѿ���ʱ',num2str(time1),'��.']);
%--------------------------------------------------------------------------
% Perform a fully unsupervised exploitation chain using HFC, ATGP, and NNLS
fprintf('Performing fully unsupervised exploitation using HFC, ATGP, and NNLS...');
M = hyperConvert2d(M);

% Estimate number of endmembers in image.
q = hyperHfcVd(M, [10^-3]);
%q = 50;

% PCA the data to remove noise
%hyperWhiten(M)
M = hyperPct(M, q);
%p = q;

% Unmix AVIRIS image.
%U = hyperVca(M, q);
U = hyperAtgp(M, q);
figure; plot(U); title('ATGP Recovered Endmembers'); grid on;

timerVal_2 = tic;
disp('�������ʱ����.......................................');
% Create abundance maps from unmixed endmembers.
timerVal_1 = tic;
f = @() hyperNnls(M,U);
time_1 = timeit(f)
timeElapse_1 = toc(timerVal_1); % 2337
% disp(timeElapse_1);
%abundanceMaps = hyperUcls(M, U);
abundanceMaps = hyperNnls(M, U);
%abundanceMaps = hyperFcls(M, U);
% abundanceMaps = hyperNormXCorr(M, U);

abundanceMaps = hyperConvert3d(abundanceMaps, h, w, q);
resultsDir = 'results\';
for i=1:q
    tmp = hyperOrthorectify(abundanceMaps(:,:,i), 21399.6, 0.53418);
    figure; imagesc(tmp); colorbar; axis image; 
        title(sprintf('Abundance Map %d', i));
        hyperSaveFigure(gcf, ['results\chain1_mam_', num2str(i), '.png']);
        close(gcf);
end
fprintf('Done.\n');

time1 = toc(timerVal_1);
time2 = toc(timerVal_2);
disp(['���ʱ����ִ����ϣ���ʱ',num2str(time2),'��.']);
disp(['��Ŀ����1��ִ����......�Ѿ���ʱ',num2str(time1),'��.']);

%--------------------------------------------------------------------------
% Perform another fully unsupervised exploitation chain using ICA
fprintf('Performing fully unsupervised exploitation using ICA...');
[U, abundanceMaps] = hyperIcaEea(M, q);
abundanceMaps = hyperConvert3d(abundanceMaps, h, w, q);
for i=1:q
    tmp = hyperOrthorectify(abundanceMaps(:,:,i), 21399.6, 0.53418);
    figure; imagesc(tmp); colorbar; axis image; 
        title(sprintf('Abundance Map %d', i));
        hyperSaveFigure(gcf, ['results\chain2_mam_', num2str(i), '.png']);
        close(gcf);
end
% fprintf('Done.\n');
disp('��Ŀ����1��ִ����ϣ�');