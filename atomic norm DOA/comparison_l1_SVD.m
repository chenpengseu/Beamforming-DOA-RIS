clc
clear
close all

load valid_dir50.mat
U=valid;

P = 5;
N = 16;
U=U(1:P,:);

                   
dd = 0.5;               
d=0:dd:(N-1)*dd;  
theta0 = [10.24 30.56];     
NumK = length(theta0);      
snr = 0;               
Sample = 4;          
 
A=exp(-1i*2*pi*d.'*sind(theta0)); 

sig =sqrt(Vars)*exp(1i*2*pi*rand(NumK,Sample)) ;
noise00 = sqrt(1/2)*randn(P,Sample)+1i*randn(P,Sample);
noise0 = (noise00-mean(noise00))/sqrt(norm(noise00).^2);
noiseVar = norm(U*A*sig).^2/ 10^(snr/10)
noise = sqrt(noiseVar) .* noise0;
X1 = U*A*sig + noise;



% 构造过完备基
d_lamda = 0.5;
AA=[];                        
theta=-60:0.1:60;       
Ntheta = length(theta);
for kkk= 1:length(theta) 
    g=U*exp(-1i*2*pi*[0:N-1]'*d_lamda*sin(theta(kkk)/180*pi));  
    AA=[AA,g]; 
end 

%% L1-SVD方法
Y = X1;
[U1,L,V] = svd(Y) ; % 做SVD分解
Ik = ones(1,NumK);
Dk = [diag(Ik); zeros(NumK,Sample-NumK)']; % 维度T*K维
 
Ysv = Y*V*Dk;  

cvx_begin 
    variables p q;
    variable r(Ntheta,1) ; 
    variable Ssv1(Ntheta,NumK) complex ; 
    expression sl2(Ntheta,1) ;  
    minimize(p + 2*q)
    subject to
        norm(vec(Ysv - AA*Ssv1),2) <=p;
        II = ones(Ntheta,1);
        II'*r <=q;  
        for i = 1:Ntheta
            norm(Ssv1(i,:),2) <=r(i);
        end
cvx_end

Ssv1sum = sum(abs(Ssv1) , 2);
% Power_Ssv=10*log10(Ssv1sum/max(Ssv1sum));
% [pks, locs] = findpeaks(Power_Ssv,theta,'SortStr','descend');
% DOA=locs(1:NumK);
figure; plot(theta, Ssv1sum/max(Ssv1sum));
% hold on; plot(locs, pks, 'v');
hold on; 
stem(theta0, max(Power_Ssv)*ones(NumK,1), 'BaseValue', 1)
