import SwiftUI

struct CustomColors {
    static let darkBlue = Color(red: 0.1, green: 0.2, blue: 0.3)
    static let darkGray = Color(red: 0.4, green: 0.4, blue: 0.4)
    static let backGroundColor = Color(red: 0.9, green: 0.95, blue: 1.0)
}

struct DoctorProfileView: View {
    var body: some View {
        ZStack {
            CustomColors.backGroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image("doctor1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(CustomColors.darkBlue, lineWidth: 4))
                    .shadow(radius: 10)
                
                Text("Dr. Lana Smith")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(CustomColors.darkBlue)
                
                HStack {
                    Image(systemName: "heart.text.square")
                        .foregroundColor(Color.white)
                    
                    Text("Dermatologist")
                        
                }.fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(5)
                .background(CustomColors.darkBlue)
                .clipShape(Capsule())
                .padding(5)
                .background(CustomColors.darkGray)
                .clipShape(Capsule())
                
                HStack {
                    InformationView(icon: "person.2", text: "110+ Patients", iconColor: CustomColors.darkGray, textColor: CustomColors.darkBlue)
                    InformationView(icon: "clock", text: "20 years Experience", iconColor: CustomColors.darkGray, textColor: CustomColors.darkBlue)
                    InformationView(icon: "star", text: "4.7 Rating", iconColor: CustomColors.darkGray, textColor: CustomColors.darkBlue)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Available Time")
                        .fontWeight(.bold)
                        .foregroundColor(CustomColors.darkBlue)
                    Text("09:00AM - 14:00PM")
                        .foregroundColor(CustomColors.darkGray)
                    Divider()
                    Text("Doctor details")
                        .fontWeight(.bold)
                        .foregroundColor(CustomColors.darkBlue)
                    Text("Dr. Lana Smith is one of the best Cardiologists, having over 20 years of experience in the medical field.")
                        .foregroundColor(CustomColors.darkGray)
                    Divider()
                    Text("Reviews")
                        .fontWeight(.bold)
                        .foregroundColor(CustomColors.darkBlue)
                    Text("90 Reviews")
                        .foregroundColor(CustomColors.darkGray)
                    // Add a list or ScrollView of reviews here
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    // Handle booking appointment
                }) {
                    Text("Book Appointment")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(CustomColors.darkBlue)
                        .cornerRadius(10)
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 5)
            .padding()
        }
    }
}

struct InformationView: View {
    let icon: String
    let text: String
    let iconColor: Color
    let textColor: Color
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(iconColor)
            Text(text)
                .font(.caption)
                .foregroundColor(textColor)
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 3)
    }
}

struct DoctorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorProfileView()
    }
}
