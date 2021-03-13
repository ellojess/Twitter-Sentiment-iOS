//
//  ContentView.swift
//  Twitter-Sentiment
//
//  Created by Jessica Trinh on 3/12/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0, green: 172, blue: 238)
                .edgesIgnoringSafeArea(.all)
        Text("Hello, world!")
            .font(.title)
            .bold()
            .foregroundColor(.white)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
