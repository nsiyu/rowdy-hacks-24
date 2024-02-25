import SwiftUI


struct ProfileView: View {
    @State private var username: String = "User123"
    @State private var email: String = "user@example.com"
    @State private var bio: String = "Short bio about yourself"

    var body: some View {
        ZStack {
            Color.backGroundColor
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 20) {
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.darkBlue)

                VStack(spacing: 15) {
                    ProfileInfoView(label: "Username", info: $username)
                    ProfileInfoView(label: "Email", info: $email)
                }

                Spacer()
                
                Button("Save Changes") {
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.darkBlue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct ProfileInfoView: View {
    let label: String
    @Binding var info: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.headline)
                .foregroundColor(.darkBlue)
            TextField("", text: $info)
                .padding()
                .background(Color.white)
                .foregroundColor(.darkGray)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.darkGray, lineWidth: 1)
                )
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
