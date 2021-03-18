//
//  Color-Extension.swift
//  Twitter-Sentiment
//
//  Created by Jessica Trinh on 3/17/21.
//

import SwiftUI

extension Color {
    static func rgb(r: Double, g: Double, b: Double) -> Color {
        return Color(red: r/255, green: g/255, blue: b/255)
    }
    static let backgroundColor = Color.rgb(r: 21, g: 22, b: 33)
    static let circleOutlineColor = Color.rgb(r: 254, g: 255, b: 203)
    static let circleTrackColor = Color.rgb(r: 45, g: 56, b: 95)
    static let circlePulsatingColor = Color.rgb(r: 73, g: 113, b: 148)
}
