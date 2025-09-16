import SwiftUI

// MARK: - 메인 MainStatsView
struct MainStatsView: View {
    @StateObject private var viewModel = CalendarViewModel()
    // 선택된 날짜에 대한 상태. 현재 날짜로 초기화하여 동적으로 시작
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // 헤더: 월 및 연도 선택
                    MonthYearSelectorView(viewModel: viewModel)
                    
                    // 달력 그리드
                    CalendarView(viewModel: viewModel)
                        .padding(.horizontal, 20)
                    
                    // 미션 도전 텍스트
                    MissionChallengePromptView()
                    
                    // 미션 목록
                    MissionListView()
                        .padding(.horizontal, 21)
                    
                    // 선택된 날짜 표시
                    SelectedDateDisplayView(viewModel: viewModel)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
    }
}

// MARK: - MissionChallengePromptView
struct MissionChallengePromptView: View {
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            Text("이번 달 미션")
                .font(.setPretendard(weight: .bold, size: 18))
                .foregroundStyle(.black)
            Text("에 도전해볼까요?")
                .font(.setPretendard(weight: .semiBold, size: 18))
            
            Image("popoHi")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 29, height: 29)
            
            Spacer()
        }
        .padding()
        .background(
            Rectangle()
                .fill(Color.primaryPurple.opacity(0.2))
        )
        .frame(height: 55)
        .padding(.vertical, 10)
    }
    
}

// MARK: - Mission 모델
struct Mission: Identifiable {
    let id = UUID()
    let name: String
    let status: String
    let iconName: String
    let statusColor: Color
}

// MARK: - MissionCardView
struct MissionCardView: View {
    let mission: Mission
    
    var body: some View {
        HStack {
            Image("grapes")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20)
            
            Text(mission.name)
                .font(.setPretendard(weight: .semiBold, size: 18))
                .foregroundStyle(.black)
            
            Spacer()
            
            Text(mission.status)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(mission.statusColor)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.moreLightPurple)
                .shadow(color: Color.black.opacity(0.25), radius: 4.24, x: 0, y: 1)
                .frame(height: 63)
        )
    }
}

// MARK: - MissionListView
struct MissionListView: View {
    let missions: [Mission] = [
        Mission(name: "포도알 모으기", status: "25 / 30", iconName: "grape_icon", statusColor: Color.black),
        Mission(name: "단디하자!", status: "14일째", iconName: "grape_icon", statusColor: Color.black),
        Mission(name: "혈당 스파이크 10회 미만", status: "완수중", iconName: "grape_icon", statusColor: Color.lightGray)
    ]
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(missions) { mission in
                MissionCardView(mission: mission)
                    .padding(.bottom, 13)
            }
        }
    }
}

// MARK: - SelectedDateDisplayView (선택된 날짜를 하단에 표시)
struct SelectedDateDisplayView: View {
    @ObservedObject var viewModel: CalendarViewModel
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("선택된 날짜: \(dateFormatter.string(from: viewModel.selectedDate))")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
                .padding(.top, 10)
            
        }
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.5), radius: 2, x: 0, y: 1)
        .padding(.horizontal, 11)
    }
}


// MARK: - 미리보기 제공자
struct MainStatsView_Previews: PreviewProvider {
    static var previews: some View {
        MainStatsView()
    }
}
