//
//  DailyStatsView.swift
//  RudyMark
//
//  Created by 트루디 on 7/22/25.
//

import SwiftUI

struct DailyStatsView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text("2025.04.29 (화)")
                    .font(.setPretendard(weight: .bold, size: 18))
                    .padding(.bottom, 40)
                    .padding(.top, 20)
                HStack(spacing: 0) {
                    Text("오늘의 혈당")
                        .font(.headline)
                    
                    Spacer()
                    
                    HStack {
                        Image("water")
                        Text("총 9잔")
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            
                    }
                    .padding(.horizontal, 13)
                    .padding(.vertical, 7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.strokeGray)
                    )
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
                
                BloodSugarCardView()
                CalorieCardView()
                
            }
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
        .padding(.horizontal, 11)
    }
}

#Preview {
    DailyStatsView()
}

import SwiftUI

struct BloodSugarCardView: View {
    var glucoseData: [CGFloat] = [92, 104, 123, 97]
    var labels: [String] = ["아침", "점심", "저녁", "야식"]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            GlucoseGraphView(values: glucoseData)
                .frame(height: 100)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("혈당 스파이크").font(.caption)
                    Text("1회").bold()
                }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("정상 범위").font(.caption)
                    Text("89%").bold()
                }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("최고 혈당").font(.caption)
                    Text("123 mg/dL").bold()
                }
                Spacer()
                VStack(alignment: .leading, spacing: 4) {
                    Text("최저 혈당").font(.caption)
                    Text("92 mg/dL").bold()
                }
            }
            .font(.footnote)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        .shadow(radius: 1)
    }
}

struct GlucoseGraphView: View {
    var values: [CGFloat]

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / CGFloat(values.count - 1)
            let maxVal = values.max() ?? 1
            let minVal = values.min() ?? 0
            let points = values.enumerated().map { index, value in
                CGPoint(
                    x: CGFloat(index) * width,
                    y: (1 - (value - minVal) / (maxVal - minVal)) * geometry.size.height
                )
            }

            ZStack {
                // Line
                Path { path in
                    path.move(to: points.first ?? .zero)
                    for point in points.dropFirst() {
                        path.addLine(to: point)
                    }
                }
                .stroke(Color.purple, lineWidth: 2)

                // Dots
                ForEach(Array(points.enumerated()), id: \.offset) { i, point in
                    Circle()
                        .fill(i == 2 ? Color.orange : Color.purple)
                        .frame(width: 8, height: 8)
                        .position(point)
                }
            }
        }
    }
}

struct CalorieCardView: View {
    var calorieData: [CGFloat] = [702,538, 803, 756]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("오늘의 칼로리")
                    .font(.headline)
                Spacer()
                Text("총 1250 kcal")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            CalorieGraphView(values: calorieData)
                .frame(height: 100)

            HStack(spacing: 16) {
                Label("140g", systemImage: "circle.fill")
                    .foregroundColor(.blue)
                Label("75g", systemImage: "circle.fill")
                    .foregroundColor(.green)
                Label("45g", systemImage: "circle.fill")
                    .foregroundColor(.yellow)
            }
            .font(.footnote)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white))
        .shadow(radius: 1)
    }
}

struct CalorieGraphView: View {
    var values: [CGFloat]

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / CGFloat(values.count - 1)
            let maxVal = values.max() ?? 1
            let minVal = values.min() ?? 0
            let points = values.enumerated().map { index, value in
                CGPoint(
                    x: CGFloat(index) * width,
                    y: (1 - (value - minVal) / (maxVal - minVal)) * geometry.size.height
                )
            }

            ZStack {
                // Line
                Path { path in
                    path.move(to: points.first ?? .zero)
                    for point in points.dropFirst() {
                        path.addLine(to: point)
                    }
                }
                .stroke(Color.green, lineWidth: 2)

                // Dots
                ForEach(Array(points.enumerated()), id: \.offset) { _, point in
                    Circle()
                        .fill(Color.green)
                        .frame(width: 8, height: 8)
                        .position(point)
                }
            }
        }
    }
}

//#Preview {
//    VStack(spacing: 24) {
//        BloodSugarCardView()
//        CalorieCardView()
//    }
//    .padding()
//    .background(Color(.systemGroupedBackground))
//}
