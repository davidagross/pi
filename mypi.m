function [est,t,name] = mypi(N)
if ~exist('N','var'), N = 20; end
est = [];
t = [];
name = {};
%% Area (Square Cells)
name{end+1} = 'grid area';
tic
[X,Y] = meshgrid(linspace(-1,1,N),linspace(-1,1,N));
D = X.^2 + Y.^2;
nIn = sum(D(:)<1);
est(end+1,1) = nIn*(2/(N-1))^2;
t(end+1,1) = toc;
%% Area (Monte Carlo)
name{end+1} = 'mc area';
tic
in = 0;
for i = 1:N
   x = rand; y = rand;
   d = x^2 + y^2;
   in = in + (d<1);
end
est(end+1,1) = 4*in/i;
t(end+1,1) = toc;
%% Perimeter (Vertical Strips)
name{end+1} = 'perimeter';
tic
p = 0;
x = linspace(0,1,N);
for i = 1:N-1
   dx = x(i+1)-x(i);
   dy = sqrt(1-x(i+1)^2) - sqrt(1-x(i)^2);
   h = sqrt(dx^2+dy^2);
   p = p + h;
end
est(end+1,1) = 2*p;
t(end+1,1) = toc;
%% Zeta(2)
name{end+1} = 'zeta(2)';
tic
piSquaredOverSix  = sum(1./(1:N).^2);
est(end+1,1) = sqrt(6*piSquaredOverSix);
t(end+1,1) = toc;
%% Zeta(4)
name{end+1} = 'zeta(4)';
tic
pi4Over90  = sum(1./(1:N).^4);
est(end+1,1) = sqrt(sqrt(90*pi4Over90));
t(end+1,1) = toc;
%% Zeta(10)
name{end+1} = 'zeta(10)';
tic
pi10Over93555  = sum(1./(1:N).^10);
est(end+1,1) = (93555*pi10Over93555)^(1/10);
t(end+1,1) = toc;
%% generalized continued fraction
name{end+1} = 'gcf (3 + ...)';
tic
for n = (N:-1:0)*2+1
   p = n^2/(6 + p); 
end
est(end+1,1) = 3 + p;
t(end+1,1) = toc;
%% generalized continued fraction
name{end+1} = 'gcf (4 / ...)';
tic
for n = (N:-1:1)
   p = n^2/(2*n+1 + p); 
end
est(end+1,1) = 4/(1+p);
t(end+1,1) = toc;
%% print it
prec = floor(-log10(abs(pi - est)));
fprintf('\nMethods:\n');
disp(name(:));
fprintf('    Value    |  t (µsec)  | digits | t per digit\n');
fprintf('%11.10f | %10.3f | %6i | %8.3f \n', ...
    [est(:)';t(:)'/1e-6;prec(:)';t(:)'/1e-6./prec(:)']);