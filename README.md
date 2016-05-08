# Introduction -Programming Assignment 2: Lexical Scoping

The following code demonstrates how to use the cachematrix.R  R script.

Test Case 1

set.seed(1500000)

r = rnorm(2250000)

tmpMatrix = matrix(r, nrow=100, ncol=1500)

summary(a);

>              Length Class  Mode    

> set          1      -none- function

> get          1      -none- function

> setInverse   1      -none- function

> getInverse   1      -none- function

testFunctions(tmpMatrix)

> Time difference of 2.763114 secs

> Getting Cached Data Inverse

> Time difference of 0.0009610653 secs


Test Case 2

create a *square* matrix (because 'solve'' only handles square matrices)

create the matrix during the call of makeCacheMatrix()

a <- makeCacheMatrix( matrix(c(11,22,33,44), nrow = 2, ncol = 2) );


summary(a);

>              Length Class  Mode    

> set          1      -none- function

> get          1      -none- function

> setInverse   1      -none- function

> getInverse   1      -none- function

a$get();

>      [,1] [,2]

> [1,]    11   33

> [2,]    22   44


cacheSolve(a)

> [,1]        [,2]

> [1,] -0.18181818   0.13636364

> [2,]  0.09090909  -0.04545455

2nd time we run the function,we get the cached value

cacheSolve(a)

> getting cached data

> [,1]        [,2]

> [1,] -0.18181818   0.13636364

> [2,]  0.09090909  -0.045454559
