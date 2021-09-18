clc
clear all
close all

% STEP a: 导入矩阵U %%%%%%%%%%%
load valid_dir50.mat
U=valid;

P = 20;%测量次数
M = 16;%天线阵元数

% STEP b: 信号相关 %%%%%%%%%%%%%%%%%U*A*sig
K = 1; %快拍数
sigNum = 2;%信号个数
d = 0.5;%1/2波长
SNR = 20;
theta = [30.56 10.24];%deg
vec = @(MAT) MAT(:);
vecH = @(MAT) MAT(:).';
SteerVec = @(angTmp) exp(1i*2*pi*d*[0:M-1].'*sind(vecH(angTmp)));
epsilon=262.6*exp(-0.1327*SNR);

Vars = 1;
sig =sqrt(Vars)*exp(1i*2*pi*rand(sigNum,K)) ;
noise00 = sqrt(1/2)*randn(P,K)+1i*randn(P,K);
noise0 = (noise00-mean(noise00))/sqrt(norm(noise00).^2);
noiseVar = norm(U*SteerVec(theta)*sig).^2/ 10^(SNR/10);
noise = sqrt(noiseVar) .* noise0;
y = U*SteerVec(theta)*sig + noise;
        

xxl = [-60:0.1:60];%扫描范围
scanxxl = U*SteerVec(xxl);


% % % % % % % % % % % STEP c: CVX %%%%%%%%%%%%%%%%%
cvx_quiet true
cvx_precision default
cvx_solver sdpt3
cvx_begin sdp
    variable p(P) complex;
    minimize(norm(y-p));
    subject to   
    max(abs(p'*scanxxl))<=epsilon;
cvx_end


Ppoly=p'*scanxxl;
[pks, locs] = findpeaks(abs(Ppoly),xxl,'SortStr','descend');
DOA=locs(1:sigNum);
figure; plot(xxl, abs(Ppoly));
hold on; plot(locs, pks, 'v');
hold on; stem(theta, max(abs(Ppoly))*ones(sigNum,1), 'BaseValue', 0)