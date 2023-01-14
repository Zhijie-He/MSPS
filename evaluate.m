function [x,f] = evaluate(x,M,VArray)

global R1;                         
global R2; 
global R3; 
global VArraysum;                 % The total number of tasks
global indegree;                  
global self;                      
global candidate;                 
global People;

for i = 1 : VArraysum                         
    if candidate(i,x(VArraysum*2+i),1) == -1  
        x(VArraysum+i) = 0;
    end
    if x(VArraysum+i) < 0.2
        x(VArraysum+i) = 0;
    end
    if x(VArraysum+i) > 0.8
        x(VArraysum+i) = 1;
    end
end

f = zeros(1,M);                                   

[Alltime,~,People_allocate] = TuoPu29F3(x(1:VArraysum),x(VArraysum+1:VArraysum*2),x(VArraysum*2+1:VArraysum*3),self,candidate,indegree,R1,R2,R3,1,People);
f(1)=Alltime;

% Objective function M
Costsum=0;
for i = 1 : VArraysum
    Costsum = Costsum + ((1 - x(VArraysum+i))*(self(i,1)) + x(VArraysum+i)*(candidate(i,x(VArraysum*2 + i),1)));
end
% Total Cost
f(M) = Costsum;