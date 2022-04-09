% �������
% ����˵��
% ���������pop����Ⱥ��pm���������
% ���������newpop�����Ժ����Ⱥ
function [new_pop] = mutation(pop, pm, G, x)
[px, ~] = size(pop);
new_pop = {};
for i = 1:px
    % ��ʼ������������
    max_iteration = 0;
    single_new_pop = pop{i, 1};
    [~, m] = size(single_new_pop);
    % single_new_pop_slice��ʼ��
    single_new_pop_slice = [];
    if(rand < pm)
        while isempty(single_new_pop_slice)
            % ����2-��m-1�������������,������
            mpoint = sort(round(rand(1,2)*(m-3)) + [2 2]);
            single_new_pop_slice = [single_new_pop(mpoint(1, 1)-1) single_new_pop(mpoint(1, 2)+1)];
            single_new_pop_slice = generate_continuous_path(single_new_pop_slice, G, x);
            %max_iteration = max_iteration + 1;
            if max_iteration >= 100000
                break
            end
        end
        if max_iteration >= 100000
            new_pop{i, 1} = pop{i, 1};
        else
            new_pop{i, 1} = [single_new_pop(1, 1:mpoint(1, 1)-1), single_new_pop_slice(2:end-1), single_new_pop(1, mpoint(1, 2)+1:m)];
        end
        % single_new_pop_slice�ٴγ�ʼ��
        single_new_pop_slice = [];
    else
        new_pop{i, 1} = pop{i, 1};
    end
end