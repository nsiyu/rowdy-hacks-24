import SwiftUI

struct DoctorCard: Identifiable {
    let id = UUID()
    let name: String
    let specialty: String
    let rating: Double
    let reviews: Int
    let image: String

}

struct DoctorCardView: View {
    var doctor: DoctorCard
    
    var body: some View {
            VStack(alignment: .leading) {
                Image(doctor.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150) // Set the frame size as before
                    .cornerRadius(12) // Apply corner radius to round the corners
                    .clipped()
                
                Text(doctor.name)
                    .fontWeight(.bold)
                    .lineLimit(1)
                    .foregroundColor(Color.black)
                    .padding(.leading, 5)
                
                
                Text(doctor.specialty)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .padding(.leading, 6)
                    .padding([ .bottom], 2) // Optional: Adjust padding as needed
                
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(doctor.rating, specifier: "%.1f") (\(doctor.reviews) Reviews)")
                        .foregroundColor(.black)
                        .font(.caption)
                }.padding(.bottom) // Add padding at the bottom if needed
            }
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 4)
        }
    
}

struct DoctorsListView: View {
    
    let doctors = [
        DoctorCard(name: "Dr. Lana Smith", specialty: "Dermatologist", rating: 4.5, reviews: 90, image: "doctor1"),
        DoctorCard(name: "Dr. John Dalton", specialty: "Dermatologist", rating: 4.6, reviews: 80, image: "doctor2"),
        DoctorCard(name: "Dr. Chris Warner", specialty: "Dermatologist", rating: 4.7, reviews: 70, image: "doctor3"),
        DoctorCard(name: "Dr. Alex Johnson", specialty: "Dermatologist", rating: 4.8, reviews: 60, image: "doctor4")
    ]
    
    var body: some View {
            
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(doctors) { doctor in
                            NavigationLink(destination: DoctorProfileView(doc:doctor)) {
                                                DoctorCardView(doctor: doctor)
                                            }
                                            .buttonStyle(PlainButtonStyle()) // Use this to prevent the button from altering the appearance of the card
                                        }
                        }
                    }
                    .padding(.horizontal)
                }
         }
            

        }


struct DoctorsListView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorsListView()
    }
}
