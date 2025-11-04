     ## read file
install.packages("readxl")
library(readxl)
getwd()
setwd("C:\\Users\\Alana\\Documents\\Modules MTU- 1°semester\\Into Data Science Rstudio")
   ##data frame
data_tests<- read_xls("CA2-G1.xls")

  ##check structure
str(data_tests)

   ##convert timestamp POSIXct
library(dplyr)
data_tests<- data_tests %>%
mutate(`Date / Timestamp`=as.POSIXct(data_tests[[1]],format="%d %b %Y %H:%M:%S"))
View(data_tests)
str(data_tests)



#reference: https://blog.curso-r.com/posts/2020-08-13-pivotagem/
#https://www.epirhandbook.com/pt/new_pages/pivoting.pt.html

       ###Combine Batch pH
library(tidyr)
data_batch <- data_tests %>%
  select(`Date / Timestamp`,starts_with("Batch"),Feed,`Concentration (mg/mL)`,`Temperature (⁰C)`,`Pressure (bar)`,`Conductivity (mS/mL)`,Hose) %>%
  pivot_longer(
    cols = starts_with("Batch"),
    names_to = "batch",
    values_to = "pH") %>%
drop_na(pH)
View(data_batch)
str(data_batch)

#reference: https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/difftime
##https://pedropark99.github.io/Introducao_R/Cap%C3%ADtulos/12-variaveis-tempo.html


   ##new collumn time interval in minutes
data_batch<- data_batch %>%
  arrange(`Date / Timestamp`)  %>%
  mutate(
    min_interval= as.numeric(difftime(`Date / Timestamp`,lag(`Date / Timestamp`),units = "mins")),
    total_acumulate= as.numeric(difftime(`Date / Timestamp`,first(`Date / Timestamp`),units = "mins" ))
)
View(data_batch)

   ## make a table using group_by combine column and sumary statictics
data_batch %>% group_by(batch) %>%
  summarise(
    Maximum_ph = max(pH, na.rm =TRUE ),
    Minimum_ph = min(pH, na.rm = TRUE),
    Mean_ph = mean(pH, na.rm= TRUE),
    Median_ph = median(pH, na.rm = TRUE),
    Sd_ph = sd(pH,na.rm = TRUE),
    Datapoints = n()
  )

#reference: https://www.rdocumentation.org/packages/graphics/versions/3.6.2/topics/plot
#AI
library(ggplot2)
library(gganimate)

  ##plot of ph
data_batch$Timestamp<-data_batch$`Date / Timestamp`
plot_ph<- ggplot(data_batch, aes( x=Timestamp,y=pH,colour = batch))+
  geom_line()+
  geom_point(size=5)+
  scale_x_datetime(date_labels = "%d-%b %H:%M", date_breaks = "10 days")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))+
  labs(title = "variation of pH",
      x="Time of pH",
      y="Value of pH",
      colour="Batch"
      )+
  transition_reveal(Timestamp)
      #####create animated timeseries plot

ani_ph<-plot_ph
animate(ani_ph, Duration=10,fps=20, width=1000, height=600)


        ###create boxplot show effect of pH vs feed and concentration
boxplot(pH~Feed, data = data_batch,
        main= "Effect of feed on pH",
        xlab = "Feed",ylab = "pH",
        col="green")
##Comments:In feed group 1, we observed pH values ranging from approximately 2.5 to 10, with a median around 5.0. In feed group 2, there was an outlier below 0, and the median was around 6.0, showing a tendency toward higher pH values overall 

boxplot(`Concentration (mg/mL)` ~ Feed , data = data_batch,
        main = "Effect of Feed on Concentration",
        xlab = "Feed",
        ylab = "Concentration (mg/mL)",
        col = "blue")
##Comments: Both groups show similar distributions, with a median between 110 and 115. The interquartile range spans approximately from 100 to 130, and the overall concentration values range from 60 to 180

######References: https://ggplot2.tidyverse.org/###
####refer: https://r-graph-gallery.com/ggplot2-package.html
      
          ##hose and Ph plot
ggplot(data_batch,aes(x=Hose, y=pH ,fill=Hose))+
  geom_violin(trim = FALSE)+
  labs(
    title = "Effect of hose on pH",
    x="hose", y="pH")+
  theme_minimal()
#Comments: The first diagram shows the pH distribution for each hose type, ranging from 0 to 10. Hose D displays the most concentrated values throughout the test, while hose C shows the greatest variability. Hose A tends to have lower pH values, whereas hose B shows a tendency toward higher pH levels

       ##hose  and concentration plot
ggplot(data_batch, aes(x=Hose, y=`Concentration (mg/mL)`,fill = Hose))+
  geom_violin(trim = FALSE)+
  labs(
    title = "Effect of hose on concentration",
    x="Hose", y="Concentration (mg/ml")+
  theme_minimal()
##Comments: In this diagram, we observe a concentration range from 0 to 200. Hose A shows a higher concentration between 75 and 150. Hose B presents a broader range, mainly between 100 and 150. Hose C peaks around 125 to 150, while hose D is more densely distributed between 75 and 125

     #effect of variables using plot

library(GGally)

##function GGally
ggpairs(data_batch[,c("pH","Temperature (⁰C)","Pressure (bar)","Conductivity (mS/mL)","Concentration (mg/mL)")])

             ###Scaterplot: relationship between variables####
     
     ##ph and concentration
ggplot(data_batch, aes(x=pH, y=`Concentration (mg/mL)`))+
  geom_point(color="blue",alpha=0.5)+
  geom_smooth(method="lm", color="red",se=TRUE)+
  labs(title="Concentration vs pH",
       x="pH", y="Concentration(mg/mL")+
  theme_minimal()

      ##concentration and condutivity
ggplot(data_batch, aes(x=`Concentration (mg/mL)`, y=`Conductivity (mS/mL)`))+
   geom_point(color="black",alpha=0.3)+
  geom_smooth(method = "lm",color="purple",se=TRUE)+
  labs(title = "Concentration(mg/mL) vs Conductivity(mS/mL)",
       x="Concentration(mg/mL)",
       y="Conductivity(mS/mL")+
    theme_minimal()