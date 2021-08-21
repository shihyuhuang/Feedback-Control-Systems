%%1.
%a.
num = [1];
den = [1 10];
sys = tf(num,den);
sys_ss = ss(sys)


%b.
num = [1 5 3];
den = [1 8 5];
sys = tf(num,den);
sys_ss = ss(sys)


%c.
num = [1 1];
den = [1 3 3 1];
sys = tf(num,den);
sys_ss = ss(sys)


%%2.
%a.
A = [0 1;2 8];
B = [0;1];
C = [1 0];
D = [0];
sys_ss = ss(A,B,C,D)
sys_tf = tf(sys_ss)


%b.
A = [1 1 0;-2 0 4;5 4 -7];
B = [-1;0;1];
C = [0 1 0];
D = [0];
sys_ss = ss(A,B,C,D)
sys_tf = tf(sys_ss)


%c.
A = [0 1;-1 -2];
B = [0;1];
C = [-2 1];
D = [0];
sys_ss = ss(A,B,C,D)
sys_tf = tf(sys_ss)


%%3.
%a.
a = [0 1 0;0 0 1;-3 -2 -5];
b = [0;0;1];
c = [1 0 0];
d = [0];
sys_ss = ss(a,b,c,d)
sys_tf = tf(sys_ss)

%b.
x0 = [0 -1 1];
t = [0:0.1:10];
u = 0*t;
[y,t,x] = lsim(sys_ss,u,t,x0);
figure
plot(t,x(:,1),t,x(:,2),':',t,x(:,3),'--');
xlabel('time (sec)'),ylabel('x(t)'),grid
title('x1 - solid; x2 - dotted; x3 - dashed')
xf_sim = x(length(t),:)'

%c.
dt = 10;
Phi = expm(a*dt);
xf_phi = Phi*x0'


%%4.
a = [0 1;-2 -3];
b = [0;1];
c = [1 0];
d = [0];
sys = ss(a,b,c,d);
x0 = [1;0];
t = [0:0.1:10];
u = 0*t;
[y,t,x] = lsim(sys,u,t,x0);
figure
plot(t,x(:,1),t,x(:,2),'--');
xlabel('Time (sec)')
ylabel('State Response')
legend('x1','x2')
grid


%%5.
s = sym('s');
K = sym('K');
A = [0 1 0;0 0 1;-2 -K -2];
M = s*eye(3,3) - A;
detQs = det(M)
%detQs = s^3 + 2*s^2 + K*s + 2
K = 0:100;
reals1 = [];
reals2 = [];
reals3 = [];
imags1 = [];
imags2 = [];
imags3 = [];

for i = 1:length(K)
    rs = roots([1 2 K(i) 2]);
    reals1(i) = real(rs(1));
    imags1(i) = imag(rs(1));
    reals2(i) = real(rs(2));
    imags2(i) = imag(rs(2));
    reals3(i) = real(rs(3));
    imags3(i) = imag(rs(3));
end

figure
plot(K,reals1)
hold on
plot(K,imags1,'r')
xlabel('K')
ylabel('value')
legend('reals1','imags1')

figure
plot(K,reals2)
hold on
plot(K,imags2,'r')
xlabel('K')
ylabel('value')
legend('reals2','imags2')

figure
plot(K,reals3)
hold on
plot(K,imags3,'r')
xlabel('K')
ylabel('value')
legend('reals3','imags3')

figure
plot(K,reals1)
hold on
plot(K,reals2,'r')
hold on
plot(K,reals3,'g')
hold on
xlabel('K')
ylabel('value')
legend('reals1','reals2','reals3')

