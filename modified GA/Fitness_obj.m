function fitness=Fitness_obj(P,number_N)
%%计算适应度函数，由于需要寻求最小值，适应度函数为目标函数值前加负号
for n=1:size(P,1)
    p=P(n,:);
    f=Obj(p,number_N);
    fitness(n)=1/f;
end
end
