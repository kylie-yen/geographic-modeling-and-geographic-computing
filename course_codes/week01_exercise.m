% 1. 创建矩阵 M1
M1 = zeros(10);
for i = 1:10
    M1(:, i) = mod((1:10) - i, 10) + 1;
end
M1(logical(eye(10))) = 1;

% 2. 创建矩阵 B
B = repmat([1; 0], 5, 10);

% 3. M2 = M1 .* B
M2 = M1 .* B;

% 4. M3 = M1 + M2，然后修改第二行的中间八个数为 99，第 9 列的后八个元素改为 nan
M3 = M1 + M2;
M3(2, 2:9) = 99; % 修改第二行的中间八个数为 99
M3(3:10, 9) = nan; % 修改第 9 列的后八个元素为 nan

% 显示结果
disp('M1:');
disp(M1);
disp('B:');
disp(B);
disp('M2:');
disp(M2);
disp('M3:');
disp(M3);
