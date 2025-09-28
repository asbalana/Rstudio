rm(list = ls())# clears environment 
#### Let'start a practice using R####
######Comments ######
error commnets

##exercise 1.3: Help##
help.start()
##exercice 1.4: plot help##
?plot
##exercise 1.5: generate vectors##
x <- 1:10 #vector1#
y<-seq(2,20,by=2) #vector2#
#check vectors#
x
y
##exercise 1.6:plot the vectors##
plot(x,y)

##exercise 1.7: main,title, subtitle and axis labels##
plot(x, y,
     main= "X and Y",
     sub= "Plot in R",
     xlabel="Value of X",
     ylabel="Value of Y")


######Section 1.3 Basic Calculations 
##exercise 1.8:run the code##
a=2
a=3
b<-3
a*b
c=a*b
b/a
3*6+234
exp(log(10))
a=2; is.logical(a);is.list(a);is.numeric(a)


##exercise1.9:save##
