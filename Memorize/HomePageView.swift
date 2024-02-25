import SwiftUI

struct HomePageView: View {
    @StateObject private var viewModel = HomePageViewModel()

    let userId: String
    
    var body: some View {
        ScrollView {
            ProfileAndNotifyView()
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Hi \(viewModel.username),")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.darkBlue)
                    
                    Text("Let's keep your skin healthy.")
                        .font(.headline)
                        .foregroundColor(Color.darkBlue)
                }
                .padding([.top, .leading, .trailing])

                SkinStatusView()

                SkinNewsCard()

                PastScansView()
                   WeatherStatusView(weatherDescription: "Sunny", temperature: 31, userGroup: "A")
                Spacer()
               
             
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchUserData(userId: userId)
        }
        .background(Color(red: 0.9, green: 0.95, blue: 1.0).ignoresSafeArea())
        
    }
}



struct SkinStatusView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .imageScale(.large)
                    .frame(width: 40, alignment: .top)
                VStack(alignment: .leading) {
                    Text("You're on track!")
                        .font(.headline)
                        .foregroundColor(Color.darkBlue)
                    Text("Next scan: 3 months")
                        .font(.subheadline)
                        .foregroundColor(Color.darkGray)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.lightGreen))
            .shadow(radius: 5)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        
    }
}

struct ProfileAndNotifyView: View{
    var body: some View{Spacer().frame(height: 10)
        HStack{
            Spacer()
            Button(action: {
                print("Notification button tapped")
            }) {
                Image(systemName: "bell.fill")
                .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)
                    .overlay(
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 8, height: 8, alignment: .topTrailing)
                            .offset(x: 5, y: -10), alignment: .topTrailing
                    )
            }
            
            Spacer().frame(width: 25)
            
          
            Button(action: {
                print("User profile button tapped")
            }) {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.blue)

            }
            
        }.padding(.trailing, 20)}
}

//struct SkinNewsCard: View {
//    var body: some View {
//        VStack(spacing: 10) {
//            Image("skinNews")
//                .resizable()
//                .scaledToFill()
//                .frame(maxWidth: .infinity, maxHeight: 120)
//                .clipped()
//
//            VStack(alignment: .leading) {
//                Text("The Latest in Skin Care")
//                    .font(.subheadline)
//                    .foregroundColor(Color.darkBlue)
//
//                Text("Discover new tips and tricks to keep your skin healthy and glowing.")
//                    .font(.caption)
//                    .foregroundColor(Color.darkGray)
//                    .lineLimit(3)
//            }
//            .padding()
//        }
//        .frame(maxWidth: .infinity)
//        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//        .shadow(radius: 5)
//        .padding(.horizontal)
//    }
//}

struct PastScansView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Past Scans")
                .font(.headline)
                .foregroundColor(Color.darkBlue)
                .padding(.bottom, 10)
            
            VStack(alignment: .leading) {
                HStack {
                    Image("one")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .cornerRadius(10)
                    
                    VStack(alignment: .leading) {
                        Text("Melanoma Detected")
                            .font(.headline)
                            .foregroundColor(Color.darkBlue)
                        Text("Date: 2024-02-25")
                            .font(.subheadline)
                            .foregroundColor(Color.darkGray)
                        Text("Urgent: Follow up with a dermatologist.")
                            .font(.subheadline)
                            .foregroundColor(Color.red)
                    }
                    .padding(.leading, 10)
                }
                .padding()
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(userId: "4da5f51e-461e-4076-a919-d31a937597c2")
    }
}

struct WeatherStatusView: View {
    var weatherDescription: String = "Sunny"
    var temperature: Int = 26
    var userGroup: String
    
    var shouldGoOutside: Bool {
        return userGroup != "A"
    }
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "sun.max.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 45)
                    .foregroundColor(.yellow)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Today's Weather: \(weatherDescription)")
                            .font(.headline)
                            .foregroundColor(Color.darkBlue)
                        Spacer()
                        Text("Temperature: \(temperature)°C")
                            .font(.subheadline)
                            .foregroundColor(Color.darkGray)
                    }
                    Text(shouldGoOutside ? "It's a great day to go outside!" : "If you're in Group A, better stay in today for your skin.")
                        .font(.headline)
                        .foregroundColor(shouldGoOutside ? Color.green : Color.red)
                        .padding(.top, 5)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 1, green: 0.8, blue: 0.8)))
            .shadow(radius: 5)
            .background()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}

struct WeatherStatusView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherStatusView(userGroup: "B")
    }
}
