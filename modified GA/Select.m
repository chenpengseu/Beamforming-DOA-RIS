function parentPop=Select(matrixFitness,pop,SELECTRATE)
%%选择
% 输入：适应度
% pop--初始种群
% SELECTRATE--选择率
sumFitness=sum(matrixFitness(:));%计算所有种群的适应度

accP=cumsum(matrixFitness/sumFitness);%每个目标概率
%%%%轮盘赌选择算法
%每个个体进入下一代的概率等于它的适应度值与整个种群中个体适应度值和的比例。
%选择误差较大。
for n=1:round(SELECTRATE*size(pop,1))
    matrix=find(accP>rand);%找到比随机数大的概率
    if isempty(matrix)
        continue
    end
    parentPop(n,:)=pop(matrix(1),:);%将首个比随机数大的累积概率的位置的个体遗传下去
end
end
