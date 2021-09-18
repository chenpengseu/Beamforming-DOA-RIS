function fitness = weight_cor(p_matrix,fitness_1,pop_P)
%%%%%%输入：
%%%%%%      p_matrix:已求出的测量向量（行向量）组成的矩阵
%%%%%%      fitness_1:已知的适应度
%%%%%%      pop_P:与fitness_1对应的种群，每一行都是一个新的变量
%   增加一个新的约束
%   将新的行向量与原始的组成一个新的矩阵
%   求矩阵的相关系数，对于16阵元来说，如果两个向量之间存在一位的区别，那么
%   相关系数的绝对值约为0.8819，所以判断两个向量之间的相关性就可以通过
%   判断相关系数有没有大于0.5，如果大于就筛掉
fitness=fitness_1;
for i=1:size(pop_P,1)
    PP=[p_matrix;pop_P(i,:)];
    PP=PP.';
    PP_cor=corrcoef(PP);
    jj=size(PP_cor,2);
    for ii=1:size(PP_cor,1)-1 
            if norm(PP_cor(ii,jj))>0.5
                fitness(i)=0*fitness(i);
            end
    end  
end
end

