%%1.
x =[[2  1+2*1i ],
   [-0.45  5 ]]

z1 = 1/2*log(x+sqrt(1+x^2))+eye(2)

%%2.
A = [[12 34 -4],
     [34 7 87],
     [3 65 7]]
B = [[1 4 7],
    [2 5 8],
    [3 6 9]]
%a
z2 = A*B
%b
z3 = A.*B
%c
z4 = A^3
%d
z5 = A.^3
%e
z6 = [A([1,3],:);B^2]
%f
z7 = eig(B)
%g
z8 = det(A)

%%3.
%1
A3 = [[1/2 1/3 1/4],
      [1/3 1/4 1/5],
      [1/4 1/5 1/6]]
  
C3 = [0.95 0.67 0.52].'
B3 = A3\C3

x1 = B3(1)
x2 = B3(2) 
x3 = B3(3)
%2
A3 = [[1/2 1/3 1/4],
      [1/3 1/4 1/5],
      [1/4 1/5 1/6]]
  
C3 = [0.95 0.67 0.53].'
B3 = A3\C3

x1 = B3(1)
x2 = B3(2) 
x3 = B3(3)

%%4.
H = hilb(9)

%%5.
subplot(1,2,1)
fplot(@(x) -sqrt(cos(x))+3,[-pi/2,pi/2])
title('-sqrt(cos(x))+3');
xlabel('x');

subplot(1,2,2)
syms x y
ezplot((x.^2/(2^2))-(y.^2/(4^2)),[-2,2,-4,4])

