% Natural Spline %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [S,a,b,c,d] = Natural_Spline(X,Y,x)
%size n
    [xn,xm]=size(X);
    [yn,ym]=size(Y);
    
%checking dimensions
    if xm ~= ym
        error('Mismatch of input and output array lengths');
    elseif xn ~= 1 || yn ~= 1
        error('Input and output arrays must only have one row');
    end

n = numel(X);

h = zeros(1,n-1);
alpha = zeros(1,n-2);
a = Y;
b = zeros(1,n);
c = zeros(1,n);
d = zeros(1,n);


for i = 1:n-1
    h(i) = X(i+1) - X(i);
end
h
for i = 2:n-1
    alpha(i) = ((3/h(i))*(a(i+1)-a(i))) - ((3/h(i-1))*(a(i)-a(i-1)));
end


l = zeros(1,n-1);
m = zeros(1,n-2);
z = zeros(1,n-2);

l(1,1) = 1;
m(1,1) = 0;
z(1,1) = 0;

for i = 2:n-1
    l(i) = (2*(X(i+1)-X(i-1)))-(h(i-1)*m(i-1));
    m(i) = h(i)/l(i);
    z(i) = (alpha(i)-(h(i-1)*z(i-1)))/l(i);
end

l(1,n) = 1;
z(1,n) = 0;
c(1,n) = 0;

for j = n-1:-1:1
    c(j) = z(j) - m(j)*c(j+1);
    b(j) = ((a(j+1)-a(j))/h(j)) - ((h(j)/3)*(c(j+1)+2*c(j)));
    d(j) = (c(j+1)-c(j))/(3*h(j));
end

%S(x) interpolated values
for j = 1:n
    if X(j) <=x && x <=X (j+1)
        S = a(j) + b(j)*(x-X(j)) + c(j)*(x-X(j))^2 + d(j)*(x-X(j))^3;
    end
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
