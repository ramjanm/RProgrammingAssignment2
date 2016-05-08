# Caching the Inverse of a Matrix in R
# Matrix inversion is usually a costly computation and there may be some benefit to caching the inverse of a matrix rather than compute it repeatedly.
# Below are a pair of functions that are used to create a special object that stores a matrix and caches its inverse.

# This function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(sqrInvMat = matrix()) {
  
    # @sqrInvMat: a square invertible matrix
    # return: a list containing functions to
    #    set the matrix
    #    get the matrix
    #    set the inverse
    #    get the inverse
    # this list is used as the input to cacheSolve()
  
    inv <- NULL
    set <- function(tmpSqrInvMat) {
      # use <<- to assign a value to an object in an environment 
      # different from the current environment. 
      sqrInvMat <<- tmpSqrInvMat
      inv <<- NULL
    }
    get <- function() sqrInvMat
    setInverse <- function(inverse) inv <<- inverse
    getInverse <- function() inv
    list(set = set,
         get = get,
         setInverse = setInverse,
         getInverse = getInverse)
}


# This function computes the inverse of the special "matrix" created by makeCacheMatrix above. If the inverse has already been calculated (and the 
# matrix has not changed), then it should retrieve the inverse from the cache.

cacheSolve <- function(invMatOutput, ...) {
    
    # @invMatOutput: output of makeCacheMatrix()
    # return: inverse of the original matrix input to makeCacheMatrix()
    
    inv <- invMatOutput$getInverse()
    if (!is.null(inv)) {
        message("Getting Cached Data Inverse")
        return(inv)
    }
    # else, calculates the inverse 
    
    mat <- invMatOutput$get()
    inv <- solve(mat, ...)
    # sets the value of the inverse in the cache via the setInverse function.
    invMatOutput$setInverse(inv)
    
    return(inv)
}

# Test fuction to Test above functions 
testFunctions = function(varMatrix){
    # @mat: an invertible matrix
    
    tempVar = makeCacheMatrix(varMatrix)
    start.time = Sys.time()
    cacheSolve(tempVar)
    duration = Sys.time() - start.time
    print(duration)
    # the 2nd time we run the function,we get the cached value
    start.time = Sys.time()
    cacheSolve(tempVar)
    duration = Sys.time() - start.time
    print(duration)
}

# Test Cases
  # TestCase 1
    #   set.seed(1500000)
    #   r = rnorm(2250000)
    #   tmpMatrix = matrix(r, nrow=1500, ncol=1500)
    #   testFunctions(tmpMatrix)
    
    # Test Case 1 Output
      
      # Time difference of 2.818283 secs
      # Getting Cached Data Inverse
      # Time difference of 0 secs

  # TestCase 2
    # > source("cachematrix.R")    load R program
    # > a <- makeCacheMatrix()     create functions
    # > a$set(matrix(1:4, 2, 2))   create matrix in working environment
    # > cacheSolve(a)              1st run returns inverted matrix from working environment
    # [,1] [,2]
    # [1,]   -2  1.5
    # [2,]    1 -0.5
    #
    # > cacheSolve(a)              2nd and subsequent runs
    #                              returns inverted matrix from cache
    # getting cached data          
    # [,1] [,2]
    # [1,]   -2  1.5
    # [2,]    1 -0.5
