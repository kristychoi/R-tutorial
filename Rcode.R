#####################################
# *~ADI Intro to R Workshop~*
# 04/28/2015
# Written by Kristy Choi
#####################################

#set your working directory to wherever your data is
getwd()
setwd("/Users/kristyc/Downloads/")

#let's go over some syntax before we start!
1+2
(1+2)^2
sqrt(2*3)*sin(15)

#variables and assignment
not_zero = 1/2
not_zero

x <- "hi i'm a variable"
print(x)

y <- 2
z = y+2; print(z)

#vectors
x <- seq(1,15,2)
x1 <- 8:1
rep("b",4)
x2 <- c(rep("a",4),rep("b",4))
x2

#characteristics
mode(x)
length(x)

#don't do this!
#print("standard deviation of x" + sd(X))
print(paste("standard deviation of x:", sd(x)))
cat("sum of x:", sum(x))

#find waldo
y <- c("hey","where's", "waldo", "?", "lol")
cat(y)
y == "waldo"
which(y=="waldo")
#there he is!
y[3]

#subsetting
y[0] #oops

length(y)
y[2:4]
#excluding with negative sign
y[-1]
y[c(1:3,5)]
#subset using logical operations
y[y!="lol"]

#lists
#list of numeric, character, and logical vectors
myList <- list(x,y,c(TRUE,FALSE,TRUE,TRUE))
print(myList)
#accessing the list
myList[1]
myList[[1]] #can you tell the difference?

#think about a drawer
#myList[1] + 2
class(myList[1])
class(myList[[1]])
myList[[1]] + 2

#matrices
myMatrix <- matrix(1:9, nrow=3,ncol=3)
myMatrix
another <- matrix(1:9,nrow=3,ncol=3,byrow=T)
print(another)

#basic operations
t(myMatrix)
mat <- cbind(1:2,3:4)
mat
solve(mat)
solve(mat) %*% mat

#loops
x
for(i in 1:length(x)){
  print(x[i]-2)
}

#or...
#print(x-2)
#sapply(x,function(x) x-5)

#means
#1 is row, 2 is column
mat
apply(mat,2,mean)
colMeans(mat)

#sapply and lapply
myList
#sapply(myList,sd)
sapply(myList[-2],sd)
lapply(myList[-2],sd)

#now let's work with some data!
#we can build our own data frame

#remember our vectors x, x1, and x2 from before?
x
x1
x2
df = data.frame(x=x,x1=x1,x2=x2)

#basic summary
head(df)
df
pairs(df)
table(df$x2)
prop.table(table(df$x2))

#write to file and read back in if you need
write.csv(df,"mydf.csv",row.names=F)
mydf <- read.csv("mydf.csv",header=T)

##############***may need to skip if no time***###############
#let's look at some actual data
#This is the training data for the Titanic Kaggle Dataset
#basic data frame
train <- read.csv("train.csv",header=T)

#basic structure of data
head(train)
View(train) #to actually view the dataset in a separate R tab
#head(train[c(-4,-9)])
names(train)
#basic structure of all the variables
str(train)

#let's take a look and see who lived
table(train$Survived)
prop.table(table(train$Survived))

#can we think of some variables to look at?
#for example, gender
table(train$Survived,train$Sex)
props <- prop.table(table(train$Survived,train$Sex),2)
props
barplot(props,xlab="Sex",ylab="Proportion",main="Male and Female Survival")
tapply(train$Survived,train$Sex,mean)
##############***may need to skip if no time***###############


#now let's do some PCA with a different dataset
#install and load packages
#this is already loaded by default, but good practice
install.packages("stats")
library(stats)

#iris dataset
data(iris)
class(iris)
dim(iris)

#basic summary
head(iris)
colnames(iris)
table(iris$Species)

#Simple Visualization
#each column is x
pairs(iris,main="Pairwise correlation matrix")
plot(iris$Sepal.Length,iris$Sepal.Width)
#let's leave out the factor variable
#and make it pretty
pairs(iris[1:4],main="Pretty Pairwise Corr Matris",pch=21,bg=c("red","green3","blue")[unclass(iris$Species)])

#Other visualizations
hist(iris$Petal.Length)
boxplot(iris$Petal.Length)

#Scatterplot
plot(iris$Petal.Length, iris$Petal.Width,main="Iris Data Scatterplot")
ls.fit <- lm(Petal.Length~Petal.Width,data=iris)
plot(iris$Petal.Width,iris$Petal.Length,main="Iris Data",pch=21,bg=c("red","green3","blue")[unclass(iris$Species)])
abline(ls.fit$coeff,col="black",lty=4)
summary(ls.fit)

#PCA
pairs(iris[1:4],main="Pretty Pairwise Corr Matris",pch=21,bg=c("red","green3","blue")[unclass(iris$Species)])
#let's look at the variability of all numeric variables
sapply(iris[1:4],var)
range(sapply(iris[1:4],var))
#now we'll standardize them
iris.stand <- as.data.frame(scale(iris[,1:4]))
sapply(iris.stand,sd)

#now we can do the prcomp() analysis
pca <- prcomp(iris.stand)
pca
summary(pca)

#let's see how many PC's we need
screeplot(pca,type="lines")
#loadings
pca$rotation

#biplot
biplot(pca,cex=0.8)
abline(h=0,v=0,lty=2,col=8)
