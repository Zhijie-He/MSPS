function f  = genetic_operator(parent_chromosome,M,V,generation,current_gen,VArray)

[N,~] = size(parent_chromosome);       % N��¼�˽���ص�����
p = 1;
global VArraysum;                      % ��Ŀ�ܸ���
global Pro_index;
Pro_index2 = Pro_index + VArraysum;
F0 = 0.4;                              % ��ʼ��������
CR = 0.8;                              % ��������
%% �������
%generationΪ�ܴ���Ŀ   current_genΪ��ǰ����Ŀ
lamda = exp(1-generation/(generation+1-current_gen));
F = F0*2^(lamda);                        % ����Ӧ��������

% N��ʾ�ж�����
for i = 1 : N
    parent_1 = randi(N,1,1);   % �������1-VArraysum֮�ڵ���
    parent_2 = randi(N,1,1);
    parent_4 = randi(N,1,1);
    %��֤ѡ��Ĳ���ͬһ��
    while(parent_1 == parent_2 || parent_1 == parent_4 || parent_2 == parent_4)
        parent_1 = randi(N,1,1);
        parent_2 = randi(N,1,1);
        parent_4 = randi(N,1,1);
    end
    %���ڲ������ظ���Ⱦɫ�� ���ǲ��ò���һ�½���PMX  ��Ҫ����ͻ���  ��OX��PBX�ȵȲ���Ҫ
    %������򵥵�SEC Subtour Exchange Crossover���淽��   ���� ��Ⱥ�Ķ����Ծͺ��˺ܶ�
    % �����ȼ����н���
    child_1 = parent_chromosome(parent_1,:);
    child_2 = parent_chromosome(parent_2,:);
    if CR > rand
        r1_1=randi(VArraysum,1,1);
        r1_2=randi(VArraysum,1,1);
        
        while isequal(r1_1,r1_2)
            r1_2=randperm(VArraysum,1);
        end
        % ��������������ȵ�ֵ ��Ϊ������λ��
        r1 = min(r1_1,r1_2);
        r2 = max(r1_1,r1_2);
        % ����SEC����
        c=[];
        for j = r1:r2
            c=[c find(child_2(1:VArraysum) == child_1(j))];
        end
        c=sort(c);
        if size(c,2) ~= 0
            for j = r1:r2
                temp = child_1(j);
                child_1(j) = child_2(c(j-r1+1));
                child_2(c(j-r1+1)) = temp;
            end
        end
        
        % ���ж�Ӧ����
        temp = child_1(Pro_index2(r1):Pro_index2(r2));
        child_1(Pro_index2(r1):Pro_index2(r2)) = child_2(Pro_index2(r1):Pro_index2(r2));
        child_2(Pro_index2(r1):Pro_index2(r2)) = temp;
    end
    
    
    if F > rand
        %% �������
        r1_1=randi(VArraysum,1,1);
        r1_2=randi(VArraysum,1,1);
        
        while isequal(r1_1,r1_2)
            r1_2=randperm(VArraysum,1);
        end
        % ��������������ȵ�ֵ ��Ϊ���������λ��
        r1 = min(r1_1,r1_2);
        r2 = max(r1_1,r1_2);
        
        temp = child_1(r1);
        child_1(r1) = child_1(r2);
        child_1(r2) = temp;
        
        temp = child_2(r1);
        child_2(r1) = child_2(r2);
        child_2(r2) = temp;
    end
    

    
    %��������ĸ�����Ӧ��ֵ  ������Ŀ�꺯��ֵ
    [child_1,child_1(:,V + 1: M + V)] = evaluate(child_1, M, V,VArray);
    [child_2,child_2(:,V + 1: M + V)] = evaluate(child_2, M, V,VArray);
    
    child(p,:) = child_1;
    child(p+1,:) = child_2;
    p = p + 2;
end
f = child;