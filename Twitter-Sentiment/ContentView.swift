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
    @State var sentiment = "😁"
    
    // authenticate w/ Twitter API through Swifter framework
    let swifter = Swifter(consumerKey: apiKey, consumerSecret: apiSecretKey)
    
    let sentimentClassifier = TweetSentimentClassifier()
    
    
    var body: some View {
        // backgrounds color
        ZStack {
            Color(red: 0, green: 172, blue: 238)
                .edgesIgnoringSafeArea(.all)
            
            // UI for label and textfield
            VStack(alignment: .leading) {
                Text("Sentiment Score: ")
                    .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Text("Search Twitter")
                    .font(.callout)
                    .bold()
                TextField("Enter hashtag or phrase", text: $searchTerm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.twitter)
                
                Button(action: {
                    searchTweet()
                }) {
                    Text("Search")
                }
            }.padding()
        }
    }
    
    // filter tweets, performing search query,
    // in english w/ maximum of 100 tweets returned
    // and .extended to return full/max 280 characters from Twitter
    func searchTweet() {
        swifter.searchTweet(using: "\(searchTerm)", lang: "en", count: 100, tweetMode: .extended, success: { (results, metadata) in
//            print(results)
            
            var tweets = [TweetSentimentClassifierInput]()
            
            // MARK: TODO: parse w/ encode/decode
            
            // parse all tweets out of JSON
            // add items to array for prediction
            for i in 0..<100 {
                // parse JSON w/ SwiftyJSON
                // get full_text property of first result/tweet
                if let tweet = results[i]["full_text"].string {
                    let tweetForClassification = TweetSentimentClassifierInput(text: tweet)
                    tweets.append(tweetForClassification)
                }
            }
            
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
                
                print(sentimentScore)
                
//                print(predictions[0].label)
            } catch {
                print("Error making prediction: \(error)")
            }
            
            
//            print(tweets)
            
        }) { (error) in
            print("Error w/ API Request: \(error)")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
