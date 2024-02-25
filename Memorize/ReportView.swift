import SwiftUI

struct ReportView: View {
    @Environment(\.presentationMode) var presentationMode
    let placeholderFindings = [
        ("News 1", "https://www.example.com/news1"),
        ("News 2", "https://www.example.com/news2"),
        ("News 3", "https://www.example.com/news3")
    ]
    @State private var selectedPageIndex = 0
    
    let disease = "Melanoma"
    let riskLevel = "High"
    let findings = [
        ("Early detection is crucial", "https://www.example.com/early-detection"),
        ("Regular skin check-ups are recommended", "https://www.example.com/skin-check-ups")
    ]
    let nextActions = [
            "Avoid excessive sun exposure",
            "Schedule regular skin check-ups",
            "Use sunscreen daily",
            "Wear protective clothing outdoors"
        ]
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.darkBlue)
                    }
                    Text("Report")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.darkBlue)

                }
                
                Text("Disease Detected: \(disease)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
                    .foregroundColor(Color.darkBlue.opacity(0.7))

                
                HStack(spacing:20){
                    CardView(title: "Risk Level:", content: riskLevel, includeRiskGauge: true)
                    
                    HStack(spacing:20){
                        CardView(title: "Certainty:", content: riskLevel, includeCertaintyGauge: true, certaintyPercentage: 0.5)
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Recent Findings")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ForEach(placeholderFindings, id: \.0) { finding in
                        VStack(alignment: .leading) {
                            Text(finding.0)
                                .font(.body)
                                .foregroundColor(.primary)
                                .padding(.bottom, 2)
                            
                            Divider()
                        }
                    }
                }
                    
                    
                VStack(alignment: .leading, spacing: 10) {
                    Text("Next Actions")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(Array(nextActions.enumerated()), id: \.element) { index, action in
                                CardView(content: "• \(action)")
                                   
                                    .padding(.leading, index == 0 ? 20 : 0)
                                    .padding(.trailing, index == nextActions.count - 1 ? 20 : 0)
                            }
                        }
                    }
                    .padding(.horizontal, -20)
                    .frame(height: 175)
                    // Specialists Near You Section
                    Text("Specialists Near You")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                                
                        DoctorsListView()
                    }
                }
                .padding()
            }
        .background(Color(red: 0.9, green: 0.95, blue: 1.0).ignoresSafeArea())

            .navigationBarHidden(true)
        }
    }
    
    struct GaugeShape: Shape {
        var value: Double
        var isHalfCircle: Bool
        func path(in rect: CGRect) -> Path {
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2
            let startAngle = Angle(degrees: 0)
            
            var endAngle: Angle
            if isHalfCircle {
                endAngle = Angle(degrees: 180 * value)
            } else {
                endAngle = Angle(degrees: 360 * value)
            }
            
            var path = Path()
            
            path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
            return path
        }
    }
    
    struct CertaintyGauge: View {
        let certaintyPercentage: Double
        
        var body: some View {
            ZStack {
                GaugeShape(value: 1.0, isHalfCircle: true)
                    .stroke(Color.gray, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(180))
                
                GaugeShape(value: certaintyPercentage, isHalfCircle: true)
                    .stroke(Color.blue, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(180))
                Text("\(Int(certaintyPercentage * 100))%")
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .position(x: 50, y: 50)
                    .zIndex(1)
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(width: 100, height: 100)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
    }
    
    
    
    
    
    struct RiskGauge: View {
        let riskLevel: String
        
        var body: some View {
            let gaugeColor: Color
            
            switch riskLevel {
            case "Low":
                gaugeColor = Color.green
            case "Medium":
                gaugeColor = Color.yellow
            case "High":
                gaugeColor = Color.red
            default:
                gaugeColor = Color.gray
            }
            
            return VStack {
                ZStack {
                    GaugeShape(value: 1.0, isHalfCircle: false)
                        .stroke(gaugeColor, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    Text(riskLevel)
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 100, height: 100)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
        }
    }
    
    struct CardView: View {
        var title: String?
        var content: String
        var color: Color = Color(UIColor.systemBackground)
        var includeRiskGauge: Bool = false
        var includeCertaintyGauge: Bool = false
        var certaintyPercentage: Double = 0
        
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                if let title = title {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                if includeRiskGauge {
                    RiskGauge(riskLevel: content)
                } else if includeCertaintyGauge {
                    CertaintyGauge(certaintyPercentage: certaintyPercentage)
                } else {
                    Text(content)
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .frame(width: 170, height: 170)
            .background(color)
            .cornerRadius(10)
            
            .shadow(radius: 2)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.darkBlue.opacity(0.5), lineWidth: 1)
            )
        }
    }
    
    struct ReportView_Previews: PreviewProvider {
        static var previews: some View {
            ReportView()
        }
    }
