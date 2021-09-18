function fitness = weight(p_matrix,fitness_1,pop_P)
%%%%%%输入：
%%%%%%      p_matrix:已求出的测量向量（行向量）组成的矩阵
%%%%%%      fitness_1:已知的适应度
%%%%%%      pop_P:与fitness_1对应的种群，每一行都是一个新的变量
%   增加一个新的约束
%   将新的行向量与原始的组成一个新的矩阵
%   求矩阵的行秩，如果等于行数，就不做变化
%               如果秩小于行数，就给变量对应的适应度乘0.1
fitness=fitness_1;
for i=1:size(pop_P,1)
    PP=[p_matrix;pop_P(i,:)];
        if rank(PP)==size(PP,1)
            continue
        else
            fitness(i)=0*fitness(i);
        end
end
end

