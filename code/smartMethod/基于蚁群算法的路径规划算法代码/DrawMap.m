%���������ϰ����դ���ͼ
%������1�����ɫդ��

function G = DrawMap(G)
b = G;
b(end+1,end+1) = 0;
colormap([1 1 1;0 0 0]);  % ������ɫ
pcolor(0.5:size(G,2) + 0.5, 0.5:size(G,1) + 0.5, b); % ����դ����ɫ
set(gca, 'XTick', 1:size(G,1), 'YTick', 1:size(G,2));  % ��������
axis image xy;  % ��ÿ��������ʹ����ͬ�����ݵ�λ������һ��