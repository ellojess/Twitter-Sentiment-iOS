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
    @State private var beating = false
    
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
                    .foregroundColor(Color(beating ? .systemPink : .systemRed))
                    .scaleEffect(beating ? 1 : 1.25)
                    .animation(Animation.interpolatingSpring(stiffness: 30, damping: 15).repeatForever(autoreverses: false))
                    .onAppear(){
                        self.beating.toggle()
                    }
            
                Text("Search Twitter")
                    .font(.callout)
                    .bold()
                TextField("Enter hashtag or phrase (i.e. #blessed)", text: $searchTerm)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.twitter)
                Button(action: {
                    fetchTweets()
                }) {
                    ZStack {
                        Image("twitter-logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150)
                        Text("Search")
                    }
                }
                

            }
        }
    }
    
    // filter tweets, performing search query,
    // in english w/ maximum of 100 tweets returned
    // and .extended to return full/max 280 characters from Twitter
    func fetchTweets() {
        
            NetworkManager.shared.getTweets(for: "\(searchTerm)") { [self] (result) in
                guard self != nil else { return }
                
                switch result {
                case .success(let tweetList):
                    
                    var tweets = [TweetSentimentClassifierInput]()
                    
                    // MARK: TODO: parse w/ encode/decode
                    
                    // parse all tweets out of JSON
                    // add items to array for prediction
                    for i in tweetList {
                        // parse JSON w/ SwiftyJSON
                        // get full_text property of first result/tweet
                        
                        let tweetForClassification = TweetSentimentClassifierInput(text: i.text)
                        tweets.append(tweetForClassification)
                    
                    }
                    
                    // make sentiment prediction with fetched tweets
                    makeSentimentPrediction(with: tweets)
                    
                    // print(tweets)
                case .failure(let error):
                    print(error)
            }
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

