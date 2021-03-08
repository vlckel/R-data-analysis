
################################################################################################################
##                                                Intro into R                                               ##
################################################################################################################
####################################################
## Prague Analytics Team  (c) - Eliska Vlckova 
## eliska.vlckova@guycarp.com 
## created 21.11.2019


########## Chapter 1 #################################################################################################################

##################################### 
##### R session management

## !!! In RStudio run through line-by-line using Ctrl + Enter


  # basic R environmental functions
  x=3.14159; y='hello world'; z=TRUE        # create some objects. In RStudio they'll appear in 'Workspace'
  ls()                                      # To list the objects in your workspace
  print(y)                                  # print information to R 'Console'
  rm(y)                                     # remove an object
  rm(list=ls())                             # remove all
  getwd()                                   # find current working directory
  print    (  "R ignores the 'white-space' in command syntax"     )  
  
  setwd("O:\\_CODES\\r_working_group\sessions")      # set working directory as preferred - can be done manually in menu: "Session -> Set Working Directory"
 
  
  # use '?' or help() for help on any R function (if its library is loaded in the session)
  ?max
  help(max)
  ??max                  # search for a text string in R documentation library
 
  
  # To remove ALL objects in your workspace:
  rm(list=ls())                     # or use Remove all objects in the Misc menu
  
  # To save your workspace to a file, you may type  
  save.image()                      # or use Save Workspace. in the File menu
  
  # 'str' is a powerful tool for investigating the underlying structure of any R object
  str(max)                          # also can be used for variables
  str(x)
  str(y)
  
  
#####################################  
##### LOGICAL OPERATIONS
  2 + 2 == 4               # '==' denotes value equality
  3 <= 2                   # less than or equal to
  3 >= 2                   # greater than or equal to
  'string' == "string"
  'b' >= 'a'               # strings can be ranked , b is bigger than a
  3 != 3                   # NOT operator
  c(4,2,6) == c(4,2,8)     # vector comparisons return logical vectors
  TRUE == T                # 'T' and 'F' default as boolean shortcuts (until overwritten)
  TRUE & TRUE              # AND operator
  TRUE | FALSE             # OR operator
  F | FALSE
  all(T,T,T,F)             # TRUE if ALL inputs are TRUE (or if FALSE if !all(...) )
  any(T,T,T,F)             # TRUE if ANY inputs are TRUE (or if FALSE if !any(...) )
  
  
#####################################   
##### Assignment a variable
  
  #  "<-" is used to indicate assignment
  # note: as of version 1.4 "=" is also a valid assignment operator
  # note: these below are all doing the same:
  n = 5           # is possible but rather use <-
  n <- 5          # we just like it more
  5 -> n          # also valid
  assign('n', 5)  # useful for variablising variable names
  n <<- 5         # 'global' assignment (but at the risk of overwrite R's internal code)
  
##################################### 
##### R as a calculator:
  5 + (6 + 7) * pi^2
  log(exp(1))
  log(1000, 10)
  sin(pi/3)^2 + cos(pi/3)^2
  Sin(pi/3)^2 + cos(pi/3)^2         # R is Case sensitive!
                                    # Error: couldn't find function "Sin"
  
  log2(32)
  sqrt(2)
  seq(0, 5)              # create sequence from 0 to 5
  seq(0, 5, length=10)   # create sequence from 0 to 5 with the length of 10 - it means 10 numbers, min 0, max 5

  # R is designed to handle statistical data and therefore predestined to deal with missing values / Numbers that are "not available"
  x <- c(1, 2, 3, NA)
  x + 3                  # "Not a number"
  log(c(0, 1, 2))
  0/0
  

#####################################  
##### useful basic math functions
  seq(-2, 2, by=.2)                 # sequence of equal difference
  seq(length=10, from=-5, by=.2)    # with range defined by vector length
  rnorm(20, mean = 0, sd = 1)       # random normal distribution
  runif(20, min=0, max=100)         # array of random numbers
  sample(0:100, 20, replace=TRUE)   # array of random integers
  table(warpbreaks[,2:3])           # array summary stats (powerful summary tool)
  min(vec)
  max(vec)
  range(vec)
  mean(vec)
  median(vec)
  sum(vec)
  prod(vec)                         # dot product
  abs(-5)                           # magnitude
  sd(rnorm(10))                     # standard deviation
  4^2                               # square
  sqrt(16)                          # square root
  5%%3                              # modulo (remainder after subtraction of a multiple)
  6%%2 

  
