function [Alltime,gante_tu,People_allocate] = TuoPu29F3(x,index,part,self,candidate,indegree,R1,R2,R3,flag_F2,People)
%topological sort
global VArraysum;                    
global s;                           % Adjacency matrix

visit = zeros(1,VArraysum);         % Access ID array 1 means access, 0 means no access

gante_tu(1: VArraysum,1) = 1: VArraysum;
gante_tu(1: VArraysum,2) = 1: VArraysum;

for i = 1: VArraysum
    self(i,1) = (1-index(i))*self(i,1) + index(i)*candidate(i,part(i),1);
    self(i,2) = (1-index(i))*self(i,2) + index(i)*candidate(i,part(i),2);
end

used = zeros(1,VArraysum);               
Alltime = 0;

wait=[];              % waiting list                    
exe=[];                                     
flag_1 = 0;                               

% The total number of people who have mastered technology
R(1)=size(R1,2);                         
R(2)=size(R2,2);                        
R(3)=size(R3,2);                         
in_exe=zeros(1,VArraysum);               

while flag_1 ~= 1
    flag_1 = 0;
    result_max = [];

    for k = 1 : VArraysum
        if ~indegree(k) && ~visit(k) && ~used(k)
            result_max = [result_max k];
        end
    end
    L = size(result_max,2);                         
    if L == 1 && size(exe,2) == 0
        p = result_max(1);
        visit(p) = 1;
        % Assign human resource to tasks R1->R2->R3
        People(R1(1:self(p,3)),end - 1)=0;
        People_allocate(p).R1=People(R1(1:self(p,3)),end);
        [R1,R2,R3,R]=updateR(People);
        People(R2(1:self(p,4)),end - 1)=0;
        People_allocate(p).R2=People(R2(1:self(p,4)),end);
        [R1,R2,R3,R]=updateR(People);
        People(R3(1:self(p,5)),end - 1)=0;
        People_allocate(p).R3=People(R3(1:self(p,5)),end);
        [R1,R2,R3,R]=updateR(People);
       
        enter_time = Alltime;
        if flag_F2 == 2             
            fprintf('time=%d, task %d enter \n',enter_time,p);
        end
        gante_tu(p,3) = enter_time;
        % Obtain the average proficiency under the current strategy
        aver_radio = efficiency(People_allocate(p),People);
        Alltime = Alltime + self(result_max(1),2)/aver_radio;
        
        quit_time = Alltime;
        % Release occupied human resources
        People(People_allocate(p).R1,end - 1)=1;
        People(People_allocate(p).R2,end - 1)=1;
        People(People_allocate(p).R3,end - 1)=1;
        [R1,R2,R3,R]=updateR(People);
        
        if flag_F2 == 2
            fprintf('time=%d, task exit %d\n',quit_time,p);
        end
        gante_tu(p,4) = quit_time;
        
        for j = 1 : VArraysum 
            if s(p,j)
                indegree(j) = indegree(j) - 1;
            end
        end
    elseif L + size(exe,2) >= 1 
        % Use the semaphore mechanism and allocate resources to activities according to priority
        % The parallel time calculated based on the minimum active time
        [~,index] = sort(x(result_max(1:end)));
        if  size(result_max,2) ~= 0
            for u = 0 : L-1
                p = result_max(index(end-u));
               
                if R(1) >= self(p,3)
                    People(R1(1:self(p,3)),end - 1)=0;
                    People_allocate(p).R1=People(R1(1:self(p,3)),end);
                    [R1,R2,R3,R]=updateR(People);
                    if R(2) >= self(p,4)
                        People(R2(1:self(p,4)),end - 1)=0;
                        People_allocate(p).R2=People(R2(1:self(p,4)),end);
                        [R1,R2,R3,R]=updateR(People);
                        if R(3) >= self(p,5)
                            People(R3(1:self(p,5)),end - 1)=0;
                            People_allocate(p).R3=People(R3(1:self(p,5)),end);
                            [R1,R2,R3,R]=updateR(People);
                            exe=[exe p];
                            used(p) = 1;
                            enter_time = Alltime;
                            if flag_F2 == 2
                                fprintf('time=%d, task %d enter \n',enter_time,p);
                            end
                            gante_tu(p,3) = enter_time;
                        else
                            People(People_allocate(p).R1,end - 1)=1;
                            People(People_allocate(p).R2,end - 1)=1;
                            People_allocate(p).R1=[];
                            People_allocate(p).R2=[];
                            [R1,R2,R3,R]=updateR(People);
                            wait = [wait p];
                        end
                    else
                        People(People_allocate(p).R1,end - 1)=1;
                        People_allocate(p).R1=[];
                        updateR(People);
                        wait = [wait p];
                    end
                else
                    wait = [wait p];
                end
            end
        end
        time = [];
        for u = 1 : size(exe,2)
          
            if in_exe(exe(u))==1
                aver_radio = efficiency(People_allocate(exe(u)),People);
                self(exe(u),2) = self(exe(u),2)/aver_radio;
                in_exe(exe(u))=0;
            end
            time = [time self(exe(u),2)];
        end
        [mintime,~] = min(time);                 
        c = [];                                 
        for u = 1 : size(exe,2)
            self(exe(u),2) = self(exe(u),2) - mintime;
            if self(exe(u),2) == 0
                c=[c u];
                visit(exe(u)) = 1;
       
                People(People_allocate(exe(u)).R1,end - 1)=1;
                People(People_allocate(exe(u)).R2,end - 1)=1;
                People(People_allocate(exe(u)).R3,end - 1)=1;
                [R1,R2,R3,R]=updateR(People);
                for j = 1 : VArraysum
                    if s(exe(u),j)
                        indegree(j) = indegree(j) - 1;
                    end
                end
            end
        end
        Alltime = Alltime + mintime;
        for i = 1:size(c,2)
            quit_time = Alltime;
            if flag_F2 == 2
                fprintf('time=%d, task exit %d\n',quit_time,exe(c(i)));
            end
            gante_tu(exe(c(i)),4) = quit_time;
        end
        exe(c)=[];
    end
    if sum(visit) == VArraysum
        flag_1 = 1;
    end
