args = commandArgs(trailingOnly=TRUE)
##getwd()
##setwd("C:/Users/chkiran/Documents/res")
setwd(args[2])
library(readxl)
library(tidyr)
library(xlsx)
file.list <- list.files(pattern='*.res') # save list of file names

new_df_list = list()
new_df_list2=list()
df.list <- lapply(file.list, function(x)read.table(x,sep = "=")) #seperate each file into two col
y<-1;
rf<-data.frame("x1","y1")
rf2<-data.frame("")
lapply(df.list, function(x){
                      
                     ## print(x[27,])
                  
                  rf$x1<<-x[32,2]
                  rf$x2<<-x[27,2]
                  rf2$min<<-as.numeric(gsub('\\s+', '',x[23,2]))/1000
                  rf2$max<<-as.numeric(gsub('\\s+', '',x[24,2]))/1000
                  rf2$average<<-as.numeric(gsub('\\s+', '',x[25,2]))/1000
                  rf2$median<<-as.numeric(gsub('\\s+', '',x[26,2]))/1000
                  
                 ## print(rf)
                  new_df_list2[[y]]<<-rf2
                  new_df_list[[y]]<<-rf
                
                  
                  y<<-y+1
                  ##print(y)       
                  })
big_data = do.call(rbind, new_df_list)  #bind all dataframes into a single one.
big_data2= do.call(rbind, new_df_list2)
#new_data2 <- transform(big_data2,min=as.numeric(gsub('\\s+', '', min)),
 #                     max=as.numeric(max),
  #                    average=as.numeric(average),
   #                   median=as.numeric(median))
big_data2$X..<-NULL
big_data$X.x1.<-NULL
big_data$X.y1.<-NULL
big_data$x1 <- gsub('\\s+', '', big_data$x1)##removing white spaces
#new_data<-separate(data = big_data, col = x2, into = c("description","y1","y2","y3","y4","y5","y6","y7","y8","y9","y10","y11"), sep = "\\|")
new_data<-separate(data = big_data, col = x2, into = c("description","y1","y2","y3","y4","y5","y6","y7","y8","y9","y10","y11","y12","y13","y14","y15","y16","y17","y18","y19","y20","y21","y22","y23","y24","y25"), sep = "\\|")
#new_data$y11<-NULL  #removing blank columns
new_data$description<-ifelse(new_data$x1=='SkyNZ_ZAP_002_DCA_HD_SD_DiffTS_3SR','The STB shall change between linear channels within the specified normal and peak usage timeframes with 3SR in the background. (HD-SD)  ',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_ZAP_001_DCA_SD_SD_SameTS_3SR','The STB shall change between linear channels within the specified normal and peak usage timeframes with 3SR in the background. (SD-SD no stream change)',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_STANDBY_001_Standby_IN_OUT','Coming out of standby with 3SR',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_APP_LAUNCH','Loading APP from live channel with 3SR ',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_GUIDE_001_LAUNCH','Loading GUIDE from live channel with 3SR ',new_data$description)
##new_data$description<-ifelse(new_data$x1=='SkyNZ_PLANNER_001_LAUNCH_With_MiniTV_Enabled','Loading PLANNER from live channel with 3SR',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_PLANNER_Playback_Transition_With_RB_001_THREE_Rec_ONGOING','Playback a recording from the planner with 3SR in the background ',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_RB_PLB_RW_001_BANNER','Review Buffer - PVR functions',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_ZAP_001_DCA_SD_SD_DiffTS_3SR','The STB shall change between linear channels within the specified normal and peak usage timeframes with 3SR in the background. (SD-SD stream change)  ',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_ZAP_002_DCA_SD_HD_DiffTS_3SR','The STB shall change between linear channels within the specified normal and peak usage timeframes with 3SR in the background. (SD-HD) ',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_ZAP_003_DCA_HD_HD_DiffTS_3SR','The STB shall change between linear channels within the specified normal and peak usage timeframes with 3SR in the background. (HD-HD stream change) ',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_ZAP_003_DCA_HD_HD_SameTS_3SR','The STB shall change between linear channels within the specified normal and peak usage timeframes with 3SR in the background. (HD-HD no stream change)  ',new_data$description)
new_data$description<-ifelse(new_data$x1=='SkyNZ_Channel_Change_CH+','Change channel by pressing channel up button',new_data$description)
lapply(big_data2,function(x){
  
  big_data2$description<<-new_data$description # add description,filename col col from first dataframe to second
  big_data2$x1<<-new_data$x1 
})




new_data<-transform(new_data, y1 = as.numeric(y1)/1000,
                    y2 = as.numeric(y2)/1000,
                    y3 = as.numeric(y3)/1000,
                    y4 = as.numeric(y4)/1000,
                    y5 = as.numeric(y5)/1000,
                    y6 = as.numeric(y6)/1000,
                    y7 = as.numeric(y7)/1000,
                    y8 = as.numeric(y8)/1000,
                    y9 = as.numeric(y9)/1000,
                    y10 = as.numeric(y10)/1000,
                    y11 = as.numeric(y11)/1000,
                    y12 = as.numeric(y12)/1000,
                    y13 = as.numeric(y13)/1000,
                    y14 = as.numeric(y14)/1000,
                    y15 = as.numeric(y15)/1000,
                    y16 = as.numeric(y16)/1000,
                    y17 = as.numeric(y17)/1000,
                    y18 = as.numeric(y18)/1000,
                    y19 = as.numeric(y19)/1000,
                    y20 = as.numeric(y20)/1000,
                    y21 = as.numeric(y21)/1000,
                    y22 = as.numeric(y22)/1000,
                    y23 = as.numeric(y23)/1000,
                    y24 = as.numeric(y24)/1000,
                    y25 = as.numeric(y25)/1000)

 


