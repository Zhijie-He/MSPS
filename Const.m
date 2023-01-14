function  VArray= Const()

% Project 1 number of tasks
VArray(1)=16;

% The total number of tasks
global VArraysum;

VArraysum=sum(VArray);

% Here R1, R2, R3 standards skills
global R1;
global R2;
global R3;
global People;

% indicate each person's mastery of A, B, and C jobs respectively. The penultimate column represents whether they are free, 1 means free, 0 means not free
People(1,:)=[1 0.8 0.6 1 1];
People(2,:)=[1 0.8 0.6 1 2];
People(3,:)=[1 0.8 0.6 1 3];
People(4,:)=[0.8 1 0.6 1 4];
People(5,:)=[0.8 1 0.7 1 5];
People(6,:)=[0.8 1 0.7 1 6];
People(7,:)=[0.6 0.8 1 1 7];
People(8,:)=[0.6 0.8 1 1 8];

% Sort and choose the one with high proficiency first
sort_people_R1=sortrows(People,-1);
sort_people_R2=sortrows(People,-2);
sort_people_R3=sortrows(People,-3);
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


% indegree
global indegree;
indegree=zeros(1,VArraysum);
for i= 1: VArraysum
    indegree(i)=sum(s(:,i));
end

% the cost of insourcing
global self;
global candidate;

% self-made cost/10,000 yuan self-made time/week total number of people needed for each technology (R1, R2, R3)
self( 1,:) = [420 5 3 1 0];
self( 2,:) = [983 8 0 4 0];
self( 3,:) = [2188 15 3 0 1];
self( 4,:) = [815.7 6 0 2 4];
self( 5,:) = [1300 11 0 2 0];
self( 6,:) = [950 7 4 0 1];
self( 7,:) = [1856 10 3 0 2];
self( 8,:) = [693.93 6 0 3 3];
self( 9,:) = [640.32 6 0 3 0];
self(10,:) = [1200.90 13 1 3 2];
self(11,:) = [777.35 7 0 3 1];
self(12,:) = [1835.84 14 0 4 0];
self(13,:) = [969.8 10 2 0 5];
self(14,:) = [500 6 0 2 3];
self(15,:) = [930 7 1 3 0];
self(16,:) = [967 8 0 3 2];

% Project A candidate cost and time
candidate(1,1,:) = [670 4];
candidate(1,2,:) = [770 3];
candidate(1,3,:) = [800 2];

candidate(2,1,:) = [1400 6];
candidate(2,2,:) = [1300 7];
candidate(2,3,:) = [1540 5];

candidate(3,1,:) = [2500 14];
candidate(3,2,:) = [3000 9];
candidate(3,3,:) = [3100 7];

candidate(4,1,:) = [950 5];
candidate(4,2,:) = [1000 4];
candidate(4,3,:) = [1288 3];

candidate(5,1,:) = [1500 10];
candidate(5,2,:) = [1700 8];
candidate(5,3,:) = [1800 6];

candidate(6,1,:) = [1000 6];
candidate(6,2,:) = [1300 5];
candidate(6,3,:) = [1400 3];

candidate(7,1,:) = [2000 7];
candidate(7,2,:) = [2200 4];
candidate(7,3,:) = [2300 3];

candidate(8,1,:) = [830 3];
candidate(8,2,:) = [900 2];
candidate(8,3,:) = [1000 1];

candidate(9,1,:) = [680.34 5];
candidate(9,2,:) = [700 4];
candidate(9,3,:) = [800 3];

candidate(10,1,:) = [1400 9];
candidate(10,2,:) = [1500 8];
candidate(10,3,:) = [1600 6];

candidate(11,1,:) = [800 6];
candidate(11,2,:) = [1000 5];
candidate(11,3,:) = [1200 4];

candidate(12,1,:) = [2000 8];
candidate(12,2,:) = [2300.34 6];
candidate(12,3,:) = [2500 5];

candidate(13,1,:) = [1100 8];
candidate(13,2,:) = [1235.43 7];
candidate(13,3,:) = [1300 6];

candidate(14,1,:) = [600.5 5];
candidate(14,2,:) = [700.34 4];
candidate(14,3,:) = [800 3];

candidate(15,1,:) = [980 6];
candidate(15,2,:) = [1200 5];
candidate(15,3,:) = [1300 4];

candidate(16,1,:) = [1000 7];
candidate(16,2,:) = [1300 6];
candidate(16,3,:) = [1500 5];

end