end
end

% Calculate R1 R2 R3 respectively according to the current manpower vacancy
function [R1,R2,R3,R]=updateR(People)
    R1=[];
    R2=[];
    R3=[];
    sort_people_R1=sortrows(People,-1);
    sort_people_R2=sortrows(People,-2);
    sort_people_R3=sortrows(People,-3);
    for a = 1:size(People,1)
        if sort_people_R1(a,1)>0.5 && sort_people_R1(a,end-1)==1
            R1=[R1 sort_people_R1(a,end)];
        end
        if sort_people_R2(a,2)>0.5 && sort_people_R2(a,end-1)==1
            R2=[R2 sort_people_R2(a,end)];
        end
        if sort_people_R3(a,3)>0.5 && sort_people_R3(a,end-1)==1
            R3=[R3 sort_people_R3(a,end)];
        end
    end
    R(1)=size(R1,2);
    R(2)=size(R2,2);
    R(3)=size(R3,2);
end

% Calculate average proficiency based on manpower allocation
function radio=efficiency(People_allocate,People)
    SumAllocateR1 = size(People_allocate.R1,2);
    SumAllocateR2 = size(People_allocate.R2,2);
    SumAllocateR3 = size(People_allocate.R3,2);
    SumAllocateR = SumAllocateR1+SumAllocateR2+SumAllocateR3;
    RadioAllocateR1 = sum(People(People_allocate.R1,1));
    RadioAllocateR2 = sum(People(People_allocate.R2,2));
    RadioAllocateR3 = sum(People(People_allocate.R3,3));
    RadioAllocateR = RadioAllocateR1+RadioAllocateR2+RadioAllocateR3;
    radio=RadioAllocateR/SumAllocateR;
end





