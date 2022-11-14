clc
clear all
close all

t=cputime;
%遗传参数设置
NUMPOP = 250;%初始种群大小，即刚开始的编码个数
LENGTH = 16; %二进制编码长度，此处不需要解码，直接为自变量
ITERATION = 50;%迭代次数
CROSSOVERRATE = 0.7;%杂交率
SELECTRATE = 0.5;%选择率
VARIATIONRATE = 0.001;%变异率


for c=1:1
%初始化种群
pop_0 = unifrnd(0,1,1,NUMPOP);%随机产生一系列随机的0-1之间的数
pop = binaryCoding(pop_0,LENGTH);%将随机产生的数转换为二进制数
pop_P = MATRIX_P(pop,LENGTH);  %转换为测量向量

%开始迭代
for time = 1:ITERATION
    %计算初始种群的适应度
    fitness_1 = Fitness_obj(pop_P,LENGTH);
    %修正适应度，确保最终结果跟之前的不同
    if c == 1
        fitness = fitness_1;
    else
        %weight利用了新生成的矩阵的行秩是否等于行数来筛选
        %weight_cor表明相关系数的绝对值大于0.3就被筛掉
        fitness = weight_cor(valid(1:c-1,:),fitness_1,pop_P);
    end 
    %选择
    pop_P = Select(fitness,pop_P,SELECTRATE);
    %编码
    binpop = Coding(pop_P,LENGTH);
    %交叉
    kidspop = crossover(binpop,NUMPOP,CROSSOVERRATE);
    %变异
    kidspop = Variation(kidspop,VARIATIONRATE);
    %解码
    kidspop = MATRIX_P(kidspop,LENGTH);
    %更新种群
    pop_P = [pop_P;kidspop];
    %记录每次的平均适应度
    record(1,time) = mean(fitness);
end
figure(1)
plot(1:ITERATION,record);
figure(2)
[theta,AF] = graph_p(pop_P(1,:));
plot(theta,AF);
valid(c,:) = pop_P(1,:);

end
cputime-t
