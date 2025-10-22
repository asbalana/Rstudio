        ###Q1####
#create vectors
emp_id<-c("1","2","3","4","5")
emp_name<-c("Rick Martin","Dan Haughey","Michelle Hore","Ryan McNea","Gary O'Gorman")
salary<-c("623.30","515.20","611.00","729.00","843.25")
start_date<-c("2012-01-01","2013-09-23","2014-11-15","2014-05-11","2015-03-27")

##create data frame
emp.data<-data.frame(
  emp_id= as.integer(emp_id),        #chr~integer
  emp_name=emp_name,                 #chr
  salary= as.numeric(salary),        #chr~numeric
  start_date= as.Date(start_date))   #Date

        #####Q2#####
##check structure and statistics of data frame
str(emp.data)
summary(emp.data)


       #####Q3#####
#add new column to data frame
emp.data$dept<- c("IT","Sales","IT","HR","Finance")
View(emp.data)

        #####Q4####
## check current directory in R 
getwd() 
setwd("C:\\Users\\Alana\\Documents\\Modules MTU- 1°semester\\Into Data Science Rstudio")

#read file xlxs
library(xlsx)  ##load the package##

##read file
emp.newdata<-read.xlsx("emp_newdata.xlsx",sheetIndex = 1)

##structure of data frame 
str(emp.newdata)

emp.newdata$emp_id<- as.integer(emp.newdata$emp_id) #num~integer
##check if emp_id is integer
str(emp.newdata)

        ####Q5####
## emp.data+emp_newdata:into a separate data frame called emp.finaldata      
emp.finaldata<- rbind(emp.data,emp.newdata)

##check structure
str(emp.finaldata)
summary(emp.finaldata)
##variable start date change chr~Date
emp.finaldata$start_date<-as.Date(emp.finaldata$start_date)
str(emp.finaldata)
View(emp.finaldata)
        ###Q6####
##FullYear - NumMonth - NumDay format in a new column

emp.finaldata$full.data<-format(emp.finaldata$start_date, "%A %d %B %y")
View(emp.finaldata)

       ###Q7###
# create boxplot 

boxplot(salary~dept, data=emp.finaldata,
        main="Salaries by departments",
        xlab = "Departmets",
        ylab = "Salaries",
        col="green",
        ylim= c(500,900))
        
      ###Q8####
#Reference https://pedropark99.github.io/Introducao_R/Cap%C3%ADtulos/17-loops.html
#Reference: AI(Copilot)
#Reference: https://rstudio-education.github.io/hopr/loops.html#for-loops
for (i in 1:30) {
  name <- emp.finaldata$emp_name[i]
  salary <- emp.finaldata$salary[i]
  dept <- emp.finaldata$dept[i]
  
  if (salary >= 620 & salary <= 730 & dept != "Finance") {
    print(paste(name,":","Salary:",salary))
    }
}
            ####Q9####
##define function
Sal.level<-function(s)
  
 #condition  existence and return if false
  if(!as.numeric(s>=0)){
    return(NA)
  
  #condition based in the category salaries    
}      else if(s >= 500 & s< 600){
  return("Level 1")    
}      else if(s >= 600 & s< 700){
  return("Level 2")
}      else if(s >= 700 & s< 800){
  return("Level 3")
}      else if(s >= 800){
  return("Level 4")
}    else{
return(NA)
}
  

     #####Q10###
##use funtion sal.level to category salary in emp.final data
emp.finaldata$sal.category<-sapply(emp.finaldata$salary,Sal.level) 
##show results in a table according to each level
table(emp.finaldata$sal.category)


