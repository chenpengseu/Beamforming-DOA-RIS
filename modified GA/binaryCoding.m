function binpop= binaryCoding(pop,pop_length)
%%此函数的作用是生成初始化的染色体，为一系列规定长度的二进制数
%输入：pop---随机生成的一系列0~1之间的数
%     pop_length---编码的长度
% W = log2(pop_length);
pop = round(pop*10^6);
for n = 1:size(pop,2) %列循环
    for k = 1:size(pop,1) %行循环
        dec2binpop{k,n} = dec2bin(pop(k,n));
        lengthpop=length(dec2binpop{k,n});
        for s=1:pop_length-lengthpop %补零
            dec2binpop{k,n}=['0' dec2binpop{k,n}];
        end
    end
    binpop{n}=dec2binpop{k,n};
end
end