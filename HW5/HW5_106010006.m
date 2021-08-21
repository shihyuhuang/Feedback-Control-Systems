clear all
clc

m=10;
M=100;
L=1;
g=9.81;

KD = -100
KI = -30
KP = -((M+m)*g)-((KI/KD)*M*L)-30


r = 0;
fun = @(t,x) [x(2); -m*g*x(4)/M; x(4); x(5); (M+m)*g*x(4)/(M*L)]+ (-KP*x(4)-KI*x(3)-KD*x(5))*[0; 1/M; 0; 0; -1/(M*L)];
T = linspace(0, 4*15, 4*1e3);
x0 = [0; 0; 0; 1; 0];
[t, Y] = ode45(@(t,x) fun(t,x), T, x0);

u = (-KP.*Y(:,4)) + (-KI.*Y(:,3)) + (-KD.*Y(:,5));


figure;
plot(t, u);
xlabel('Time'); ylabel('Angular rotation [rad]');
legend(["Input"]);
figure;
plot(t, Y(:,4));
xlabel('Time'); ylabel('Angular rotation [rad]');
legend(["Output"]);
figure;
plot(t, Y(:,1));
xlabel('Time'); ylabel('Position');
legend(["Output"]);
figure;
plot(t, Y(:,4), t, u);
xlabel('Time'); ylabel('Angular rotation [rad]');
legend(["Output"], ["Input"]);

syms x;
digits(6)
eqn = M*L*x^3-KD*x^2-((M+m)*g+KP)*x-KI == 0;
s = solve(eqn,x);
vpa(s)
 
num1 = [-1/(M*L)]; 
den1 = [1 0 -(M+m)*g/(M*L)]; 
G = tf(num1,den1);
 
C = pid(KP,KI,KD)
 
sys = series(C,G);
T_sys = feedback(sys,1)

[num] = T_sys.num;
num = cell2mat(num);
 
[den] = T_sys.den;
den = cell2mat(den);
 
pole(T_sys)

figure
zplane(num,den);




