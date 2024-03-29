import SwiftUI



struct ReportView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let disease = "Melanoma"
    let prediction = 0.93
    let nextActions = [
            ("Avoid excessive sun exposure", "sun.max.fill"),
            ("Schedule regular skin check-ups", "calendar.badge.plus"),
            ("Use sunscreen daily", "umbrella.fill"),
            ("Wear protective clothing outdoors", "figure.walk.circle.fill")
        ]
    
    @State private var animateGauges = false
    @State private var showNextActions = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    headerView

                    diseaseDetectedView
                    
                    riskCertaintyView
                        .padding()
                        .animation(Animation.easeInOut(duration: 1.5).delay(0.5), value: animateGauges)
                        .onAppear {
                            self.animateGauges = true
                        }
                    
                    
                    VStack(alignment: .leading) {
                        HStack {
                                Text("\(disease)")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                            Spacer()
                        }
                        .padding()
                        Text(getDescription(disease:disease))
                            .padding(.horizontal)
                            .foregroundColor(Color.black)
                    }
                    
                    nextActionsView
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                        .onAppear {
                            withAnimation(.spring()) {
                                self.showNextActions = true
                            }
                        }
                    
                    Text("Location, San Antonio").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).foregroundColor(.black)
                    DoctorsListView()
                }
            }
            .background(Color.backGroundColor)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(Color.darkBlue)
            }
            Spacer()
            Text("Report")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.darkBlue)
            Spacer()
        }
        .padding()
        .background(Color.backGroundColor)
    }
    
    private var diseaseDetectedView: some View {
        Text("Disease Detected: \(disease)")
            .font(.title2)
            .fontWeight(.semibold)
            .foregroundColor(Color.black)
            .padding()
            .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.darkGray, radius: 3, x: 0, y: 3))
            .padding()
    }
    
    private var riskCertaintyView: some View {
        HStack(spacing: 20) {
            RiskLevelView(riskLevel: getRiskLevel(disease: disease), animate: $animateGauges)
            
            CertaintyGauge(certaintyPercentage: Double(prediction), animate: $animateGauges)
        }
    }
    

    
    var nextActionsView: some View {
            VStack(alignment: .leading) {
                Text("Next Actions")
                    .font(.headline)
                    .foregroundColor(Color.black) // Ensure you have this color defined in your asset catalog
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(nextActions, id: \.0) { action, icon in
                            HStack {
                                Image(systemName: icon)
                                    .font(.system(size: 32)) // Larger icon size
                                    .foregroundColor(getColorForAction(action: action))
                                    .padding(.trailing, 5)
                                Text(action)
                            }
                            .padding()
                            .frame(width: 200, height: 100)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .foregroundColor(Color.gray)
                        }
                    }
                    .padding(.leading)
                }
            }
        }
        
        // Function to return a color based on the action
        func getColorForAction(action: String) -> Color {
            switch action {
            case "Avoid excessive sun exposure":
                return Color.yellow // Sun-related color
            case "Schedule regular skin check-ups":
                return Color.blue // Health-related, trust and security
            case "Use sunscreen daily":
                return Color.orange // Sunscreen, warmth and protection
            case "Wear protective clothing outdoors":
                return Color.green // Nature, outdoors
            default:
                return Color.gray // Fallback color
            }
        }
    func getDescription(disease: String) -> String {
    switch disease {
    case "Melanoma":
        return "Melanoma is a severe skin cancer arising from pigment-producing cells, melanocytes. More aggressive than other skin cancers, it can spread quickly if untreated. Sun exposure and genetics increase risk. Prevention with sunscreen and protective clothing, along with regular skin checks, is crucial for early detection and treatment" // Sun-related color
    case "Nevus":
        return "A nevus is a common skin lesion, often referred to as a mole, which can be either congenital or acquired. It is usually a benign growth that consists of a cluster of melanocytes, the cells responsible for skin pigmentation." // Health-related, trust and security
    case "Basal cell carcinoma":
        return "Basal cell carcinoma (BCC) is the most common type of skin cancer, originating from the basal cells in the epidermis, the skin's outermost layer. It is characterized by slow growth and seldom spreads to other parts of the body, but can cause significant local damage if not treated early." // Sunscreen, warmth and protection
    case "Seborrheic keratosis":
        return "Seborrheic keratosis is a common, benign skin growth that appears as a brown, black, or light tan spot on the face, chest, shoulders, or back. It has a waxy, scaly, slightly elevated appearance, often resembling a wart or a sticker stuck to the skin." // Nature, outdoors
    default:
        return "None" // Fallback color
    }
}
    

        func getRiskLevel(disease: String) -> String {
        switch disease {
        case "Melanoma":
            return "High" // Sun-related color
        case "Nevus":
            return "Low" // Health-related, trust and security
        case "Basal cell carcinoma":
            return "Medium" // Sunscreen, warmth and protection
        case "Seborrheic keratosis":
            return "High" // Nature, outdoors
        default:
            return "None" // Fallback color
        }
    }
    
    }

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView()
    }
}


struct RiskLevelView: View {
    var riskLevel: String
    @Binding var animate: Bool

    var body: some View {
        VStack {
            Text("Risk Level:")
                .font(.headline)
                .foregroundColor(Color.black)
            ZStack {
                Circle()
                    .stroke(lineWidth: 10.0)
                    .opacity(0.3)
                    .foregroundColor(riskLevelColor)

                Circle()
                    .trim(from: 0.0, to: animate ? riskLevelTrim : 0.0)
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(riskLevelColor)
                    .rotationEffect(Angle(degrees: 270.0))
                
                Text(riskLevel)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color.black)
            }
            .frame(width: 100, height: 100)
        }
        .frame(width: 130, height: 130)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .animation(.linear(duration: 2.0), value: animate)
    }

    private var riskLevelColor: Color {
        switch riskLevel {
        case "Low":
            return .green
        case "Medium":
            return .yellow
        case "High":
            return .red
        default:
            return .gray
        }
    }

    private var riskLevelTrim: CGFloat {
        switch riskLevel {
        case "Low":
            return 1.0 / 3.0
        case "Medium":
            return 2.0 / 3.0
        case "High":
            return 1.0
        default:
            return 0.0
        }
    }
}

struct CertaintyGauge: View {
    var certaintyPercentage: Double
    @Binding var animate: Bool

    var body: some View {
        VStack {
            Text("Certainty:")
                .font(.headline)
                .foregroundColor(Color.black)
            ZStack {
                Circle()
                    .stroke(lineWidth: 10.0)
                    .opacity(0.3)
                    .foregroundColor(Color.blue)

                Circle()
                    .trim(from: 0.0, to: animate ? certaintyPercentage : 0.0)
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270.0))
                
                Text("\(Int(certaintyPercentage * 100))%")
                    .font(.title)
                    .foregroundColor(Color.black)
                    .bold()
            }
            .frame(width: 100, height: 100)
        }
        .frame(width:130, height: 130)
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .animation(.linear(duration: 2.0), value: animate)
    }
}


