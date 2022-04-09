%����任
%���������pop��������Ⱥ��pc������ĸ���
%���������newpop����������Ⱥ
function [new_pop] = crossover(pop, pc)
[px,~] = size(pop);
% �ж�·��������������ż��
parity = mod(px, 2);
new_pop = {};
for i = 1:2:px-1
        singal_now_pop = pop{i, 1};
        singal_next_pop = pop{i+1, 1};
        [lia, lib] = ismember(singal_now_pop, singal_next_pop);
        [~, n] = find(lia == 1);
        [~, m] = size(n);
    if (rand < pc) && (m >= 3)
        % ����һ��2-m-1֮��������
        r = round(rand(1,1)*(m-3)) +2;
        crossover_index1 = n(1, r);
        crossover_index2 = lib(crossover_index1);
        new_pop{i, 1} = [singal_now_pop(1:crossover_index1), singal_next_pop(crossover_index2+1:end)];
        new_pop{i+1, 1} = [singal_next_pop(1:crossover_index2), singal_now_pop(crossover_index1+1:end)];
        
    else
        new_pop{i, 1} =singal_now_pop;
        new_pop{i+1, 1} = singal_next_pop;
    end
if parity == 1
    new_pop{px, 1} = pop{px, 1};
end
end
