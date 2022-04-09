% ���ؾ��ڵ�������޼��·��
function [single_new_pop] = generate_continuous_path(single_pop, G, x)
i = 1;
single_new_pop = single_pop;
[~, single_path_num] = size(single_new_pop);
while i ~= single_path_num
    % ��i�����У������ұ��1.2.3...��
    x_now = mod(single_new_pop(1, i), x) + 1; 
    % ��i�����У����ϵ��±����1.2.3...��
    y_now = fix(single_new_pop(1, i) / x) + 1;
    % ��i+1�����С���
    x_next = mod(single_new_pop(1, i + 1), x) + 1;
    y_next = fix(single_new_pop(1, i + 1) / x) + 1;
    
    % ��ʼ������������
    max_iteration = 0;
    
    % �жϵ�i��i+1�Ƿ�����,������������ֵ
    while max(abs(x_next - x_now), abs(y_next - y_now)) > 1
        x_insert = floor((x_next + x_now) / 2);
        y_insert = floor((y_next + y_now) / 2);
        
        % ����դ��Ϊ����դ��
        if G(y_insert, x_insert) == 0  
            % դ�����
            num_insert = (x_insert - 1) + (y_insert - 1) * x;
            % ���������
            single_new_pop = [single_new_pop(1, 1:i), num_insert, single_new_pop(1, i+1:end)];
            
        % ����դ��Ϊ�ϰ���դ��
        else   
            % ������
            if G(y_insert, x_insert - 1) == 0 && ((x_insert - 2) + (y_insert - 1) * x ~= single_new_pop(1, i)) && ((x_insert - 2) + (y_insert - 1) * x ~= single_new_pop(1, i+1))
                x_insert = x_insert - 1;
                % դ�����
                num_insert = (x_insert - 1) + (y_insert - 1) * x;
                % ���������
                single_new_pop = [single_new_pop(1, 1:i), num_insert, single_new_pop(1, i+1:end)];
                               
            % ������    
            elseif G(y_insert, x_insert + 1) == 0 && (x_insert + (y_insert - 1) * x ~= single_new_pop(1, i)) && (x_insert + (y_insert - 1) * x ~= single_new_pop(1, i+1))
                x_insert = x_insert + 1;
                % դ�����
                num_insert = (x_insert - 1) + (y_insert - 1) * x;
                % ���������
                single_new_pop = [single_new_pop(1, 1:i), num_insert, single_new_pop(1, i+1:end)];
                
            % ������
            elseif G(y_insert + 1, x_insert) == 0 && ((x_insert - 1) + y_insert * x ~= single_new_pop(1, i)) && ((x_insert - 1) + y_insert * x ~= single_new_pop(1, i+1))
                y_insert = y_insert + 1;
                % դ�����
                num_insert = (x_insert - 1) + (y_insert - 1) * x;
                % ���������
                single_new_pop = [single_new_pop(1, 1:i), num_insert, single_new_pop(1, i+1:end)];

            % ������
            elseif  G(y_insert - 1, x_insert) == 0 && ((x_insert - 1) + (y_insert - 2) * x ~= single_new_pop(1, i)) && ((x_insert - 1) + (y_insert-2) * x ~= single_new_pop(1, i+1))
                y_insert = y_insert - 1;
                % դ�����
                num_insert = (x_insert - 1) + (y_insert - 1) * x;
                % ���������
                single_new_pop = [single_new_pop(1, 1:i), num_insert, single_new_pop(1, i+1:end)];
                
            % ���������ȥ��·��
            else
                %break_pop = single_new_pop
                single_new_pop = [];
                break
            end    
        end
        
        x_next = x_insert;
        y_next = y_insert;
        max_iteration = max_iteration + 1;
        if max_iteration > 20000
            single_new_pop = [];
            break
        end
        
    end
    
    if isempty(single_new_pop)
        break
    end
    
    [~, single_path_num] = size(single_new_pop);
    i = i + 1;
end