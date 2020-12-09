#遗传漂变
drift<-function(N,p0,G,times){
  M<-data.frame()
  for(m in 1:times){
    A<-2*N*p0
    for(i in 1:G){
      p<-A/(2*N)  #杂合子比例
      A<-rbinom(1,2*N,p)
      M[m,i]<-p
    }
    return(M)
  }}

value<-drift(300,0.5,5000,50)
value2<-drift(3000,0.5,5000,50)
A<-value[,5000]
B<-value2[,5000]

df<-data.frame(A,B)  

library("ggplot2")

ggplot(df)+geom_histogram(aes(A),fill="red",alpha=0.5)+
  geom_histogram(aes(B),fill="green",alpha=0.5)+xlab("hetero")
 
#自然选择对亚群B的影响
numb<-function(A,a,G,times,N){
  M<-data.frame()
  for(m in 1:times){
    n=N
    p1=A
    p2=a
    for(i in 1:G){
      
        p1<-rbinom(1,2*n,p1)/(n*2) #A
        p2<-rbinom(1,2*n,p2)/(n*2)#a
        n<-(p1*p1*0.006+0.0012*2*p1*p2)*n*n/4
        M[m,i]<-n
        p1<-(p1*p1*0.006*2+0.0012*2*p1*p2)/(p1*p1*0.006*2+0.0012*2*p1*p2*2)
        p2<-(0.0012*2*p1*p2)/(p1*p1*0.006*2+0.0012*2*p1*p2*2)
        n<-ceiling(n)
      
  }}
  return(M)
}

num1<-num(0.02,0.38,0.6,1,50,700)

num2<-numb(0.4,0.6,10,50,1000)


library(ggplot2)
y=c()
for(i in 1:10){y[i]=mean(num2[,i])}

df<-data.frame(x=seq(1:10),y)

ggplot(df)+
  geom_point(aes(x,y),col="blue",alpha=0.5)+geom_smooth(aes(x,y),method = "gam",col="pink",alpha=0.5)
              