#####################################    
##### handling 'NA' values
  (x = 1:5)
  x[8] = 8
  x[3] = NA
  print(x)                          # sometimes functions will fail because of NA values
  na.omit(x)                        # iterates full list but ignores NAs
  x[na.omit(x)]
  is.na(x)                          # alternatively
  x[!is.na(x)]
    
    
########## Chapter 2 #################################################################################################################

#####################################   
##### Basic (atomic) data types
  # R objects can be of various data types, but probably most common are 'numeric' , 'character' and 'logical'
  
  # Logical
  x <- T; y <- F                        # boolean data type - can be TRUE/FALSE or T/F
  x; y
  
  # Numerical
  a <- 5; b <- sqrt(2)
  a; b
  ( num <- 3.14 )                       # bracketing an instruction also prints it to the console
  
  # Character
  a <- "1"; b <- 1                      # "" or '' is used for identifying character variable
  a; b                                  # a is character; b is numeric
  a <- "character"
  b <- "a"; c <- a
  a; b; c
  
  ( char <- 'any text string' )         # bracketing an instruction also prints it to the console

#####################################   
##### Vectors
  
  # Vector is ordered collection of data of the same data type
  ( x <- c(1,2,3,4,5,6,7,8, 9, 10, 11, 12, 13) )             # create a VECTOR (array) using the 'c()' concatenate function
  ( x <- c(1:13) )                                           # a vector series
  ( x <- 1:13 )                                              # a vector series
  ( colours <- c("blue", "red", "yellow"))                   # a vector composed of characters
  
  # Accessing vector
  # R vectors can be accessed in various ways using [ ] brackets
  # when using indexing - it starts with 1 (1st position), not on 0
  x[3]                # accessing the values on the 3rd position
  x[2:4]              # accesing the values from the 2nd to 4th position
  x[ c(1,3,5) ]       # accessing the values on the positions number: 1,3,5
  x[x > 12]           # accessing all the values what are bigger than 12 
  
  # Manipulating vector
  5 %in% x            # check if a vector contains a value 5 - returns TRUE or FALSE
  15 %in% x           # check if a vector contains a value 15 - returns TRUE or FALSE
  
  match('red', colours)                   # finding first index position of a matching value/sting
  match(c('yellow','black'), colours)     # returns NA in case that value/string is not found      

#####################################   
##### LISTS
  # list is the object which contains elements of different types - like strings, numbers, vectors and another list inside it
  # basically, it is a container for other objects
  
  vec <- c(1,2,3)                                   # create vector containing 1,2,3
  char_vec <- c("Matt", "Eva", "Karel", "Matej")    # create character vector
  logic_vec <- c(TRUE, FALSE, TRUE, FALSE)          # create logical vector
  ( lis <- list(vec, char_vec, logic_vec) )         # create a list containg previous 3 objects
  
  # you can give names to the elements of list
  names(lis) <- c("numbers", "names", "valid")
  
  # Accessing the list
  ( lis[2] )                                    # accessing the second element; you can also use column name instead of index
  ( lis["names"] )                              # you can also use column name instead of index
  ( lis$names )                                 # using name of access element 
  
  lis[4] <- c('this is the end)')               # add an element at the end of the list
  lis[4] <- NULL                                # remove the last element   

  # subsetting a list
  family <- list(name="Karel", wife="Lucia", children=3, child.ages=c(1,2,3))     # create a list "family"                                                                     # see each element data type
  ( family[[4]] )                                                                 # subset child.ages and return the values as a vector 
  ( family[4] )                                                                   # a sublist consisting of the 4th component

  # unlisting a list
  family_unlist <- unlist(family)                # converts it to a vector. Mixed types will be converted to character, giving a character vector.

  
    
