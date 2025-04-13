%% matlab优势
% 闭源、美观、易学
% 矩阵运算、工学工具箱模型、适合算法设计

% disp("Hello World!");

a = 66;
b = 1:100;

for i = 1:length(b)
    c(i) = b(i) + 1;
end

c;

d = b + 1;


% .* 对应相乘，*矩阵乘法

% 矩阵转置 '
e = 1:2:100; % 步长为2
linspace(1,10,5);

f = ones(3);
f(2,2) = 0;
f(5) = 666;

% 开方
g = ones(3)*4;
h = sqrt(g);

i = ones(3);
j = max(max(i));

% 最大值及其索引
% 可以使用 max 函数确定向量的最大值及其对应的索引值。max 函数的第一个输出为输入向量的最大值。执行带两个输出的调用时，第二个输出为索引值。
[xMax,idx] = max(x)
[vMax,ivMax] = max(v2)


