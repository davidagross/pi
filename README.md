mypi
==

A comparison of some of my favorite computational methods for estimating the 
ratio of a circle's circumference to its diameter.

USAGE
--

mypi uses 20 terms or iterations of various computational methods to
estimate pi to demonstrate their convergence properties and prints the
results to the screen.

COMPUTATIONAL METHODS
--

* Grid Area
   By creating an N-gridded square of side length 2 centered at the origin 
   and computing each grid vertex's distance from the origin, we know the 
   total number of vertices that are inside the area of the circle, and we
   can do a Riemann?Stieltjes integral approximation to the area of the 
   circle using the constructed grid size.
 
* Monte Carlo (MC) Area
   By selecting N random points inside [0,1]x[0,1] and computing their 
   distance to the origin, we can find the fraction of points that are
   inside that quarter of the unit circle.  This four times this fraction
   gives us an estimate of the area of the circle, which, as constructed, 
   is pi.

* Perimeter
   By creating a 2N-gon all of whose vertices are along the circumference
   of a circle of radius one, we can compute exactly its perimiter which
   will approximate that of the circumscribing circle, which is 2pi.

* Zeta(2)
   Zeta(s) is given by:
```                            
                   inf
                  -----
                  \      1 /
     zeta(s)  =   /       / n^s
                  -----
                  n = 1
```
   Zeta(2) = pi^2/6, so we can truncate this series at n = N to
   approximate.

* Zeta(4) = pi^4/90, so we can truncate the series at n = N to
   approximate.

* Zeta(10) = pi^10/93555, so we can truncate the series at n = N to
   apprixmate.

* Generalized Continued Fraction (GCF) [3 + ...] & [4 / ...]
   These are implementations of the patterned generalized continued 
   fractions provided in [1].

REFERENCES
--

[1] http://en.wikipedia.org/wiki/Approximations_of_%CF%80
