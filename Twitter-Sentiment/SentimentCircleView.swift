//
//  SentimentCircleView.swift
//  Twitter-Sentiment
//
//  Created by Jessica Trinh on 3/17/21.
//

import SwiftUI

struct SentimentCircleView: View {
    @State var score: CGFloat = 0
    
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                Pulsation()
                CircleTrack()
                ScoreLabel(score: score)
                CircleOutline(score: score)
            }
            
        }
    }
}

struct ScoreLabel: View {
//    @Binding var sentimentScoreLabel: String
    
    var score: CGFloat = 0
    var body: some View{
        ZStack {
            Text(String(format: "%.0f", score))
                .font(.system(size: 65))
                .fontWeight(.heavy)
        }
    }
}

struct CircleOutline: View {
    var score: CGFloat = 0
    var colors: [Color] = [Color.circleOutlineColor]
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.clear)
                .frame(width: 250, height: 250)
                .overlay(
                    Circle()
                        .trim(from: 0, to: score * 0.01)
                        .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                        .fill(AngularGradient(gradient: .init(colors: colors), center: .center, startAngle: .zero, endAngle: .init(degrees: 360)))
                ).animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0))
        }
    }
}

struct CircleTrack: View {
    var colors: [Color] = [Color.circleTrackColor]
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.backgroundColor)
                .frame(width: 250, height: 250)
                .overlay(
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 20))
                        .fill(AngularGradient(gradient: .init(colors: colors), center: .center))
                ).animation(.spring(response: 2.0, dampingFraction: 1.0, blendDuration: 1.0))
        }
    }
}

struct Pulsation: View {
    @State private var pulsate = false
    var color = Color.circlePulsatingColor
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 245, height: 245)
                .scaleEffect(pulsate ? 1.3 : 1.1)
                .animation(Animation.easeInOut(duration: 1.1)
                            .repeatForever(autoreverses: true))
                .onAppear {
                    self.pulsate.toggle()
                }
        }
    }
}

struct SentimentCircleView_Previews: PreviewProvider {
    static var previews: some View {
        SentimentCircleView()
    }
}
