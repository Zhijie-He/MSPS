function DEnsga_2(popsize, generation)
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
global VArraysum;                
global break_indegree;                  
global People;
global break_self;

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
    if M == 2
        plot(chromosome(:,V + 1),chromosome(:,V + 2)/10000,'*');
        xlabel('Completion cycle/week');
        ylabel('Project cost/billion');
        xlim([floor(min(chromosome(:,V + 1))) - 5  ceil(max(chromosome(:,V + 1))) + 5]);
        ylim([floor(min(chromosome(:,V + 2)/10000))  ceil(max(chromosome(:,V + 2)/10000)) ]);
        title('Multi-objective pareto diagram based on key resources');
        pause(0.01);
    elseif M ==3                                                           
        clf                                                           
        A=[chromosome(:,V + 1) chromosome(:,V + 2) chromosome(:,V + 3)/10000];
        A=unique(A,'rows');
        x=A(:,1);y=A(:,2);z=A(:,3);
        %data interpolation
        [X,Y,Z]=griddata(x,y,z,linspace(min(x),max(x))',linspace(min(y),max(y)),'v4');
        mesh(X,Y,Z);
        hold on 
        scatter3(x,y,z,'filled');
        xlim([floor(min(chromosome(:,V + 1))) - 5  ceil(max(chromosome(:,V + 1))) + 5]);
        ylim([floor(min(chromosome(:,V + 2))) - 5  ceil(max(chromosome(:,V + 2))) + 5]);
        zlim([floor(min(chromosome(:,V + 3)/10000))+0.2   ceil(max(chromosome(:,V + 3)/10000)) ]);
        xlabel('Project A completion cycle/week');
        ylabel('Project B completion period/week');
        zlabel('Total project cost/billion');
        title('Parato 3D surface plot');
        pause(0.01);
    end
end
%% save result
save solution.txt chromosome -ASCII

%% Visualization
close all                                                                
if M == 2
    figure
    plot(chromosome(:,V + 1),chromosome(:,V + 2)/10000,'*');
    legend('Paroto algorithm');
    legend('boxoff')
    xlim([floor(min(chromosome(:,V + 1))) - 5  ceil(max(chromosome(:,V + 1))) + 5]);
    ylim([floor(min(chromosome(:,V + 2)/10000))   ceil(max(chromosome(:,V + 2)/10000)) ]);
    xlabel('Completion cycle/week');
    ylabel('Project cost/billion');
    title('Multi-objective pareto diagram based on key resources');
    
elseif M ==3    
    figure
    plot3(chromosome(:,V + 1),chromosome(:,V + 2),chromosome(:,V + 3)/10000,'*');
    xlim([floor(min(chromosome(:,V + 1))) - 5  ceil(max(chromosome(:,V + 1))) + 5]);
    ylim([floor(min(chromosome(:,V + 2))) - 5  ceil(max(chromosome(:,V + 2))) + 5]);
    zlim([floor(min(chromosome(:,V + 3)/10000))+0.2   ceil(max(chromosome(:,V + 3)/10000)) ]);
    xlabel('Project A completion cycle/week');
    ylabel('Project B completion period/week');
    zlabel('Project cost/billion');
    title('Parato three-dimensional scatter plot');
    
    figure
    A=[chromosome(:,V + 1) chromosome(:,V + 2) chromosome(:,V + 3)];
    A=unique(A,'rows');                
    x=A(:,1);y=A(:,2);z=A(:,3);
    z=z/10000;
    [X,Y,Z]=griddata(x,y,z,linspace(min(x),max(x))',linspace(min(y),max(y)),'v4');
    mesh(X,Y,Z);
    xlim([floor(min(x)) - 5  ceil(max(x)) + 5]);
    ylim([floor(min(y)) - 5  ceil(max(y)) + 5]);
    zlim([floor(min(z))   ceil(max(z)) ]);
    hold on 
    scatter3(x,y,z,'filled');
    xlabel('Project A completion cycle/week');
    ylabel('Project B completion period/week');
    zlabel('Project cost/billion');
    title('Parato 3D surface plot');

    axis vis3d
    for i=1:60
        pause(0.2);
        camorbit(10,0)
        drawnow
    end
end

[~,sor_index] = sort(chromosome(:,V+3));
shortest = sor_index(end);
test_x = chromosome(shortest,1:VArraysum);
test_Peo_index = chromosome(shortest,VArraysum+1:V);
[~,gante_tu, People_allocate] = TuoPu29F3(test_x,test_Peo_index,break_self,break_indegree,2,People);
fprintf('The above is a time sequence with a total time of %.1f weeks \nThe total cost is %.4f ten thousand yuan\nThe Gantt chart is shown in the figure\n',max(gante_tu(:,4)),chromosome(shortest,V+M));
gante(gante_tu,VArray);

% Save the allocation of human resources and store it in the People_allocate structure
% PeopleAllocate(People_allocate);
% fprintf('The human resource allocation corresponding to this plan is saved in the People_allocate.txt file\n');
end