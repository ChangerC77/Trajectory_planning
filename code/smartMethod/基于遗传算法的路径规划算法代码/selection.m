% �����̶·�ѡ���µĸ���
% ���������popԪ����Ⱥ��fitvalue����Ӧ��ֵ
% ���������newpopѡ���Ժ��Ԫ����Ⱥ
function [new_pop] = selection(pop, fit_value)
%��������
[px, ~] = size(pop);
total_fit = sum(fit_value);
p_fit_value = fit_value / total_fit;
p_fit_value = cumsum(p_fit_value);    % �������
% �������С��������
ms = sort(rand(px, 1));
fitin = 1;
newin = 1;
while newin <= px
    if(ms(newin)) < p_fit_value(fitin)
        new_pop{newin, 1} = pop{fitin, 1};
        newin = newin+1;
    else
        fitin = fitin+1;
    end
end

