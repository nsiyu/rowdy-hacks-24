import SwiftUI
struct MainView: View {
    @State private var selectedTab = 0
    let userId: String

    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTab) {
                HomePageView(userId: userId)
                    .tag(0)

                MainCameraView()
                    .tag(1)

                ChatBotView()
                    .tag(2)
            }
            .padding(.bottom, -100) 

            CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}


struct CustomTabBar: View {
    @Binding var selectedTab: Int

    var body: some View {
        HStack {
            Spacer()

            Button(action: {
                selectedTab = 0
            }) {
                Image(systemName: "house.fill")
                    .padding()
            }
            .foregroundColor(selectedTab == 0 ? .blue : .gray)

            Spacer()

            Button(action: {
                selectedTab = 1
            }) {
                Image(systemName: "camera.fill")
                    .padding()
            }
            .foregroundColor(selectedTab == 1 ? .blue : .gray)

            Spacer()

            Button(action: {
                selectedTab = 2
            }) {
                Image(systemName: "person.fill")
                    .padding()
            }
            .foregroundColor(selectedTab == 2 ? .blue : .gray)

            Spacer()
        }
        .frame(height: 50)
        .background(Color.backGroundColor)
        .shadow(radius: 2)
    }
}

