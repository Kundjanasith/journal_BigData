args = commandArgs(trailingOnly=TRUE)

print("Start R Session")

#print(args[1])
#print(args[2])
#print(args[3])
#print(args[4])
#print(args[5])

print("XXX")
depth_file <- read.csv('../spark_workspace/res_depth.csv')
mag_file <- read.csv('../spark_workspace/res_mag.csv')
print("YYY")
print("READ DATA")
#print(head(depth_file))

#depth_file <- subset(depth_file,Predict_Depth!="NA")
#mag_file <- subset(mag_file,Predict_Magnitude!="NA")

#depth_file <- subset(depth_file, Country==args[5] &  Year==args[4] & Month==args[3]  & Day<=strtoi(args[2]) & Day>=strtoi(args[1]))
#mag_file <- subset(mag_file, Country==args[5] & Year==args[4] & Month==args[3] & Day<=strtoi(args[2]) & Day>=strtoi(args[1]))

#depth_file <- subset(depth_file, Day>=strtoi(args[1]) & Day<=strtoi(args[2]))
#depth_file <- subset(depth_file, Month==strtoi(args[3]))

depth <- as.data.frame(depth_file)
mag <- as.data.frame(mag_file)

print(depth)
#print(nrow(depth))
print(mag)
#print(nrow(mag))

res_file <- merge(depth,mag)

res_file$scale <- 0

res_file$scale <- ifelse( res_file$Predict_Depth==1 & res_file$Predict_Magnitude==5 , 7 , res_file$scale)

res_file$scale <- ifelse( res_file$Predict_Depth==2 & res_file$Predict_Magnitude==5 , 6 , res_file$scale)
res_file$scale <- ifelse( res_file$Predict_Depth==1 & res_file$Predict_Magnitude==4 , 6 , res_file$scale)

res_file$scale <- ifelse( res_file$Predict_Depth==3 & res_file$Predict_Magnitude==5 , 5 , res_file$scale)
res_file$scale <- ifelse( res_file$Predict_Depth==2 & res_file$Predict_Magnitude==4 , 5 , res_file$scale)
res_file$scale <- ifelse( res_file$Predict_Depth==1 & res_file$Predict_Magnitude==3 , 5 , res_file$scale)

res_file$scale <- ifelse( res_file$Predict_Depth==3 & res_file$Predict_Magnitude==4 , 4 , res_file$scale)
res_file$scale <- ifelse( res_file$Predict_Depth==2 & res_file$Predict_Magnitude==3 , 4 , res_file$scale)
res_file$scale <- ifelse( res_file$Predict_Depth==1 & res_file$Predict_Magnitude==2 , 4 , res_file$scale)

res_file$scale <- ifelse( res_file$Predict_Depth==3 & res_file$Predict_Magnitude==3 , 3 , res_file$scale)
res_file$scale <- ifelse( res_file$Predict_Depth==2 & res_file$Predict_Magnitude==2 , 3 , res_file$scale)
res_file$scale <- ifelse( res_file$Predict_Depth==1 & res_file$Predict_Magnitude==1 , 3 , res_file$scale)

res_file$scale <- ifelse( res_file$Predict_Depth==3 & res_file$Predict_Magnitude==2 , 2 , res_file$scale)
res_file$scale <- ifelse( res_file$Predict_Depth==2 & res_file$Predict_Magnitude==1 , 2 , res_file$scale)

res_file$scale <- ifelse( res_file$Predict_Depth==3 & res_file$Predict_Magnitude==1 , 1 , res_file$scale)

res_file <- res_file[c('Country','Day','Month','Year','scale')]
print(res_file)

#print(args[1])

#file_name <- paste( "result/", args[1], "_", args[2], "_", args[3], "_", args[4], "_", args[5], ".csv" )

file_name <- "all_res.csv"

write.csv(res_file,file=file_name,row.names=FALSE);

print("Finish R Session")
