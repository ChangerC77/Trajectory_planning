% �����Ŵ��㷨��դ�񷨻�����·���滮
clc;
clear;
% ��������,��դ���ͼ
G=  [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 1 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 1 1 1 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 1 1 1 0 1 0 1 1 0 0 0 0 0 0;
     0 1 1 1 0 0 0 0 0 0 1 0 1 1 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 1 1 0 1 1 1 1 0 0 0 0 0 0;
     0 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 1 1 1 1 0;
     0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0;
     0 0 1 1 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 0;
     0 0 1 1 0 0 1 1 1 0 1 0 0 0 0 0 0 0 0 0;
     0 0 0 0 0 0 1 1 1 0 1 0 0 0 0 0 0 1 1 0; 
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
%G = [0 0 0 1 0;
%     0 0 0 0 0;
%     0 0 1 0 0;
%     1 0 1 0 0;
%     0 0 0 0 0;];
 
p_start = 0;   % ��ʼ���
p_end = 399;   % ��ֹ���
NP = 200;      % ��Ⱥ����
max_gen = 50;  % ����������
pc = 0.8;      % �������
pm = 0.2;      % �������
%init_path = [];
z = 1;  
new_pop1 = {}; % Ԫ������·��
[y, x] = size(G);
% ��������У������ұ��1.2.3...��
xs = mod(p_start, x) + 1; 
% ��������У����ϵ��±����1.2.3...��
ys = fix(p_start / x) + 1;
% �յ������С���
xe = mod(p_end, x) + 1;
ye = fix(p_end / x) + 1;

% ��Ⱥ��ʼ��step1���ؾ��ڵ�,����ʼ�������п�ʼ���ϣ���ÿ������ѡһ������դ�񣬹��ɱؾ��ڵ�
pass_num = ye - ys + 1;
pop = zeros(NP, pass_num);
for i = 1 : NP
    pop(i, 1) = p_start;
    j = 1;
    % ��ȥ�����յ�
    for yk = ys+1 : ye-1
        j = j + 1;
        % ÿһ�еĿ��е�
        can = []; 
        for xk = 1 : x
            % դ�����
            no = (xk - 1) + (yk - 1) * x;
            if G(yk, xk) == 0
                % �ѵ����can������
                can = [can no];
            end
        end
        can_num = length(can);
        % �����������
        index = randi(can_num);
        % Ϊÿһ�м�һ�����е�
        pop(i, j) = can(index);
    end
    pop(i, end) = p_end;
    %pop
    % ��Ⱥ��ʼ��step2�������ؾ��ڵ�������޼��·��
    single_new_pop = generate_continuous_path(pop(i, :), G, x);
    %init_path = [init_path, single_new_pop];
    if ~isempty(single_new_pop)
       new_pop1(z, 1) = {single_new_pop};
        z = z + 1;
    end
end

mean_path_value = zeros(1, max_gen);
min_path_value = zeros(1, max_gen);
% ѭ����������
for i = 1 : max_gen
    % ������Ӧ��ֵ
    % ����·������
    path_value = cal_path_value(new_pop1, x)
    % ����·��ƽ����
    path_smooth = cal_path_smooth(new_pop1, x)
    fit_value = 1 .* path_value .^ -1 + 1 .* path_smooth .^ -1;
    mean_path_value(1, i) = mean(path_value);
    [~, m] = max(fit_value);
    min_path_value(1, i) = path_value(1, m);
    
    % ѡ�����
    new_pop2 = selection(new_pop1, fit_value);
    % �������
    new_pop2 = crossover(new_pop2, pc);
    % �������
    new_pop2 = mutation(new_pop2, pm, G, x);
    % ������Ⱥ
    new_pop1 = new_pop2;
    
end
% ��ÿ�ε���ƽ��·�����Ⱥ�����·������ͼ
figure(1)
plot(1:max_gen,  mean_path_value, 'r')
hold on;
plot(1:max_gen, min_path_value, 'b')
legend('ƽ��·������', '����·������');
min_path_value(1, end)
% �ڵ�ͼ�ϻ�·��
[~, min_index] = max(fit_value);
min_path = new_pop1{min_index, 1};
figure(2)
hold on;
title('�Ŵ��㷨�������˶��켣'); 
xlabel('����x'); 
ylabel('����y');
DrawMap(G);
[~, min_path_num] = size(min_path);
for i = 1:min_path_num
    % ·���������У������ұ��1.2.3...��
    x_min_path(1, i) = mod(min_path(1, i), x) + 1; 
    % ·���������У����ϵ��±����1.2.3...��
    y_min_path(1, i) = fix(min_path(1, i) / x) + 1;
end
hold on;
plot(x_min_path, y_min_path, 'r')


