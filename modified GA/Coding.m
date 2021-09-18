function binpop=Coding(pop,length)
binpop={};
for n=1:size(pop,1)
    for m=1:length
    if pop(n,m)==1
        binpop{n}(m)=['0'];
    elseif pop(n,m)==-1
        binpop{n}(m)=['1'];
    end
    end
end
end