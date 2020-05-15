#functions for DT-RLWM analysis
valPlt <-function(df, title) {
  ggplot(df, aes(x=as.factor(ns), y=Cor_m, color=as.factor(dt),group=interaction(as.factor(dt), Data))) +
    geom_line(aes(linetype=Data)) + 
    geom_point(aes(shape=Data))+
    theme(legend.position = c(.75, .4), legend.box = "horizontal", legend.justification = c("right", "top"),
          legend.box.just = "left",legend.background = element_rect(colour = "transparent", fill = "transparent"))+
    ylim(0.4,0.9)+
    geom_errorbar(aes(ymin=Cor_m-Cor_se, ymax=Cor_m+Cor_se), width=.2,
                  position=position_dodge(0))+
    labs(title = title, color = "Condition", x = "set size", y = "average correct")+
    scale_color_manual(values = c('Task-Switch' = "gray30", 'Dual-Task' = "red3"))
}

addSmallLegend <- function(myPlot, pointSize = 0.8, textSize = 11, spaceLegend = 2.5) {
  myPlot +
    guides(shape = guide_legend(override.aes = list(size = pointSize)),
           color = guide_legend(override.aes = list(size = pointSize))) +
    theme(legend.title = element_text(size = textSize), 
          legend.text  = element_text(size = textSize),
          axis.title=element_text(size=18),
          legend.key.size = unit(spaceLegend, "lines"))
}
convert<-function(mod, data){
  df = shapeMean(data, 'subject','ns','dt')
  df_data = shapeBoth(df, 'ns', 'dt')
  df_data$setsize = as.factor(df_data$ns)
  df_data$Data = "Actual"
  
  df = shapeMean(mod, 'subject','ns','dt')
  df1 = shapeBoth(df, 'ns', 'dt')
  df1$setsize = as.factor(df1$ns)
  df1$Data = "Model"
  return(rbind(df1, df_data))
}
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
    summarise_all(list(m = mean, se = se), na.rm = T)
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
    scale_fill_manual("Condition", values = c('Task-Switch' = "gray30", 'Dual-Task' = "red3"))+
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
      print(paste0('In exp3, two-tail pvalue of ', name,' is ', diff$p.value))
    }else{
      diff = t.test(coeffs[,i], mu=0, alternative = 'less', paired = F)
      name = colnames(coeffs)[i]
      print(paste0('In exp3, one-tail pvalue of ', name,' is ', diff$p.value))
    }
  }
}