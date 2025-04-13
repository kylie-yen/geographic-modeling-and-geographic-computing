%% 初始简单模型
N = 100; % 总人数
lambda = 0.046; 
x0 = 1; % 初始值

syms x(t);
eqn = diff(x,t) == lambda.*x;
cond = x(0) == x0;
ySol(t) = dsolve(eqn, cond);

fplot(ySol, [0,100], 'r', 'LineWidth',2)
hold on % 画图时，画第二条线时不清除前面的画
fplot(N-ySol, [0,100], 'g', 'LineWidth',2)
hold off % 结束

legend('感染者I','健康者S')

%% SI模型
N = 100; % 总人数
lambda = 0.1; 
x0 = 1; % 初始值

syms x(t);
eqn = diff(x,t) == lambda.*(1-x./N).*x; % 新模型
cond = x(0) == x0;
ySol(t) = dsolve(eqn, cond)

fplot(ySol, [0,100], 'r', 'LineWidth',2)
hold on % 画图时，画第二条线时不清除前面的画
fplot(N-ySol, [0,100], 'g', 'LineWidth',2)
hold off % 结束

legend('感染者I','健康者S')

%% SIS模型
N = 100; % 总人数
lambda = 0.1; 
x0 = 1; % 初始值
mu = 0.02; %日康复率

syms x(t);
eqn = diff(x,t) == lambda.*(1-x./N).*x-mu.*x; % 新模型
cond = x(0) == x0;
ySol(t) = dsolve(eqn, cond)

fplot(ySol, [0,100], 'r', 'LineWidth',2)
hold on % 画图时，画第二条线时不清除前面的画
fplot(N-ySol, [0,100], 'g', 'LineWidth',2)
hold off % 结束

legend('感染者I','健康者S')

%% SIR
N = 100;
lambda = 0.05;
mu = 0.01;
x0 = 1

syms S(t) I(t) R(t)
eqs = [ diff(S,t)== - lambda.*I.*S./N;...
diff(I,t)== lambda.*I.*S./N - mu.*I;...
diff(R,t)== mu.*I];


vars = [S(t) I(t) R(t) ];


[M,F] = massMatrixForm(eqs,vars);
F = odeFunction(F,vars)
[t,y] = ode45(F, [1 800],[N x0 0]);



plot(y(:,1),'g','LineWidth',2)
hold on
plot(y(:,2),'r','LineWidth',2)
plot(y(:,3),'b','LineWidth',2)
hold off
legend('健康者S','感染者I','移出者R')
