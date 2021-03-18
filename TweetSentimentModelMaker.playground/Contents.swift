import Cocoa
import CreateML

// data from Sanders Analysis
// convert CSV data format to MLDataTable format
//let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/jessicatrinh/Desktop/twitter-sanders-apple3.csv"))
let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/jessicatrinh/Desktop/twitter-training-dataset.csv"))

// randomly take Twitter Sentiment Analysis Data
// use 80% for training and 20% for testing
// use seed 5 to track instances of randomness
let(trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

// create machine learning model by passing in training data
// name of textColumn and labelColumn must match what's given in CSV format
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

// test machine learning model (sentimentClassifier) against testingData
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

// test accurracy of machine learning model
// currently ~70% accurracy rate
// MARK: TODO - feed model more data to get closer to 75-80%
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

// create metadata
let metadata = MLModelMetadata(author: "Jessica Trinh", shortDescription: "model trained to classify sentiment (negative, neutral, positive) on Tweets", license: "MIT", version: "1.0")

// write to URL to save metadata
try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/jessicatrinh/Desktop/TweetSentimentClassifier.mlmodel"))

// tests for sentimentClassifier
try sentimentClassifier.prediction(from: "@Robinhood is a terrible company!") // return "Neg"
try sentimentClassifier.prediction(from: "#bitcoin is 🤯") // return "Neutral"
try sentimentClassifier.prediction(from: "To the moon!!! Hold!! 🚀🌕💎") // return "Pos"
