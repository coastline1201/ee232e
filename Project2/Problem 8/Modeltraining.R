# this script is used to train models for regression for both NNt and lm through the use of caret package. It also predicts the rates for the three movies using the trained model.
library(caret)
set.seed(3456)
ClassData = RM[,1]
ParaData = RM[,2:51]

trainIndex <- createDataPartition(ClassData, p = .8,list = FALSE,times = 1)
trainPara = as.numeric(ParaData[trainIndex,])
testPara = as.numeric(ParaData[-trainIndex,])
trainClass = as.numeric(ClassData[trainIndex])
testClass = as.numeric(ClassData[-trainIndex])
data = RM[trainIndex,]
colnames(data) = c(letters[1])
data = data.frame(data)
fitControl <- trainControl(method = "repeatedcv", number = 2,repeats = 2)
NNTFit1 <- train(trainPara,trainClass,method = "nnet", trControl = fitControl)
summary(NNTfit1)
LMFit1 <- train(y ~ ., data = data, method = "lm", trControl = fitControl)
summary(Lmfit1)
NNTratepredict = predict(NNtFit1, Node[1:3,2:51])
LMratepredict = predict(LMFit1, Node[1:3,2:51])
