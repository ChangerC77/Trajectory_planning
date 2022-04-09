% ����·�����Ⱥ���
function [path_value] = cal_path_value(pop, x)
[n, ~] = size(pop);
path_value = zeros(1, n);
for i = 1 : n
    single_pop = pop{i, 1};
    [~, m] = size(single_pop);
    for j = 1 : m - 1
        % ��i�����У������ұ��1.2.3...��
        x_now = mod(single_pop(1, j), x) + 1; 
        % ��i�����У����ϵ��±����1.2.3...��
        y_now = fix(single_pop(1, j) / x) + 1;
        % ��i+1�����С���
        x_next = mod(single_pop(1, j + 1), x) + 1;
        y_next = fix(single_pop(1, j + 1) / x) + 1;
        if abs(x_now - x_next) + abs(y_now - y_next) == 1
            path_value(1, i) = path_value(1, i) + 1;
        else
            path_value(1, i) = path_value(1, i) + sqrt(2);
        end
    end
end
