###TOUR OF RSTUDIO###

install.packages("tidyverse")
library(tidyverse)

1+1
5*4
2^3


2+3*4/(5+3)*15/2^2+3*4^2
5e4


#does 5 equal 4?
5 == 4


#is 10 less than or equal to 11?
10 <= 11

#is the sqrt of 36 equal to 6 squared?
sqrt(36) != 6


sqrt(36)

Sqrt(10)

#call the helpfile for the sqrt funtion
help(sqrt)


#call the helpfile for the plot funtion
help(plot)


#plot example of plot function
plot(x <- sort(rnorm(47)), type = "s", main = "plot(x, type = \"s\")")


#use sqrt function to calculate sqrt of 10 and store result in object called result
result <- sqrt(10)


###DATA TYPES###

#assign the value of the square root of 100 to 
#the object, variable 'result'
result = sqrt(100)

#assign the value of the square root of 100 to
#the object, variable 'result'
result <- sqrt(100)


#find class of object 'result'
class(result)

#find length of object 'result'
length(result)


#A vector of numbers
x <- c(5,9, 11)
x

#A vector of logical values
y <- c(TRUE,FALSE,TRUE,FALSE,FALSE)
y

#A vector of character strings
people <- c("Jack","Jill","Jim","June")
people


#A vector with one value -- called a 'scalar'
v <- c(15)
v

#vector coercion
k <- c(1,2,3,"BOO!")
k

people

#indexing vectors
people[1]

people[1+2]
people[length(people)]

#indexing vectors by a vector
people[c(1,3)]
people[c(3,1)]


#data frame setup
mydata <- data.frame(diabetic = c(TRUE, FALSE, TRUE, FALSE), 
                     height = c(65, 69, 71, 73))
mydata

#data frame index -- row 3, column 2
mydata[3,2]

# all rows of column "height"
mydata[,"diabetic"]

# subsetting creates a numeric vector
mydata$height

# get column names
colnames(mydata)

# assign column names
colnames(mydata) <- c("Diabetic", "Height")
colnames(mydata)

#assign column 1 name only
colnames(mydata)[1] <- "Diabetes"
colnames(mydata)


###READ, WRITE AND EXPLORE DATA###

library(tidyverse)
library(readxl)

getwd()

setwd("C:/RFiles/")


iris<-read_csv("iris.csv")



#We will use the absolute file path becuase
#the file is not in the current working directory
iris<-read_csv("C:/RFiles/iris.csv")

#assign the iris.csv dataset to iris object
iris<-read_csv("iris.csv")

#write the iris dataframe to iriswrite.csv
write_csv(iris,"iriswrite.csv")

#assign the iris.txt dataset to iris variable
iristxt<-read_tsv("iris.txt")

#write the iris dataset to Iriswrite.txt
iristxt<-write_tsv(iristxt,"iriswrite.txt")

#read file to excel
irisxls<-read_excel("iris.xlsx")

#write to csv and then open in Excel
write_csv(irisxls,"C:/RFiles/iriswrite2.csv")
          
#open up spreadsheet-type environment
View(iris)          

#view first 3 observations
head(iris,3)

#view last 3 observations
tail(iris,3)

#view structure of object
str(iris)

#get names of object
names(iris)

#get summary statistics of object
summary(iris)

###DATA MANIPULATION###

library(tidyverse)

d<-read_csv("C:/RFiles/hsbraw.csv")

# this will add a column named zmath which is a standardized variable
d$zmath <- log(d$math)
head(d$zmath,10)

names(d)

# create 4 transformations of the read variable
d <- mutate(d,
            logmath = log(read),
            mathrank = min_rank(read),
            zmath = scale(read))

names(d)

# subset to females with high math
d_fem_hi_math <- filter(d, female == "female" & math > 50)
dim(d_fem_hi_math)

# subset to students with math < 50 in the general or academic programs
d_gen_aca_low_math <- filter(d, 
                             (prog == "general" | prog == "academic") & math < 50)
dim(d_gen_aca_low_math)

# rbind works because they have the same variables
d_append <- rbind(d_fem_hi_math, d_gen_aca_low_math)

# dimensions of component datasets
dim(d_fem_hi_math)
dim(d_gen_aca_low_math)


# appended dataset has rows = sum of rows of components
dim(d_append)


# select 4 variables
d_use <- select(d, id, female, read, write)
names(d_use)

# select everything BUT female, read, write
# note the - preceding c(female...)
d_dropped <- select(d, -c(female, read, write))
names(d_dropped)

d_all <- cbind(d_use, d_dropped)
names(d_all)

# first group data by cid (there are 20 classes)
by_class <- group_by(d, cid)

# then get mean/median on math by class
class_median <- summarize(by_class, medmath=median(math))
names(class_median)

## ## Joining, by = "cid"
d_merged <- inner_join(d, class_median)
head(d_merged)


###DATA VISUALIZATION###


library(tidyverse)
d<-read_csv("C:/RFiles/hsbraw.csv" )

#use the bins= argument to control the # of intervals
ggplot(d,aes(x=write))+geom_histogram(bins=10)

#use binwidth to control the width of bins
ggplot(d, aes(x=write))+geom_histogram(binwidth=10)

#density plot to smooth out shape of the histogram
ggplot(d, aes(x=write))+geom_density()

#for the overall distribution of one variable, specify x=1 (or any other value)
ggplot(d, aes(x = 1, y = math)) + geom_boxplot()

#for the overall distribution of one variable, specify x=1 (or any other value)
ggplot(d, aes(x = 1, y = science)) + geom_boxplot()

#table() produces counts

table(d$female)

#for proportions, use prop.table(table())

prop.table(table(d$female))

#exploring categorical variables with a bar graph
ggplot(d, aes(x=prog))+geom_bar()

#correlate two varaibles
cor(d$write, d$read)

#create correlation table of certain variables
scores<-d[,c("read","write","math","science","socst")]
cor(scores)

#scatter plot of reading vs writing scores
ggplot(d,aes(x=read, y=write))+
  geom_point()+
  geom_smooth()

#group and summarize female math scores
by_female<-group_by(d,female)

summarize(by_female,mean(math),var(math))

#plot distribution of male and female math scores
ggplot(d,aes(x=math,color=female))+
  geom_density()


#box plot of female vs male math scores
ggplot(d,aes(x=female,y=math))+ geom_boxplot()

#create two-way table of prog vs ses
my2way<-table(d$prog,d$ses)
my2way

#stacked bar graph of ses by prog
ggplot(d,aes(x=ses,fill=prog)) +geom_bar()

#unstacked bar graph of ses by prog
ggplot(d,aes(x=ses,fill=prog)) +geom_bar(position="dodge")



