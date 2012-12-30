function [est,t,name] = mypi(N)
%MYPI compares several computational methods for estimating pi
%
%USAGE
%   mypi uses 20 terms or iterations of variety of computation methods to
%   estimate pi to demonstrate their convergence properties and prints the
%   results to the screen.
%
%   mypi(N) uses N terms or iterations instead of the default, 20.
%
%   ESTIMATE = mypi(N) returns a vector of estimates of pi.
%
%   [ESTIMATE,TIMEELAPSED] = mypi(N) additionally returns the a vector of 
%   time required to arrive at the returned estimates.
%
%   [ESTIMATE,TIMEELAPSED,METHODNAME] = mypi(N) additionally returns a cell
%   array of the names of the methods uses to arrive at the returned
%   estimates.
%
%COMPUTATIONAL METHODS
% 
% # Grid Area
%   By creating an N-gridded square of side length 2 centered at the origin 
%   and computing each grid vertex's distance from the origin, we know the 
%   total number of vertices that are inside the area of the circle, and we
%   can do a Riemann?Stieltjes integral approximation to the area of the 
%   circle using the constructed grid size.
% 
% # Monte Carlo (MC) Area
%   By selecting N random points inside [0,1]x[0,1] and computing their 
%   distance to the origin, we can find the fraction of points that are
%   inside that quarter of the unit circle.  This four times this fraction
%   gives us an estimate of the area of the circle, which, as constructed, 
%   is pi.
%
% # Perimeter
%   By creating a 2N-gon all of whose vertices are along the circumference
%   of a circle of radius one, we can compute exactly its perimiter which
%   will approximate that of the circumscribing circle, which is 2pi.
%
% # Zeta(2)
%   Zeta(s) is given by:
%                            inf
%                           -----
%                           \      1 /
%                           /       / n^s
%                           -----
%                           n = 1
%   Zeta(2) = pi^2/6, so we can truncate this series at n = N to
%   approximate.
%
% # Zeta(4)
%
% # Zeta(10)
%
% # Generalized Continued Fraction (GCF) (3 + ...)
%
% # GCF (4 / ...)
%
%
%INPUTS
%   N <1x1 DOUBLE> denoting the number of terms or iterations to use for in
%   the M utilizied computational methods.
%
%OUTPUTS
%   ESTIMATE <Mx1 DOUBLE> denoting the estimates arrived at by the M
%   utilized computational methods.
%
%   TIMEELAPSED <Mx1 DOUBLE> denoting the time elpased during each of the M
%   utilized computational methods.
%
%   METHODNAME <Mx1 CELL ARRAY of STRINGS> denoting the name of each of the
%   utilized computational methods.
%
%REFERENCES
%   [1] http://en.wikipedia.org/wiki/Approximations_of_%CF%80
%
% See also
%   pi

if nargin < 1, N = 20; end
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