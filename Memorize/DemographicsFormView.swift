import SwiftUI

struct DemographicsFormView: View {
    @State private var age: String = ""
    @State private var race: String = ""
    @State private var gender: String = "Male"
    let genderOptions = ["Male", "Female", "Other"]
    let userId: String

    var body: some View {
        ZStack {
            Color(red: 0.9, green: 0.95, blue: 1.0)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Enter your info")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.darkBlue)
                        .padding(.top, 40)

                    InputField(title: "Age", placeholder: "Enter your age", text: $age)
                    InputField(title: "Race", placeholder: "Enter your race", text: $race)

                    InputField(title: "Gender", placeholder: "Enter your gender", text: $gender)


                    NavigationLink(destination: MainView(userId: userId)) {
                        
                        Text("Submit")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.darkBlue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 20)
                }
                .padding(.horizontal, 30)
            }
        }
    }
}

struct InputField: View {
    var title: String
    var placeholder: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.darkBlue)
            TextField(placeholder, text: $text)
                .padding()
                .background(Color.white)
                .foregroundColor(.darkGray)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}

struct PickerField: View {
    var title: String
    @Binding var selection: String
    var options: [String]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(Color.darkBlue)
            Picker(selection: $selection, label: Text(selection).foregroundColor(.darkGray)) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
}

