function DEnsga_2(popsize,generation)
clc
close all;

if nargin < 2
    error('Argument error:: Please enter the population size and number of generations as input arguments.');
end

if rem(popsize,1) ~= 0 || rem(generation,1) ~= 0|| popsize <=0 || generation <=0
    error('Argument error: Population size and evolutionary algebra are non-zero integers greater than zero');
end

if popsize < 20
    error('Argument error: Minimum population for running this function is 20');
end

if generation < 10
    error('Argument error: Minimum number of generations is 5');
end

% Get const values
VArray = Const();
global R1;                         
global R2; 
global R3;                       
global VArraysum;                  % The number of project tasks
global indegree;                   
global self;                       
global candidate;                  
global People;

%% Objective Function
[M, V, ~, ~] = objective_description();

%% Initialize the population
chromosome = initialize(popsize, M, V,VArray);

%% Sort the initialized population
chromosome = non_domination_sort_mod(chromosome, M, V);

%% Start the evolution process
for i = 1 : generation
    pool = round(popsize/2);
    tour = 2;
    parent_chromosome = tournament_selection(chromosome, pool, tour);     
    % intermediate_chromosome is a concatenation of current population and the offspring population
    offspring_chromosome = genetic_operator(parent_chromosome,M,V,generation,i,VArray);
    
    [main_pop,~] = size(chromosome);
    [offspring_pop,~] = size(offspring_chromosome);                       
    
    intermediate_chromosome(1:main_pop,:) = chromosome;                   
   
    intermediate_chromosome(main_pop + 1 : main_pop + offspring_pop,1 : M+V) = offspring_chromosome(:,1:M+V);
    
     % Non-domination-sort of intermediate population
    intermediate_chromosome = non_domination_sort_mod(intermediate_chromosome, M, V);
    
    chromosome = replace_chromosome(intermediate_chromosome, M, V, popsize);
    
    fprintf('%d generations completed\n',i);
    plot(chromosome(:,V + 1),chromosome(:,V + 2)/10000,'*');
    xlabel('Completion time/week');
    ylabel('Project cost/billion');
    xlim([floor(min(chromosome(:,V + 1))) - 5  ceil(max(chromosome(:,V + 1))) + 5]);
    ylim([floor(min(chromosome(:,V + 2)/10000))  ceil(max(chromosome(:,V + 2)/10000)) ]);
    title('Multi-objective pareto diagram based on multi-skill and key resources');
    
    % record as gif
    set(gcf,'color','w'); % set figure background to white
    drawnow;
    frame = getframe(1);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    outfile = 'images/MSPS_generation_2d.gif';
    % On the first loop, create the file. In subsequent loops, append.
    if i==1
        imwrite(imind, cm, outfile,'gif','DelayTime',0,'loopcount',inf);
    else
        imwrite(imind, cm, outfile,'gif','DelayTime',0,'writemode','append');
    end
end
%% save result
save solution.txt chromosome -ASCII

%% Visualization
close all                                                                 
figure
plot(chromosome(:,V + 1),chromosome(:,V + 2)/10000,'*');
legend('Paroto algorithm');
legend('boxoff')
xlim([floor(min(chromosome(:,V + 1))) - 5  ceil(max(chromosome(:,V + 1))) + 5]);
ylim([floor(min(chromosome(:,V + 2)/10000))   ceil(max(chromosome(:,V + 2)/10000)) ]);
xlabel('Completion time/week');
ylabel('Project cost/billion');
title('Multi-objective pareto diagram based on multi-skill and key resources');


[~,sor_index]=sort(chromosome(:,V+3));
shortest=sor_index(end);
test_x=chromosome(shortest,1:VArraysum);
test_index=chromosome(shortest,VArraysum+1:VArraysum*2);
test_part=chromosome(shortest,VArraysum*2+1:VArraysum*3);
[~,gante_tu,People_allocate]=TuoPu29F3(test_x,test_index,test_part,self,candidate,indegree,R1,R2,R3,2,People);
fprintf('The above is a time sequence with a total time of %.1f weeks \nThe total cost is %.4f ten thousand yuan\n The Gantt chart is shown in the figure\n',max(gante_tu(:,4)),chromosome(shortest,V+M));
gante(gante_tu,VArray);
% Save the allocation of human resources and store it in the People_allocate structure
PeopleAllocate(People_allocate);
fprintf('The human resource allocation corresponding to this plan is saved in the People_allocate.txt file\n');
end