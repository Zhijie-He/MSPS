function [Alltime,gante_tu,People_allocate] = TuoPu29F3(x,Peo_index,self,indegree,flag_F2,People)
%topological sort
global VArraysum;                    
global bs;  % Adjacency matrix for new small items
visit = zeros(1,VArraysum); % Access ID array 1 means access, 0 means no access

gante_tu(1: VArraysum,1) = 1: VArraysum;
gante_tu(1: VArraysum,2) = 1: VArraysum;

used = zeros(1,VArraysum);   % Use the flag array to distinguish the activity number whose in-degree is 0 and in the execution queue
Alltime = 0;

wait=[];                                     % waiting queue
exe=[];                                      % execution queue
flag_1 = 0;                                  % Execution end flag 1 Execution completed 0 Not executed

in_exe=zeros(1,VArraysum);                   % Used to identify whether it is the first time to enter the execution queue


global Pro_index;

while flag_1 ~= 1
    flag_1 = 0;
    result_max = [];
    % Find out the node whose indegree is 0
    for k = 1 : VArraysum
        if ~indegree(k) && ~visit(k) && ~used(k)
            result_max = [result_max k];
        end
    end
    L = size(result_max,2);       %The number of nodes whose in-degree is 0
    if L == 1 && size(exe,2) == 0
        p = result_max(1);
        visit(p) = 1;
        % Assign human resource to activity R1->R2->R3
        People(Peo_index(Pro_index(1,p):Pro_index(2,p)),end - 1) = 0;
        People_allocate(p).R = Peo_index(Pro_index(1,p):Pro_index(2,p));
        
        enter_time = Alltime;
        if flag_F2 == 2             
            fprintf('time=%d, %d enter \n',enter_time,p);
        end
        gante_tu(p,3) = enter_time;
        % Obtain the average proficiency under the current strategy
        aver_radio = efficiency(People_allocate(p),People);
        Alltime = Alltime + self(p,1)/aver_radio;
        
        quit_time = Alltime;
        % Release occupied human resources
        People(People_allocate(p).R,end - 1) = 1;    
        if flag_F2 == 2
            fprintf('time=%d, %d exit \n',quit_time,p);
        end
        gante_tu(p,4) = quit_time;
        % Node Exit Subtract the out-degree of this node
        for j = 1 : VArraysum 
            if bs(p,j)
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
                %Peo_index(Pro_index(1,p):Pro_index(2,p))
                %sum(visit)
                if sum(People(Peo_index(Pro_index(1,p):Pro_index(2,p)),end-1)) == self(p,3)
                    People(Peo_index(Pro_index(1,p):Pro_index(2,p)),end-1) = 0;
                    People_allocate(p).R = Peo_index(Pro_index(1,p):Pro_index(2,p));
                    exe = [exe p];
                    used(p) = 1;
                    enter_time = Alltime;
                    if flag_F2 == 2
                        fprintf('time=%d, %d enter \n',enter_time,p);
                    end
                    gante_tu(p,3) = enter_time;
                else
                    wait = [wait p];
                end
            end
        end
        time = [];
        for u = 1 : size(exe,2)
            % The reason why you need to use the in_exe array to identify it here is that the time is changed in the structure instead of the array
            % only need to process the activity that enters the execution queue for the first time
            if in_exe(exe(u))==1
                aver_radio = efficiency(People_allocate(exe(u)),People);
                self(exe(u),2) = self(exe(u),1)/aver_radio;
                in_exe(exe(u))=0;
            end
            time = [time self(exe(u),1)];
        end
        [mintime,~] = min(time);                 % Get the minimum time to execute the activity in the queue
        c = [];                                  % c stores the activities that have completed the execution, that is, the activities that should be deleted from the execution queue
        for u = 1 : size(exe,2)
            self(exe(u),1) = self(exe(u),1) - mintime;
            if self(exe(u),1) == 0
                c=[c u];
                visit(exe(u)) = 1;
                % Free up human resources
                People(People_allocate(exe(u)).R,end - 1)=1;
                for j = 1 : VArraysum
                    if bs(exe(u),j)
                        indegree(j) = indegree(j) - 1;
                    end
                end
            end
        end
        Alltime = Alltime + mintime;
        for i = 1:size(c,2)
            quit_time = Alltime;
            if flag_F2 == 2
                fprintf('time=%d, %d exit\n',quit_time,exe(c(i)));
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

% Calculate average proficiency based on manpower allocation
function radio = efficiency(People_allocate,People)
    SumAllocateR = size(People_allocate.R,2);
    RadioAllocateR = sum(People(People_allocate.R,1));
    radio = RadioAllocateR / SumAllocateR;
end





