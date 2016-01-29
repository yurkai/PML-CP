library(caret)

train <- read.csv("pml-training.csv", stringsAsFactors = FALSE)
test <- read.csv("pml-testing.csv", stringsAsFactors = FALSE)

minusCol1 <- colSums(train == "") > 10000
minusCol1[is.na(minusCol1)]  <- TRUE
minusCol2 <- colSums(is.na(train)) > 10000
minusCol <- minusCol1 | minusCol2
minusCol[1:7] <- TRUE

minusCol[c(1, 3:7)] <- TRUE


train <- train[,!minusCol]
tr$classe <- as.factor(tr$classe)

# Accuracy : 0.9922
# test - 100%
fit1 <- train(classe ~., data = tr, method = "gbm")
# fit <- readRDS("gbm01.rds");correct <- predict(fit, test)

# Accuracy : 0.9466 
# test - 100%
fit2 <- train(classe ~ ., data = tr, method = "svmRadialWeights")

# Accuracy : 0.7488 
# test - 14/20
fit3 <- train(classe ~ ., data = tr, method = "lda")

# removing num_window variable
tr <- tr[-2]

# Accuracy : 0.7345 
# test - 15/20
fit31 <- lda(classe ~ ., data = tr)
# confusionMatrix(predict(fit31, tr)$class, tr$classe)

# Accuracy : 0.8216  
# test - 16/20
fit4 <- train(classe ~ .,method="svmLinear",data=tr)



confusionMatrix(predict(fit1, train), train$classe)
predict(fit1, test)



# correct answers
# B A B A A E D B A A B C B A E E A B B B
# B A B A A C D D A A D A B A B A A B B B

