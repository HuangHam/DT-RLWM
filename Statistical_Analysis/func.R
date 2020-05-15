#functions for DT-RLWM analysis
library(plotrix)
se <- function(v,...){
  std.error(v,...)
}
nonNA <- function(v){length(na.omit(v))/length(v)}
sigTrans <- function(beta){(2/(1+exp(-beta)))-1}
shapeMean <- function(df, ...){
  #group_vars = enquos(...)
  df %>%
    group_by_(...) %>%
    summarise_all(mean,na.rm = T)
}
shapeBoth <- function(df, ...){
  #group_vars = enquos(...)
  df %>%
    group_by_(...) %>%
    summarise_all(list(m = mean, se = se, sd = sd), na.rm = T)
}
boxplt <- function(df, x_var, y_var,condition = NULL, title, xlabel, ylabel) {
  ggplot(df, aes_(x=substitute(x_var), y=substitute(y_var), fill=substitute(condition))) + 
    #geom_point(aes(color=as.factor(subject)), alpha=0.2)+ 
    geom_boxplot(outlier.colour="black", outlier.shape=16,
                 outlier.size=2, notch=FALSE)+
    ggtitle(title) +
    xlab(xlabel) + 
    ylab(ylabel)
}
barplt1 <- function(df, x_var, y_var,condition, title, xlabel, ylabel) {
  ggplot(df, aes_(x=substitute(x_var), y=substitute(y_var), fill = substitute(condition))) + 
    geom_bar(stat="identity", color="black", 
             position=position_dodge()) +
    ggtitle(title) +
    xlab(xlabel) + 
    ylab(ylabel)
}
barplt <- function(df, x_var, y_var,condition, title, xlabel, ylabel) {
  ggplot(df, aes_(x=substitute(x_var), y=substitute(y_var), fill = substitute(condition))) + 
    geom_bar(stat="identity", color="black", 
             position=position_dodge())+
    labs(fill = "dt condition")+
    scale_fill_manual("dt condition", values = c("0" = "blue", "B" = "yellow"))+
    ggtitle(title) +
    xlab(xlabel) + 
    ylab(ylabel)
}
lineplt <-function(df, x_var, y_var,condition, title, xlabel, ylabel) {
  ggplot(df, aes_(x=substitute(x_var), y=substitute(y_var), color = substitute(condition), group=substitute(condition))) + 
    geom_line() +
    geom_point()+
    ggtitle(title) +
    xlab(xlabel) + 
    ylab(ylabel) 
}
violinplt <- function(df, x_var, y_var,condition, title, xlabel, ylabel) {
  ggplot(df, aes_(x=substitute(x_var), y=substitute(y_var), fill = substitute(condition))) + 
    geom_violin(scale = "count", color="black", 
                position=position_dodge()) +
    ggtitle(title) +
    xlab(xlabel) + 
    ylab(ylabel)
}
blank2na <- function(x){ 
  z <- gsub("\\s+", "", x)  #make sure it's "" and not " " etc
  x[z==""] <- NA 
  return(x)
}
Cort1 <- function(Data){ 
  data = Data
  attach(data)
  for (i in 1:nrow(data)){
    sub = subject[i]
    b = block[i]
    o = order[i]+1
    idx = which(subject == sub&block == b&order == o)
    if (length(idx) == 0){
      data$Cor1[i] = NaN
    }else{
      data$Cor1[i] = data[idx,]$Cor
    }
  }
  detach(data)
  return(data)
}
ttest = function(coeffs, twoTail){
  for (i in 1:ncol(coeffs)){
    if (twoTail){
      diff = t.test(coeffs[,i], mu=0, paired = F)
      name = colnames(coeffs)[i]
      p = diff$p.value
      t = diff$statistic
      df = diff$parameter
      print(paste0('In exp3, two-tail pvalue of ', name,' is ', t,", ",df,", ", p))
      if (p <= 0.05){print('It is sigificant')}
    }else{
      diff = t.test(coeffs[,i], mu=0, alternative = 'less', paired = F)
      name = colnames(coeffs)[i]
      print(paste0('In exp3, one-tail pvalue of ', name,' is ', diff$p.value))
      if (p <= 0.05){print('It is sigificant')}
    }
  }
}