function f = initialize(N, M, V,VArray)

%% function f = initialize(N, M, V,VArray)
%{
   N : The size of population
   M : The number of objective functions
   V : The number of decision variables
   VArray : The array contains the number of tasks for each project
 %}

%% Initialize each chromosome
% K = 2 + 29 * 2
K = M + V;  
VArraysum = sum(VArray); 

global R1;
global R2;
global R3;
global break_self; %break_self[The time required for the activity, the type of work required for the activity, the number of people required, the project to which it belongs]

f(N,V)=single(0);
% The priority of the project is stored in the front f, and the number of employees involved in each small project is stored in the back of f
for i = 1 : N 
    f(i,1:VArraysum) = randperm(VArraysum); %randomly generated priority
    BX = VArraysum + 1;
    for j = 1:VArraysum
        % break_self(j,2) is the required type of work break_self(j,3) is the required number of people
        switch break_self(j,2)
            case 1
                t = randperm(size(R1,2) - break_self(j,3),1);
                f(i,BX:BX+break_self(j,3)-1) = R1(t:t+break_self(j,3)- 1);
            case 2
                t = randperm(size(R1,2) - break_self(j,3),1);
                f(i,BX:BX+break_self(j,3)-1) = R2(t:t+break_self(j,3)- 1);
            case 3
                t = randperm(size(R1,2) - break_self(j,3),1);
                f(i,BX:BX+break_self(j,3)-1) = R3(t:t+break_self(j,3) - 1);
        end
        BX = BX + break_self(j,3);
    end
    [f(i,:),f(i,V + 1: K)] = evaluate(f(i,:),M,V,VArray);  
end