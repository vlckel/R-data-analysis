
################################################################################################################
##                                           LOOPING and CONDITIONS                                           ##
################################################################################################################
####################################################
## Prague Analytics Team  (c) - Patrik Manda
## patrik.manda@guycarp.com 
## created 28.1.2020

########## Chapter 1 #################################################################################################################


##################################### 
##### CONDITIONS

### IF / IF...ELSE / IF...ELSE IF...ELSE Statements
# if statement
  x <- 5
  
  if(x > 0) {
    print("Positive number")
  }

# if...else statement
  x <- -5
  
  if(x > 0) {
    print("Non-negative number")
  } else {
      print("Negative number")
  }
  
# if...else ladder
  x <- 0
  
  if (x < 0) {
    print("Negative number")
  } else if (x > 0) {
      print("Positive number")
  } else { #also can say else if x == 0
      print("Zero")
  }


### ifelse() Function
  a <- c(5,7,2,9,4,11)
  
  ifelse(a %% 2 == 0,"even","odd")    # NOTE: ifelse() is vectorized, i.e. it applies condition on every element of the vecor
                                      #       if...else is NOT vectorized, i.e. it works only on a scalar boolean condition 
  
# Does this work?
  if(a %% 2 == 0) {
    "even"
  } else {
      "odd"
  }



########## Chapter 2 #################################################################################################################


##################################### 
##### 'for' LOOPS

# Let's start with basic looping
# First we create simple data frame
  df <- data.frame(a = rnorm(10),     # rnorm(n, mean = 0, sd = 1) ... default parameters
                   b = rnorm(10),
                   c = rnorm(10),
                   d = rnorm(10))
  
# We would like to compute median of each column by copy-pasting:
  m_a <- median(df$a)
  
  m_b <- median(df$b)
  
  m_c <- median(df$c)
  
  m_d <- median(df$d)     # ...imagine you have tens of columns to analyse. A lot of copy-pasting, right?
  
# Or in smarter way - by LOOPING
  m_list <- list()                    # 1. OUTPUT - creates empty list into which we will save our results from every iteration
  
  for (i in 1:ncol(df)) {             # 2. SEQUENCE - determines what to loop over; how many iterations we want to run 
    
    m_list[[i]] <- median(df[ ,i])    # 3. BODY - this is the code that does the work (each iteration with different 'i')
    
  }

  m_list
  
  unlist(m_list)      # puts all components of the list into one vector
  

  
  
########## Chapter 3 #################################################################################################################
  
  
##################################### 
##### 'for' LOOPS with CONDITIONS
  
# Create simple vector, e.g.:
  y <- c(2,5,3,9,8,11,6)
  
# How many even numbers are in vector?
  even_count <- 0                                  # Creates zero variable 'even_count'
  
  for (i in 1:length(y)) {                              # Runs the iteration seven times, i.e. length(y)
    if(y[i] %% 2 == 0)  {even_count = even_count + 1}   # Adds +1 to every iteration, where conditioon was met 
  }
  
  print(even_count)
  

  ########## Chapter 4 #################################################################################################################
  
  
  ##################################### 
  ##### NESTED 'for' LOOPS
  
  # We first define a matrix 
  M <- matrix(1:25, 5, 5)     # matrix(data, nrow, ncol)
  
  # Which elements have identical column number and row number at the same time
  for (i in 1:nrow(M)) {      # running iterations across all rows of M
    for (j in 1:ncol(M)) {    # running iterations across all columns of M
      if (i == j) {
        print(M[i,j])
      }
    }
  }
  
  
################################################################################################################  
### End. 