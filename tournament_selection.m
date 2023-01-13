function f = tournament_selection(chromosome, pool_size, tour_size)
%% Tournament selection process
[pop, variables] = size(chromosome);   % pop表示种群大小
rank = variables - 1;
% 包含拥挤距离
distance = variables;
for i = 1 : pool_size  %选择pop/2个个体加入交配池
    for j = 1 : tour_size
        candidate(j) = round(pop*rand(1));%随机选择一个个体  
        if candidate(j) == 0
            candidate(j) = 1;
        end
        if j > 1
            % Make sure that same candidate is not choosen.
            %保证同样的不被再次选择
            while ~isempty(find(candidate(1 : j - 1) == candidate(j)))
                candidate(j) = round(pop*rand(1));
                if candidate(j) == 0
                    candidate(j) = 1;
                end
            end
        end
    end
    % Collect information about the selected candidates.
    for j = 1 : tour_size
        c_obj_rank(j) = chromosome(candidate(j),rank);
        c_obj_distance(j) = chromosome(candidate(j),distance);
    end
    % Find the candidate with the least rank找到最不合适的候选人
    min_candidate = ...
        find(c_obj_rank == min(c_obj_rank));%返回其下标
 
    if length(min_candidate) ~= 1%如果最小的值不值一个
        max_candidate = ...
        find(c_obj_distance(min_candidate) == max(c_obj_distance(min_candidate)));
        % If a few individuals have the least rank and have maximum crowding
        %如果有几个个体有最小排名而且有最大拥挤距离
        % distance, select only one individual (not at random). 只选择一个个体（不是随意的）
        if length(max_candidate) ~= 1
            max_candidate = max_candidate(1);%就是第一个
        end
        % Add the selected individual to the mating pool 交配池
        f(i,:) = chromosome(candidate(min_candidate(max_candidate)),:);
    else
        % Add the selected individual to the mating pool
        %如果最小值只有一个
        f(i,:) = chromosome(candidate(min_candidate(1)),:);
    end
end
