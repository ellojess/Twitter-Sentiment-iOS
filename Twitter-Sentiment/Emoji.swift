//
//  Emoji.swift
//  Twitter-Sentiment
//
//  Created by Jessica Trinh on 3/16/21.
//

enum SentimentKind: String {
    case offTheChart, wonderful, great, good, okay, notOkay, bad, horrible

    var emoji: String {
        switch self {
            case .offTheChart:
                return "🤩"
            case .wonderful:
                return "😍"
            case .great:
                return "😄"
            case .good:
                return "😃"
            case .okay:
                return "😐"
            case .notOkay:
                return "😕"
            case .bad:
                return "😨"
            case .horrible:
                return "🤢"
        }
    }
}
