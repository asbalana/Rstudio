##Section 1.4 Sourcing Data##
# LOAD AN AVAILABLE DATASET 

####Exercise 1.11: Run the following code:
data() #list of datasets
mtcars #prints the motor trend car road tests
?mtcars #info on the mtcars datasets
data(mtcars)
plot(mtcars$qsec, mtcars$mpg,
     xlabel="quarter mile sprint",
     ylabel="miles per gallon",
     main="mpg x quarter mile")

-##Section 1.5 Data Types##
# VECTORS 

#Exercise 1.13:vector
x= c(0.1,2,4.3,3.1,5)
x[2]
x[1:3]
x[-(1:3)]
x[x>3]

#Exercise 1.14:
y=2*x+1 #new vector
print(y)

#Exercise 1.15:
#Calculate for X
mean(x)
median(x)
sd(x)
#Calculate for Y
mean(y)
median(y)
sd(y)


#Exercise 1.16: seq()
seq(-5,5,by=1)

#Exercise 1.17: 
rep(x,2)

#Exercise 1.18:
#Vectors may also contain characters or strings:
fruit <- c(5, 10, 4)
names(fruit) <- c("orange", "banana", "apple")
lunch <- fruit[c("apple","orange")] 

##Section 1.6 Matrices, Arrays & List##
## MATRICES 
#Exercise 1.19:
# Create a vector
x = c(1, 2, 3, 4, 5, 6, 7, 8, 9)
# Now make it a 3×3 matrix:
matrix(x, ncol = 3) # note how this is arranged.
#If we prefer arranging by rows:
M = matrix(x, ncol = 3, byrow = TRUE)
#The matrix now has dimensions:
dim(M)
ncol(M)
nrow(M)
#What do the following do?
t(M); aperm(M, c(2,1))
diag(M)
det(M)
#define two matrices A and B as below:
A <- M; B <- t(M)
#Element-by-element product:
A * B #(if A and B are square)
#Matrix product:
A %*% B
# note how these are considerably different! 


##ARRAYS##
##Exercise 1.20
h = seq(1, 24, by=1)  
Z <- array(h, dim=c(3,4,2))  
Z[1,1,1]; Z[1,2,2] 



# LISTS####
####Exercise 1.21

Lst <- list(name="Fred", wife="Mary", no.children=3, 
            child.ages=c(4,7,9))  
Lst[[2]]  
Lst[[4]][1]  

