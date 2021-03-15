//
//  ContentView.swift
//  Twitter-Sentiment
//
//  Created by Jessica Trinh on 3/12/21.
//

import SwiftUI
import SwifteriOS

struct ContentView: View {
    @State var searchTerm: String = ""
    @State private var searchButtonPressed = false
    @State var sentiment = "😁"
    
    let swifter = Swifter(consumerKey: apiKey, consumerSecret: apiSecretKey)
    
    
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
                TextField("Enter hashtag or phrase", text: $searchTerm, onEditingChanged: {(changed) in
                    print("changed \(changed)")
                }) {
                    print("searchTerm onCommit")
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(
                    action: searchTweet,
                    label: {Text("Search")}
                )
            }.padding()
        }
    }
    
    func searchTweet() {
        swifter.searchTweet(using: "@Apple") { (results, metadata) in
            print(results)
        } failure: { (error) in
            print("Error w/ API Request: \(error)")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
