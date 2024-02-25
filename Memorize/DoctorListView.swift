import SwiftUI

struct DoctorCard: Identifiable {
    let id = UUID()
    let name: String
    let specialty: String
    let rating: Double
    let reviews: Int
}

struct DoctorCardView: View {
    var doctor: DoctorCard
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 150, height: 150)
                .cornerRadius(12)
            
            Text(doctor.name)
                .fontWeight(.bold)
                .lineLimit(1)
            
            Text(doctor.specialty)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)
            
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(doctor.rating, specifier: "%.1f") (\(doctor.reviews) Reviews)")
                    .font(.caption)
            }
        }
        .padding()
        .frame(width: 150, height: 250)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

struct DoctorsListView: View {
    
    let doctors = [
        DoctorCard(name: "Dr. Lana Smith", specialty: "Cardiologist", rating: 4.5, reviews: 90),
        DoctorCard(name: "Dr. Jhon Dalton", specialty: "Audiologist", rating: 4.6, reviews: 80),
        DoctorCard(name: "Dr. Chris Warner", specialty: "Dermatologist", rating: 4.7, reviews: 70),
        DoctorCard(name: "Dr. Alex Johnson", specialty: "Neurologist", rating: 4.8, reviews: 60)
    ]
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(doctors) { doctor in
                        DoctorCardView(doctor: doctor)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct DoctorsListView_Previews: PreviewProvider {
    static var previews: some View {
        DoctorsListView()
    }
}
