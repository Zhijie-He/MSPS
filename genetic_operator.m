function f  = genetic_operator(parent_chromosome,M,V,generation,current_gen,VArray)

[N,~] = size(parent_chromosome);       % N记录了交配池的行数
p = 1;
global VArraysum;                      % 项目总个数
global Pro_index;
Pro_index2 = Pro_index + VArraysum;
F0 = 0.4;                              % 初始变异算子
CR = 0.8;                              % 交叉算子
%% 变异操作
%generation为总代数目   current_gen为当前代数目
lamda = exp(1-generation/(generation+1-current_gen));
F = F0*2^(lamda);                        % 自适应变异算子

% N表示有多少行
for i = 1 : N
    parent_1 = randi(N,1,1);   % 随机生成1-VArraysum之内的数
    parent_2 = randi(N,1,1);
    parent_4 = randi(N,1,1);
    %保证选择的不是同一个
    while(parent_1 == parent_2 || parent_1 == parent_4 || parent_2 == parent_4)
        parent_1 = randi(N,1,1);
        parent_2 = randi(N,1,1);
        parent_4 = randi(N,1,1);
    end
    %对于不允许重复的染色体 我们采用部分一致交叉PMX  需要做冲突检测  而OX，PBX等等不需要
    %采用最简单的SEC Subtour Exchange Crossover交叉方法   这样 种群的多样性就好了很多
    % 对优先级进行交叉
    child_1 = parent_chromosome(parent_1,:);
    child_2 = parent_chromosome(parent_2,:);
    if CR > rand
        r1_1=randi(VArraysum,1,1);
        r1_2=randi(VArraysum,1,1);
        
        while isequal(r1_1,r1_2)
            r1_2=randperm(VArraysum,1);
        end
        % 随机产生两个不等的值 作为交叉结点位置
        r1 = min(r1_1,r1_2);
        r2 = max(r1_1,r1_2);
        % 进行SEC交叉
        c=[];
        for j = r1:r2
            c=[c find(child_2(1:VArraysum) == child_1(j))];
        end
        c=sort(c);
        if size(c,2) ~= 0
            for j = r1:r2
                temp = child_1(j);
                child_1(j) = child_2(c(j-r1+1));
                child_2(c(j-r1+1)) = temp;
            end
        end
        
        % 进行对应交叉
        temp = child_1(Pro_index2(r1):Pro_index2(r2));
        child_1(Pro_index2(r1):Pro_index2(r2)) = child_2(Pro_index2(r1):Pro_index2(r2));
        child_2(Pro_index2(r1):Pro_index2(r2)) = temp;
    end
    
    
    if F > rand
        %% 变异操作
        r1_1=randi(VArraysum,1,1);
        r1_2=randi(VArraysum,1,1);
        
        while isequal(r1_1,r1_2)
            r1_2=randperm(VArraysum,1);
        end
        % 随机产生两个不等的值 作为交叉变异结点位置
        r1 = min(r1_1,r1_2);
        r2 = max(r1_1,r1_2);
        
        temp = child_1(r1);
        child_1(r1) = child_1(r2);
        child_1(r2) = temp;
        
        temp = child_2(r1);
        child_2(r1) = child_2(r2);
        child_2(r2) = temp;
    end
    

    
    %计算产生的个体适应度值  即各个目标函数值
    [child_1,child_1(:,V + 1: M + V)] = evaluate(child_1, M, V,VArray);
    [child_2,child_2(:,V + 1: M + V)] = evaluate(child_2, M, V,VArray);
    
    child(p,:) = child_1;
    child(p+1,:) = child_2;
    p = p + 2;
end
f = child;