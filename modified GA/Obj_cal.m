function f_constraint=Obj_cal(p,N)
c=299792458;
f=300e6;
lambda=c/f;     % 波长
beta=2*pi/lambda;       % 自由空间波数
d=lambda/2*(1-1/N)*0.92;       % 单元间距
alpha1=-beta*d*sind(90);

theta=linspace(-pi/3,pi/3,181);
Psi1=beta*d*sin(theta)+alpha1;
% alpha1=0;
% Psi1=beta*d*sin(theta);
f0=[];
for i=1:N
    f0=[f0;exp(1j*(i-1)*Psi1)];
end
f1=abs(p*f0);
Tlb=10;
flb=rectpuls(rad2deg(theta)-50,Tlb);
ylb=10^-1/(1-10^-1);%%-20
F0=20*log10(f1/max(f1));
Flb=20*log10((flb+ylb)/(ylb+1));
Elb=zeros(1,length(theta));

for i=1:length(theta)
    Elb(i)=norm(real(F0(i))-Flb(i))^2;
end

f_ori=sum(Elb);
%加入罚函数，更改目标函数，主要是为了约束旁瓣
[pks,locs]=findpeaks(f1,theta,'SortStr','descend');
ratio=20*log10(pks(1)/pks(2));
punish_side=max(10,ratio)/(max(10,ratio)-10+ratio);
deg_shift=norm(rad2deg(locs(1))-50);
punish_focus=1-(3-deg_shift)/3;
f_constraint=f_ori*punish_side+f_ori*punish_focus;
end