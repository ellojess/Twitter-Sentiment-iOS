//
//  ContentView.swift
//  Twitter-Sentiment
//
//  Created by Jessica Trinh on 3/12/21.
//

import SwiftUI
import SwifteriOS
import CoreML
import SwiftyJSON

struct ContentView: View {
    @State var searchTerm: String = ""
    @State var sentimentScoreLabel = "0"
    @State var sentimentEmoji = "👻"
    
    // authenticate w/ Twitter API through Swifter framework
    let swifter = Swifter(consumerKey: apiKey, consumerSecret: apiSecretKey)
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    let tweetCount = 100
    
    
    var body: some View {
        // backgrounds color
        ZStack {
            Color(red: 0, green: 172, blue: 238)
                .edgesIgnoringSafeArea(.all)
            
            // UI for label and textfield
            VStack() {
                Text("Sentiment Score: \(sentimentScoreLabel)")
                    .frame(alignment: .leading)
                    .font(.system(size: 20))
                
//                SentimentCircleView()
//                    .$score = CGFloat(sentimentScoreLabel)
               
                Text("\(sentimentEmoji)")
                    .font(.system(size: 105))
                    .padding()
            
                Text("Search Twitter")
                    .font(.callout)
                    .bold()
                TextField("Enter hashtag or phrase (i.e. #blessed)", text: $searchTerm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.twitter)
                Button(action: {
                    fetchTweets()
                }) {
                    Text("Search")
                }.padding()
            }
        }
    }
    
    // filter tweets, performing search query,
    // in english w/ maximum of 100 tweets returned
    // and .extended to return full/max 280 characters from Twitter
    func fetchTweets() {
        swifter.searchTweet(using: "\(searchTerm)", lang: "en", count: tweetCount, tweetMode: .extended, success: { (results, metadata) in
            //            print(results)
            
            var tweets = [TweetSentimentClassifierInput]()
            
            // MARK: TODO: parse w/ encode/decode
            
            // parse all tweets out of JSON
            // add items to array for prediction
            for i in 0..<tweetCount {
                // parse JSON w/ SwiftyJSON
                // get full_text property of first result/tweet
                if let tweet = results[i]["full_text"].string {
                    let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                    tweets.append(tweetForClassification)
                }
            }
            
            // make sentiment prediction with fetched tweets
            makeSentimentPrediction(with: tweets)
            
//             print(tweets)
            
        }) { (error) in
            print("Error w/ API Request: \(error)")
        }
    }
    
    
    func makeSentimentPrediction(with tweets: [TweetSentimentClassifierInput]) {
        // make batch predictions
        do {
            let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            
            var sentimentScore = 0
            
            // predict sentiment of all fetched tweets
            for prediction in predictions {
                // prediction.label retrieved from mlmodel
                let sentiment = prediction.label
                
                // determine sentiment score of hashtag or phrase
                if sentiment == "Pos" {
                    // increase sentiment score by 1 if positive sentiment
                    sentimentScore += 1
                } else if sentiment == "Neg" {
                    // decrease sentiment score by 1 if negative sentiment
                    sentimentScore -= 1
                }
            }
            
            
            SentimentCircleView.init(score: CGFloat(sentimentScore))
            
            // update sentiment score label in UI
            sentimentScoreLabel = "\(sentimentScore)"
            // update sentiment emoji label in UI
            
            updateEmoji(with: sentimentScore)
//            print(sentimentScore)
            
        } catch {
            print("Error making prediction: \(error)")
        }
    }
    
    // update emoji label in UI based on sentiment score
    func updateEmoji(with sentimentScore: Int) {
        if sentimentScore > 30 { sentimentEmoji = SentimentKind.offTheChart.emoji}
        else if sentimentScore > 20 { sentimentEmoji = SentimentKind.wonderful.emoji}
        else if sentimentScore > 10 { sentimentEmoji = SentimentKind.great.emoji}
        else if sentimentScore > 0 { sentimentEmoji = SentimentKind.good.emoji}
        else if sentimentScore == 0 {sentimentEmoji = SentimentKind.okay.emoji}
        else if sentimentScore > -10 {sentimentEmoji = SentimentKind.notOkay.emoji}
        else if sentimentScore > -20 {sentimentEmoji = SentimentKind.bad.emoji}
        else {sentimentEmoji = SentimentKind.horrible.emoji}
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