#####################################   
##### Matrix
  # Matrix is rectangular table of data of the same type
  # it is a 2D vector (essentially a vector of vectors) of matching data type
  
  # Compose matrix
  A <- matrix(
  +   c(2, 4, 3, 1, 5, 7), # the data elements
  +   nrow=2,              # number of rows
  +   ncol=3,              # number of columns
  +   byrow = TRUE)        # fill matrix by rows
  
  # shorter way of composition
  ( matrx <- matrix(1:15, 3, 5) )                                                      # example: data elements vary from 1 to 15, 3 rows, 5 columns
  ( matrx <- 1:12 )                                                                    # vector to a matrix
  matrx <- matrix(1:9, nrow = 3, dimnames = list(c("X","Y","Z"), c("A","B","C")))      # using function "matrix" allows you to name columns and rows as well
  
  
  # Accessing  matrix
  dim(matrx)            # matrix dimension
  colnames(matrx)       # list of column names
  rownames(matrx)       # list of row names
  ncol(matrx)           # total number of columns
  nrows (matrx)         # total number of rows
  
  # Accessing elements inside the matrix
  # Elements can be accessed using [] -- as matrx[row, column]
  ( matrx[1, 2] )          # select first row and second column
  ( matrx['X', 'B'] )      # you can also use column / row names for the same effect
  ( matrx[ ,'B'] )         # leaving any filed inside the bracket blank -> select all
  ( matrx [,] )            # select the entire matrix
  
  ( matrx[matrx%%2 == 0])  # select only even elemets 
  
  # Manipulating matrix
  t(matrx)                 # transpose
  dim(matrx) <- c(1, 9)    # change the matrix dimension
  ( matrx <-  matrx*4 )    # multiply matrix by 4


  
#####################################   
###### Arrays
  # Arrays are the R data objects which can store data in more than two dimensions.
  # For example ??? If we create an array of dimension (2, 3, 4) then it creates 4 rectangular matrices each with 2 rows and 3 columns.
  # This is just a brief intro into arrays. If you are interested more into this topic, visit: https://data-flair.training/blogs/r-array/
  ( arry <- array(1:24, dim=c(4,3,2)) )
  
  # Using square brackets on arrays
  arry[12]        # a single criterion (argument) selects the array's n'th record
  arry[3,1,2]     # or use multiple arguments that reflect the array's dimensionality
  arry[,,2]       # select all from second matrice
  arry[,1,]       # all first columns selected
  
  
#####################################   
##### Data frames
  
  # a DATA.FRAME is like a matrix, but accomodates fields (columns) with different data types
  (df <- data.frame(name = c('Matt','Jan','Eva','Matej','Karel'), age = c(35,29,32,35,39),
                    stringsAsFactors=FALSE))
  
  # They can be viewed easily
  View(df)
  
  # examine their internal stucture
  str(df)
  
  # show the first 6 records of each column
  head(df)
  
  # To retrieve data in a cell, use square bracket "[]" operator. Is is similar to matrix.
  # SYNTAX: [row position; column position]
  df[2,1]        # single cell selection
  df[1,]         # single row selection
  df[2:3,]       # row range selection
  df[c(1,4),]    # specific rows selection
  df[,1]         # single column
  df[0,1]        # writing 0 in the row position and specifying the column position - you will get the data type of the column
  
  
  
  # reference a data frame column as a vector with the double square bracket "[[]]" operator
  # it is transforming column/name as a vector
  # 4 possible ways how to extract names as vector
  df[['name']]        # selecting with column name
  df[[1]]             # selecting with column position
  df$name             # interrogate data.frames by field name using the '$' operator. the result is a simple vector
  df$name[2]          # select the name what is on 2nd position in column name
  df[, 1]             # select just first column within data frame
  
  # writing 0 in the row position and specifying the column position - you will get the data type of the column
  tsrunup[0, 16]
  
  
  # names can be reassigned
  names(df) <- c('person','years')                      # renames the column names. It goes in order from 1
  row.names(df) <- c('R1','R2','R3','R4','R5')          # renames the row names to from R1 to R5
  
################################################################################################################  
### End. 