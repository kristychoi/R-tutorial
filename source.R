#####################################
# *~ADI Intro to R Workshop~*
# 04/28/2015
#####################################

#set your working directory to wherever your data is
getwd()
setwd("~/Downloads")

#let's go over some syntax before we start!
1+2
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

mode(x)
length(x)

yy <- c(1,2,3,4,5)
x1 <- 1:8
rep("b",4)
x2 <- c(rep("a",4),rep("b",4))
x2

y <- c(1,'a',TRUE)

#find waldo
y <- c("hey","where's", "waldo", "?", "lol")
cat(y)
y == "waldo"
which(y=="waldo")
#there he is!
y[3]

#expand on subsetting, this becomes really important
#compare to MATLAB and Python
#subsetting
y[0] #oops
#[ ]

length(y)
y[2:4]
#excluding with negative sign
y[-1]
y[c(1:3,5)]
#subset using logical operations
y[y!="lol"]

#matrices
myMatrix <- matrix(1:9, nrow=3,ncol=3)
myMatrix
another <- matrix(1:9,nrow=3,ncol=3,byrow=T)
print(another)

#subsetting by row and column
mat <- cbind(1:2,3:4)
mat
mat[1,]
mat[,1]

#matrix operations
myMatrix
t(myMatrix)
solve(mat)
solve(mat) %*% mat #different from *

#let's find the mean of every column in a matrix
#apply() function
#1 is row, 2 is column
apply(mat,2,mean)
colMeans(mat)

#now let's work with some data!
#we can build our own data frame

#remember our vectors x, x1, and x2 from before?
x
x1
x2
df = data.frame(foo=x,hello=x1,bar=x2)

#basic summary
df
names(df) #can also be colnames()
str(df) #structure
head(df)

#subsetting dataframe: $
df$foo

#useful function
table(df$bar)
prop.table(table(df$bar))

#write to file and read back in if you need
write.csv(df,"mydf.csv",row.names=F)

#general workflow
mydf <- read.csv("mydf.csv",header=T)
mydf
df


######################################
#now for the fun stuff~
#install and load packages
install.packages("stats")
library(stats)

#iris dataset
data(iris)
dim(iris)

#basic summary
head(iris)
colnames(iris)
View(iris)


#how about we try looking at just one species?
table(iris$Species)
setosa <- iris[iris$Species == 'setosa', ]
setosa_pl <- setosa$Petal.Length
mean(setosa.pl)
var(setosa.pl)
summary(setosa.pl)

?aggregate
aggregate(iris[ ,1:4], by=list("Species" = iris$Species),mean)

#Simple Visualization
#each column is x
hist(iris$Petal.Length)
boxplot(iris$Petal.Length)

#pairwise correlation matrix
pairs(iris,main="Pairwise correlation matrix")
#let's leave out the factor variable and make it pretty
pairs(iris[1:4],main="Pretty Pairwise Corr Matrix",pch=21,bg=c("red","green3","blue")[unclass(iris$Species)])

#Scatterplot
names(iris)
plot(iris$Petal.Length, iris$Petal.Width,main="Iris Data Scatterplot",xlab='x',ylab='y')
ls.fit <- lm(Petal.Length~Petal.Width,data=iris)
plot(iris$Petal.Width,iris$Petal.Length,main="Iris Data",pch=21,bg=c("red","green3","blue")[unclass(iris$Species)])
abline(ls.fit$coeff,col="black",lty=2)
summary(ls.fit)

#let's do something really cool now: PCA
pairs(iris[1:4],main="Pretty Pairwise Corr Matrix",pch=21,bg=c("red","green3","blue")[unclass(iris$Species)])
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

#for the future:
library(ISLR)
data(Auto)
head(Auto)
pairs(Auto)
