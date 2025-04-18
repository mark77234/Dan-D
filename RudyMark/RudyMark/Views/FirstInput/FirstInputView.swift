//
//  FirstInputView.swift
//  RudyMark
//
//  Created by 트루디 on 3/25/25.
//
import SwiftUI

struct FirstInputView: View {
    @StateObject var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            InputBodyView()
                .navigationDestination(for: Screen.self) { screen in
                    switch screen {
                    case .InputBody: InputBodyView()
                    case .InputGender: InputGenderView()
                    case .InputPillTime: InputPillTimeView()
                    case .InputBloodTime: InputBloodTimeView()
                    case .Home: TabBar()
                    }
                }
        }
        .environmentObject(router) // 여기 선언해야 자식뷰에 일일이 넘겨주지 않아도 됨
    }
}
