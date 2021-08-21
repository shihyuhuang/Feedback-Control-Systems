%1. done
%{
% -----Phase lag + RL-----

clc;clear;close ALL;

G = tf([1],conv([1 7 10],[1 8]))
% 1.determine k to meet the spec, except ess
damp = 0.7;
% observe original RL
figure
rlocus(G)
sgrid(damp,100);
legend('before')
k = 53.4
% 2.determine alpha = Z/P to meet ess
alpha = 19/k*80;
% 3.place Z close to origin
z = 0.1
% 4.p = Z/alpha
p = z/alpha
Gc = k*tf([1 z],[1 p]);
L = Gc*G;
figure
rlocus(L/k);
sgrid(damp,100);
T = feedback(L,1);
stepinfo(T)
figure
step(T)
%step =0.949 P.O.=0
%[53.4 0.1 0.0035]
%}


%2. done
%{
% -----Phase lead + Bode-----

clc;clear;close ALL;

G = tf([130],[1 7 0])
want_PM = 55;
% 1. select gain k to meet ess/Kv
k = 30/130*7
% observe original Bode
figure 
margin(k*G)
legend('before')
% 2.select additional phase phi<70 
old_PM = 27.1;
phi_m = want_PM-old_PM+6;
phi_m = phi_m*pi/180;
% 3.determined Wm
alpha = (1+sin(phi_m))/(1-sin(phi_m));
x = -10*log10(alpha) %look before figure which frequency has margin x 
Wm = 20;
% 4. evaluate P & Z
p = Wm*alpha^0.5
z = p/alpha
Gc = k*p/z*tf([1 z],[1 p]);
L = G*Gc;
figure
margin(L)
legend('after')
T = feedback(L,1);
t = [0:0.1:100];
u = t;
figure
lsim(T,u,t);
figure
step(T)
k_new = k*p/z
%step ess =0, ramp=99.97, PM=54.1
%k = [5.6898 10.6566 37.5355]
%}


%3. done
%{
% -----PI + RL-----

clc;clear;close ALL;

G = tf([1 4],conv([0.14 1.0238 0.17],[1 13]))
damp = 0.38;
% observe orginal RL
figure
rlocus(G)
sgrid(damp,100);
legend('before')
% 1.place Z
z = 2
Gc = tf([1 z],[1 0]);
L = G*Gc;
figure
rlocus(L)
sgrid(damp,100);
legend('before')
% 2.select k to meet spec
k = 60
figure
margin(k*L)
T = feedback(k*L,1);
stepinfo(T)
figure
step(T)
%step =1, Ts=0.8823, PM=38.7
%[60 2 0]
%}


%4. done
%{
% -----Phase lag + Bode-----

clc;clear;close ALL;

G = tf([520],[1 7 8 0])
want_PM = 61;
% 1.select k to meet ess/Kv
k = 50*8/520
% 2.select new frequency Wc which is meet margin+5
% x+180>=PM+5
x = want_PM-180+5 %find which Wc is at phase x
figure
margin(k*G)
legend('before')
Wc = 0.488;
% 3.determine magnitude M at Wc
M = 39.8;
% 4. evaluate Z/P
z = Wc/10
alpha = 10^(M/20);
p = z/alpha
Gc = k*p/z*tf([1 z],[1 p]);
L = Gc*G;
figure
margin(L)
legend('after')
T = feedback(L,1);
figure
step(T)
k_new = k*p/z
%step = 1, PM = 60.7
%[0.0079 0.0488 0.00049937]
%}


%5. done
%{
% -----Phase lead + RL-----

clc;clear;close ALL;

G = tf([3.8],conv([1 0.17],[0.14 1]))
damp = 0.6;
% observe original RL
figure
rlocus(G)
sgrid(damp,100);
legend('before')
% 1. place Z to the left of the first two real poles of G(s)
z = 4
% 2. selet P to the left of Z
p = 11
Gc = tf([1 z],[1 p]);
L = G*Gc;
figure
rlocus(L)
sgrid(damp,100);
legend('after')
% 3. evaluate K=f(P,Z), choose K
k = 7.5
L = k*L;
T = feedback(L,1);
figure
step(T)
stepinfo(T)
%Ts = 0.6014, P0 = 9.5163
%[7.5 4 11]
%}
