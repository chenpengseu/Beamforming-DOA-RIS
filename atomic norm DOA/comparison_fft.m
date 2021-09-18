clc
clear all
close all

% STEP a: 导入矩阵U %%%%%%%%%%%
load valid_dir50.mat
U=valid;

P = 20;%测量次数
U=U(1:P,:);
M = 16;%天线阵元数

% STEP b: 信号相关 %%%%%%%%%%%%%%%%%U*A*sig
SNR = 20;
rmse=zeros(1,length(SNR));
K = 1; %快拍数
sigNum = 2;%信号个数
d = 0.5;%1/2波长
theta = [30.56 10.24];%deg
vec = @(MAT) MAT(:);
vecH = @(MAT) MAT(:).';
SteerVec = @(angTmp) exp(1i*2*pi*d*[0:M-1].'*sind(vecH(angTmp)));
Vars = 1;%能量
sig =sqrt(Vars)*exp(1i*2*pi*rand(sigNum,K)) ;
noise0 = sqrt(1/2)*randn(P,K)+1i*randn(P,K);
noiseVar = mean(abs(U*SteerVec(theta)*sig).^2) / 10^(SNR/10);
noise = sqrt(noiseVar) .* noise0;
y = U*SteerVec(theta)*sig + noise;
xxl = [-60:0.1:60];%扫描范围
scanxxl = U*SteerVec(xxl);
y_fft=scanxxl'*y;
[pks, locs] = findpeaks(abs(y_fft),xxl,'SortStr','descend');
DOA=locs(1:sigNum);
figure; plot(xxl, abs(y_fft));
hold on; plot(locs, pks, 'v');
hold on; stem(theta, max(abs(y_fft))*ones(sigNum,1), 'BaseValue', 0)
