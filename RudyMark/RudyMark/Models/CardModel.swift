//
//  Untitled.swift
//  RudyMark
//
//  Created by 이병찬 on 3/25/25.
//

import SwiftUI

struct MiniCard{
    let title: String
    var value: String? // 일단 String 추후 Float으로 교체
    var progress: Float?
    var max: Float?
    var barColor: Color?
}

struct CustomButton{
    let name: String
    let buttonColor: Color?
    var icon: String?
    var destination: AnyView?
    
}

struct CardData {
    let title: String
    var description: String?
    let backgroundColor: Color
    let mainTextColor: Color
    let subTextColor: Color
    let height: CGFloat
    var progress: Float?
    var max: Float?
    var cardCount: Int?
    var miniCards: [MiniCard]?
    var miniCardsColor: Color?
    var miniCardsSize: CGFloat?
    var MealButtons: [CustomButton]?
}
