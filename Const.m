function  VArray= Const()

VArray(1)=16;
%VArray(2)=13;

% The total number of tasks
global VArraysum;

VArraysum = sum(VArray);

% Here R1, R2, R3 standards skills
global R1;
global R2;
global R3;
global People;
global People_num;


% ndicate each person's mastery of A, B, and C jobs respectively. The penultimate column represents whether they are free, 1 means free, 0 means not free
People(1,:)=[1 0.8 0.6 1 1];
People(2,:)=[1 0.8 0.6 1 2];
People(3,:)=[1 0.8 0.6 1 3];
People(4,:)=[0.8 1 0.6 1 4];
People(5,:)=[0.8 1 0.7 1 5];
People(6,:)=[0.8 1 0.7 1 6];
People(7,:)=[0.6 0.8 1 1 7];
People(8,:)=[0.6 0.8 1 1 8];

People_num = size(People,1);

% Sort and choose the one with high proficiency first
sort_people_R1 = sortrows(People, -1);
sort_people_R2 = sortrows(People, -2);
sort_people_R3 = sortrows(People, -3);
% There is a requirement for the proficiency of a person to master technology, that is, it must be greater than 0.5
R1 = sort_people_R1(sort_people_R1(:,1)>0.5,end)';
R2 = sort_people_R2(sort_people_R2(:,2)>0.5,end)';
R3 = sort_people_R3(sort_people_R3(:,3)>0.5,end)';

% Adjacency matrix
global s ;
s = zeros(VArraysum,VArraysum);
%% Project A
s(1,2) = 1;
s(2,3) = 1;
s(3,4) = 1;
s(3,5) = 1;
s(3,6) = 1;
s(4,7) = 1;
s(4,15) = 1;
s(5,8) = 1;
s(6,9) = 1;
s(7,9) = 1;
s(8,10) = 1;
s(9,11) = 1;
s(9,12) = 1;
s(10,13) = 1;
s(11,16) = 1;
s(12,14) = 1;
s(15,10) = 1;
s(16,14) = 1;

%% Project B
% s(17,18) = 1;
% s(18,19) = 1;
% s(18,20) = 1;
% s(18,21) = 1;
% s(19,22) = 1;
% s(19,23) = 1;
% s(19,24) = 1;
% s(20,22) = 1;
% s(20,23) = 1;
% s(20,24) = 1;
% s(21,25) = 1;
% s(22,23) = 1;
% s(24,23) = 1;
% s(23,26) = 1;
% s(25,27) = 1;
% s(26,27) = 1;
% s(27,28) = 1;
% s(28,29) = 1;

% indegree
global indegree;
indegree = zeros(1,VArraysum);
for i= 1: VArraysum
    indegree(i)=sum(s(:,i));
end

% the cost of insourcing
global self;
% global candidate;

% E.g [420 5 3 0 3 1 0];
%[the cost of insourcing; 400
% the time of insourcing; 5
% the resource used; 1
% the number of resources used;]3
self = zeros(VArraysum, 7);
self(1,:)  = [420 5 3 0 3 1 0];
self(2,:)  = [983 0 3 0 0 4 0];
self(3,:)  = [2188 15 0 3 3 0 1];
self(4,:)  = [815.7 0 6 5 0 2 4];
self(5,:)  = [1300 0 11 0 0 2 0];
self(6,:)  = [950 7 0 13 4 0 1];
self(7,:)  = [1856 10 0 10 3 0 2];
self(8,:)  = [693.93 0 5 6 0 3 3];
self(9,:)  = [640.32 0 6 0 0 3 0];
self(10,:) = [1200.90 13 5 10 1 3 2];
self(11,:) = [777.35 0 7 4 0 3 1];
self(12,:) = [1835.84 0 14 0 0 4 0];
self(13,:) = [969.8 10 0 4 2 0 5];
self(14,:) = [500 0 5 6 0 2 3];
self(15,:) = [930 7 5 0 1 3 0];
self(16,:) = [967 0 2 8 0 3 2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Decomposed into single-skill small items
global break_self;      %break_self[The time required for the activity, the type of work required for the activity, the number of people required, the project to which it belongs]
global break_VArraysum;  % Number of items for small items
break_num=1;
for i=1:VArraysum
    for j=5:7
        if self(i,j)>0
            break_self(break_num,:)=[self(i,j-3) j-4 self(i,j) i];
            break_num=break_num+1;
        end
    end
end
break_VArraysum=break_num-1;

% Modify the network diagram
% Decomposed adjacency matrix
global bs;
bs = zeros(break_VArraysum,break_VArraysum);

for i=1:break_VArraysum
    cur = break_self(i,4);
    before=[];
    later=[];
    for j=1:VArraysum
        if s(j,cur)==1
            before=[before j];
        end
        if s(cur,j)==1
            later=[later j];
        end
    end
    
    for j=1:size(before,2)
        for k=1:break_VArraysum
            if break_self(k,4)==before(j)
                bs(k,i)=1;
            end
        end
    end
    for j=1:size(later,2)
        for k=1:break_VArraysum
            if break_self(k,4)==later(j)
                bs(i,k)=1;
            end
        end
    end
end

% in-degree of the new matrix
global break_indegree;
break_indegree=zeros(1,break_VArraysum);
for i= 1: break_VArraysum
    break_indegree(i)=sum(bs(:,i));
end


%%%%%
VArraysum = break_VArraysum;
VArray(1) = break_VArraysum;

global Pro_index;
Pro_index = zeros(2,VArraysum);
Pro_index(1,1) = 1;
Pro_index(2,1) = Pro_index(1,1) + break_self(1,3) - 1;
for i = 2:VArraysum
    Pro_index(1,i) = Pro_index(2,i-1) + 1;
    Pro_index(2,i) = Pro_index(1,i) + break_self(i,3) - 1;
end

end
