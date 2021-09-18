function P=MATRIX_P(pop,binlength)
%此函数产生一个矩阵，将二进制数转换为向量，一系列二进制数转换为矩阵
for ii=1:length(pop)
    for jj=1:binlength
        if str2num(pop{ii}(jj))==0
        P(ii,jj)=1;
        elseif str2num(pop{ii}(jj))==1
            P(ii,jj)=-1;
        end  
    end
end
end