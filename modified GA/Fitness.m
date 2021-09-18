function fitness=Fitness(P,number_N)
%%计算适应度函数，由于需要寻求最小值，适应度函数为目标函数值前加负号
for n=1:size(P,1)
    p=P(n,:);
    f=Obj_cal(p,number_N);
    %此处加入罚函数，也即约束方向图的旁瓣
    fitness(n)=1/f;
end
end