big_data2<-big_data2[c(6,5,1,2,3,4)]  #reorder columns
attach(new_data); #sort on filename column
new_data<-new_data[order(x1),]
detach(new_data)
attach(big_data2);    
big_data2<-big_data2[order(x1),]
detach(big_data2)

if(args[1]==1){
write.xlsx(new_data,paste(getwd(),"/generated.xlsx",sep=""),row.names = FALSE,sheetName = "Readings")
write.xlsx(big_data2,paste(getwd(),"/generated.xlsx",sep=""),row.names = FALSE,sheetName = "Performance Data",append = TRUE)
}

if (args[1]==2){
 
  existing_pd_df<-read.xlsx(file = args[3],sheetName = "Performance Data")
  existing_rd_df<-read.xlsx(file = args[3],sheetName = "Readings")
 # existing_pd_df<-read.xlsx(file = "generated.xlsx",sheetName = "Performance Data")
 # existing_rd_df<-read.xlsx(file = "generated.xlsx",sheetName = "Readings")
  existing_rd_df$a1<-new_data$y1
  existing_rd_df$a2<-new_data$y2
  existing_rd_df$a3<-new_data$y3
  existing_rd_df$a4<-new_data$y4
  existing_rd_df$a5<-new_data$y5
  existing_rd_df$a6<-new_data$y6
  existing_rd_df$a7<-new_data$y7
  existing_rd_df$a8<-new_data$y8
  existing_rd_df$a9<-new_data$y9
  existing_rd_df$a10<-new_data$y10
  existing_rd_df$a11<-new_data$y11
  existing_rd_df$a12<-new_data$y12
  existing_rd_df$a13<-new_data$y13
  existing_rd_df$a14<-new_data$y14
  existing_rd_df$a15<-new_data$y15
  existing_rd_df$a16<-new_data$y16
  existing_rd_df$a17<-new_data$y17
  existing_rd_df$a18<-new_data$y18
  existing_rd_df$a19<-new_data$y19
  existing_rd_df$a20<-new_data$y20
  existing_rd_df$a21<-new_data$y21
  existing_rd_df$a22<-new_data$y22
  existing_rd_df$a23<-new_data$y23
  existing_rd_df$a24<-new_data$y24
  existing_rd_df$a25<-new_data$y25
  
  
  existing_pd_df$min_drop_15<-big_data2$min
  existing_pd_df$min_Compare_to_field_vision_drop_15<-(existing_pd_df$min)-(big_data2$min)
  existing_pd_df$max_drop_15<-big_data2$max
  existing_pd_df$max_Compare_to_field_vision_drop_15<-(existing_pd_df$max)-(big_data2$max)
  existing_pd_df$average_drop_15<-big_data2$average
  existing_pd_df$average_Compare_to_field_vision_drop_15<-(existing_pd_df$average)-(big_data2$average)
  existing_pd_df$median_drop_15<-big_data2$median
  existing_pd_df$median_Compare_to_field_vision_drop_15<-(existing_pd_df$median)-(big_data2$median)
  write.xlsx(existing_rd_df,file = args[3],row.names = FALSE,sheetName = "Readings")
  write.xlsx(existing_pd_df,file = args[3],row.names = FALSE,sheetName = "Performance Data",append = TRUE)
  # write.xlsx(existing_rd_df,file = "generated.xlsx",row.names = FALSE,sheetName = "Readings")
  # write.xlsx(existing_pd_df,file = "generated.xlsx",row.names = FALSE,sheetName = "Performance Data",append = TRUE)
  
}

if (args[1]==3){
  
  existing_pd_df<-read.xlsx(file = args[3],sheetName = "Performance Data")
  existing_rd_df<-read.xlsx(file = args[3],sheetName = "Readings")
  existing_rd_df$b1<-new_data$y1
  existing_rd_df$b2<-new_data$y2
  existing_rd_df$b3<-new_data$y3
  existing_rd_df$b4<-new_data$y4
  existing_rd_df$b5<-new_data$y5
  existing_rd_df$b6<-new_data$y6
  existing_rd_df$b7<-new_data$y7
  existing_rd_df$b8<-new_data$y8
  existing_rd_df$b9<-new_data$y9
  existing_rd_df$b10<-new_data$y10
  
  existing_pd_df$min_ccn009<-big_data2$min
  existing_pd_df$min_Compare_to_field_vision_ccn009<-(existing_pd_df$min)-(big_data2$min)
  existing_pd_df$max_ccn009<-big_data2$max
  existing_pd_df$max_Compare_to_field_vision_ccn009<-(existing_pd_df$max)-(big_data2$max)
  existing_pd_df$average_ccn009<-big_data2$average
  existing_pd_df$average_Compare_to_field_vision_ccn009<-(existing_pd_df$average)-(big_data2$average)
  existing_pd_df$median_ccn009<-big_data2$median
  existing_pd_df$median_Compare_to_field_vision_ccn009<-(existing_pd_df$median)-(big_data2$median)
  write.xlsx(existing_rd_df,file = args[3],row.names = FALSE,sheetName = "Readings")
  write.xlsx(existing_pd_df,file = args[3],row.names = FALSE,sheetName = "Performance Data",append = TRUE)
  
}