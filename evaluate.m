function [x,f] = evaluate(x,M,V,VArray)

% The total number of tasks
VArraysum = sum(VArray);             
global People;
global break_indegree;
global break_self;


f = zeros(1,M);                                   
if M==2  
    [Alltime,gante_tu,People_allocate] = TuoPu29F3(x(1:VArraysum),x(VArraysum+1:V),break_self,break_indegree,1,People);
    f(1)=Alltime;
% else % if M ==3 
%     [~,gante_tu]=TuoPu29F3(x(1:VArraysum),x(VArraysum+1:VArraysum*2),...
%         x(VArraysum*2+1:VArraysum*3),self,candidate,indegree,R,1);
%     f(1)=max(gante_tu(1:VArray(1),4));                            % The first objective function value The first item end time
%     f(2)=max(gante_tu(VArray(1):VArraysum,4));                    % The second objective function value The second project end time
end
% Objective function M
Costsum=0;
% Basic Salary
BaseMonthPay = 2000;
Month = f(1)/30;
People_num = max(People(:,end));
Costsum = Costsum + BaseMonthPay * Month * People_num;
% commission
People_part_in = zeros(People_num,VArraysum);
for i=1:VArraysum
    People_part_in(People_allocate(i).R,i) = 1;
end
TP=break_self(:,1);                             % expected makespan
TS=gante_tu(:,4) - gante_tu(:,3);               % actual makespan
C = 20000*ones(People_num,VArraysum);           % Project commission
for i = 1 : People_num
    for j = 1:VArraysum
        Costsum = Costsum + People_part_in(i,j) * TP(j) / TS(j) * C(i,j);
    end
end
% Total Cost
f(M) = Costsum;
