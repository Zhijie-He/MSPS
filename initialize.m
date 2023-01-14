function f = initialize(N, M, V,VArray)

%% function f = initialize(N, M, V,VArray)
%{
   N : The size of population
   M : The number of objective functions
   V : The number of decision variables
   VArray : The array contains the number of tasks for each project
 %}

%% Initialize each chromosome

K = M + V;  
global VArraysum;

f(N,V)=single(0);
for i = 1 : N 
    %  %randomly generated priority
    f(i,1:VArraysum) = randperm(VArraysum);                        
    f(i,VArraysum+1:VArraysum*2) = rand(1,VArraysum);                
    if i == 1           
        f(i,VArraysum+1:VArraysum*2) = zeros(1,VArraysum);
    elseif i==2
        f(i,VArraysum+1:VArraysum*2) = ones(1,VArraysum);
    elseif i==3
        f(i,VArraysum+1:VArraysum*2) = ones(1,VArraysum)*0.5;
    else
         f(i,VArraysum+1:VArraysum*2) = rand(1,VArraysum);       
    end
    for j = 1:VArraysum                   
        f(i,VArraysum*2+j) = randperm(3,1);                            
    end
    [f(i,:),f(i,V + 1: K)] = evaluate(f(i,:),M,VArray);  
end

