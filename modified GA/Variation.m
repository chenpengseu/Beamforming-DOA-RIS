function kidspop = Variation(kidspop,VARIATIONRATE)
%Variation 变异的概率一般比较低
%   输入的是交叉后的种群
%           以及变异率
for n=1:size(kidspop,2)
    if rand<VARIATIONRATE
        temp = kidspop{n};
        %接着找到变异的位置
        location = ceil(length(temp)*rand);
        temp = [temp(1:location-1) num2str(~temp(location))...
            temp(location+1:end)];
        kidspop{n} = temp;
    end    
end


