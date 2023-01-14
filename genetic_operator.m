function f  = genetic_operator(parent_chromosome,M,V,generation,current_gen,VArray)

[N,~] = size(parent_chromosome);     
p = 1;
global VArraysum                      

F0 = 0.4;                              
CR = 0.1;                              

lamda = exp(1-generation/(generation+1-current_gen));
F=F0*2^(lamda);                       
zoom=0.5;                           
for i = 1 : N
    parent_1 = randi(N,1,1);   
    parent_2 = randi(N,1,1);
    parent_4 = randi(N,1,1);

    while(parent_1 == parent_2 || parent_1 == parent_4 || parent_2 == parent_4)
        parent_1 = randi(N,1,1);
        parent_2 = randi(N,1,1);
        parent_4 = randi(N,1,1);
    end
    %For chromosomes that do not allow duplication, we use partially consistent crossover PMX needs to do conflict detection, while OX, PBX, etc. do not
    %Use the simplest SEC Subtour Exchange Crossover crossover method so that the diversity of the population is much better
    child_1 = parent_chromosome(parent_1,:);
    child_2 = parent_chromosome(parent_2,:);
    
    r1_1=randi(VArraysum,1,1);
    r1_2=randi(VArraysum,1,1);
    
    while isequal(r1_1,r1_2)
        r1_2=randperm(VArraysum,1);
    end
    % Randomly generate two unequal values as the intersection node position
    r1 = min(r1_1,r1_2);
    r2 = max(r1_1,r1_2);
    % Perform SEC crossover
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
    % child_1 takes scaling factor
    child_1(VArraysum+1:VArraysum*2) = parent_chromosome(parent_1,VArraysum+1:VArraysum*2)...
        +zoom*(parent_chromosome(parent_2,VArraysum+1:VArraysum*2) - parent_chromosome(parent_4,VArraysum+1:VArraysum*2));
    % child_2 uses adaptive mutation operator
    child_2(VArraysum+1:VArraysum*2)=parent_chromosome(parent_1,VArraysum+1:VArraysum*2)...
        +F*(parent_chromosome(parent_2,VArraysum+1:VArraysum*2) - parent_chromosome(parent_4,VArraysum+1:VArraysum*2));
    
    %% cross operation
    r = randi(VArraysum,1,1);
    for n = VArraysum+1:VArraysum*2
        cr = rand(1);
        if(cr > CR) && (n ~= r)
            child_1(n) = parent_chromosome(parent_1,n);
            child_2(n) = parent_chromosome(parent_1,n);
        end
    end
    
    %%%%%%%%% Boundary condition processing%%%%%%%%%%%%%%
    for n = VArraysum+1:VArraysum*2
        if (child_1(n) < 0) || (child_1(n) > 1)
            child_1(n) = rand;
        end
        if (child_2(n) < 0)||(child_2(n) > 1)
            child_2(n) = rand;
        end
    end
    
    CRpoint=randperm(VArraysum,1);  % Randomly generate partner single-point intersections  
    temp=child_1(VArraysum*2+CRpoint:VArraysum*3);
    child_1(VArraysum*2+CRpoint:VArraysum*3)=child_2(VArraysum*2+CRpoint:VArraysum*3);
    child_2(VArraysum*2+CRpoint:VArraysum*3)=temp;
    

    [child_1,child_1(:,V + 1: M + V)] = evaluate(child_1, M, VArray);
    [child_2,child_2(:,V + 1: M + V)] = evaluate(child_2, M, VArray);
    
    child(p,:) = child_1;
    child(p+1,:) = child_2;
    p = p + 2;
end
f = child;