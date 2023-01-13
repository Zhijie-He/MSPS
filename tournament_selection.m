function f = tournament_selection(chromosome, pool_size, tour_size)
%% Tournament selection process
[pop, variables] = size(chromosome);   % pop��ʾ��Ⱥ��С
rank = variables - 1;
% ����ӵ������
distance = variables;
for i = 1 : pool_size  %ѡ��pop/2��������뽻���
    for j = 1 : tour_size
        candidate(j) = round(pop*rand(1));%���ѡ��һ������  
        if candidate(j) == 0
            candidate(j) = 1;
        end
        if j > 1
            % Make sure that same candidate is not choosen.
            %��֤ͬ���Ĳ����ٴ�ѡ��
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
    % Find the candidate with the least rank�ҵ�����ʵĺ�ѡ��
    min_candidate = ...
        find(c_obj_rank == min(c_obj_rank));%�������±�
 
    if length(min_candidate) ~= 1%�����С��ֵ��ֵһ��
        max_candidate = ...
        find(c_obj_distance(min_candidate) == max(c_obj_distance(min_candidate)));
        % If a few individuals have the least rank and have maximum crowding
        %����м�����������С�������������ӵ������
        % distance, select only one individual (not at random). ֻѡ��һ�����壨��������ģ�
        if length(max_candidate) ~= 1
            max_candidate = max_candidate(1);%���ǵ�һ��
        end
        % Add the selected individual to the mating pool �����
        f(i,:) = chromosome(candidate(min_candidate(max_candidate)),:);
    else
        % Add the selected individual to the mating pool
        %�����Сֵֻ��һ��
        f(i,:) = chromosome(candidate(min_candidate(1)),:);
    end
end
