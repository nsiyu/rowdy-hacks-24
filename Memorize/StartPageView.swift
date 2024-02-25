import SwiftUI

struct StartPageView: View {
    var body: some View {
        ZStack {
            Color(red: 0.9, green: 0.95, blue: 1.0)
                .ignoresSafeArea()

            VStack {
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.09)
                
                Image("healthLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 150)
                
                Text("DermAI")
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundColor(.darkBlue)

                Spacer()

                VStack(spacing: 35) {
                    Text("AI-Powered Skin Cancer Detection for everyone")
                        .font(.headline)
                        .foregroundColor(.darkBlue)
                        .multilineTextAlignment(.center)
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Get Started")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 50)
                            .background(Color.darkBlue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal, 30)
        
                Spacer()
                    .frame(height: UIScreen.main.bounds.height * 0.15)
            }
            .padding()
        }
    }
}

struct StartPageView_Previews: PreviewProvider {
    static var previews: some View {
        StartPageView()
    }
}
