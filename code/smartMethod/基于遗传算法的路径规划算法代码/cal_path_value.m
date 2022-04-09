% 计算路径长度函数
function [path_value] = cal_path_value(pop, x)
[n, ~] = size(pop);
path_value = zeros(1, n);
for i = 1 : n
    single_pop = pop{i, 1};
    [~, m] = size(single_pop);
    for j = 1 : m - 1
        % 点i所在列（从左到右编号1.2.3...）
        x_now = mod(single_pop(1, j), x) + 1; 
        % 点i所在行（从上到下编号行1.2.3...）
        y_now = fix(single_pop(1, j) / x) + 1;
        % 点i+1所在列、行
        x_next = mod(single_pop(1, j + 1), x) + 1;
        y_next = fix(single_pop(1, j + 1) / x) + 1;
        if abs(x_now - x_next) + abs(y_now - y_next) == 1
            path_value(1, i) = path_value(1, i) + 1;
        else
            path_value(1, i) = path_value(1, i) + sqrt(2);
        end
    end
end
