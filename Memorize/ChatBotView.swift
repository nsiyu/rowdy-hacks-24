import SwiftUI

struct ChatMessage: Identifiable {
    let id: UUID = UUID()
    let message: String
    let isUser: Bool
}

struct ChatBotResponse: Decodable {
    let response: ChatBotMessage
}

struct ChatBotMessage: Decodable {
    let response: String
}

struct ChatBotView: View {
      @State private var chatInput: String = ""
      @State private var chatMessages: [ChatMessage] = [
          ChatMessage(message: "Hello! How can I help you today?", isUser: false)
      ]
      @State private var isBotResponding = false

      var body: some View {
          VStack {
              Text("Steve AI")
                  .font(.title)
                  .fontWeight(.bold)
                  .padding(.top)
                 

              ScrollViewReader { scrollView in
                  ScrollView {
                      VStack(spacing: 10) {
                          ForEach(chatMessages) { message in
                              ChatBubble(message: message)
                          }
                      }
                      .padding()
                  }
                  .onChange(of: chatMessages.count) { _ in
                      withAnimation {
                          scrollView.scrollTo(chatMessages.last?.id, anchor: .bottom)
                      }
                  }
              }
              .background(Color.backGroundColor)
              
              HStack {
                  TextField("Type a message...", text: $chatInput)
                      .textFieldStyle(RoundedBorderTextFieldStyle())
                      .padding(.horizontal)
                  
                  Button(action: sendMessage) {
                      Image(systemName: "arrow.up.circle.fill")
                          .resizable()
                          .frame(width: 44, height: 44)
                          .foregroundColor(.darkBlue)
                  }
              }
              .padding(.horizontal)
              .padding(.bottom, 40)
          }
          .background(Color.backGroundColor)
           .foregroundColor(.darkBlue)
          .navigationBarHidden(true)
      }
    
    func sendMessage() {
        guard !chatInput.isEmpty else { return }
        let userMessage = ChatMessage(message: chatInput, isUser: true)
        chatMessages.append(userMessage)

        isBotResponding = true // Start loading animation

        let url = URL(string: "https://llm-app-jolly-poetry-c507.redditbotnumber2.workers.dev/")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody = ["disease": "melanoma", "question": chatInput]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            print("Failed to serialize request body: \(error)")
            isBotResponding = false
            return
        }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Request error: \(error)")
                DispatchQueue.main.async {
                    self.isBotResponding = false
                }
                return
            }
            
            guard let data = data else {
                print("No data received")
                DispatchQueue.main.async {
                    self.isBotResponding = false
                }
                return
            }
            
            do {
                if let responseString = String(data: data, encoding: .utf8) {
                    if let jsonData = responseString.data(using: .utf8) {
                        do {
                            let decoder = JSONDecoder()
                            let responses = try decoder.decode([ChatBotResponse].self, from: jsonData)
                            
                            if let chatBotResponse = responses.first {
                                let botMessage = ChatMessage(message: chatBotResponse.response.response, isUser: false)
                                DispatchQueue.main.async {
                                    self.chatMessages.append(botMessage)
                                    self.isBotResponding = false
                                }
                            }
                        } catch {
                            print("Failed to decode response: \(error)")
                            DispatchQueue.main.async {
                                self.isBotResponding = false
                            }
                        }
                    }
                }
            } catch {
                print("Failed to decode response: \(error)")
                DispatchQueue.main.async {
                    self.isBotResponding = false
                }
            }
        }.resume()
        chatInput = ""
    }

}

struct ChatBubble: View {
    var message: ChatMessage
    var isBotResponding: Bool = false
    
    var body: some View {
        HStack {
            if message.isUser || isBotResponding {
                Spacer()
            }

            HStack {
                if !message.isUser && !isBotResponding {
                    Image("doctor")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                }
                
                if isBotResponding && !message.isUser {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(width: 32, height: 32)
                } else {
                    Text(message.message)
                        .padding()
                        .background(message.isUser ? Color.darkBlue : Color.darkGray)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                
                if message.isUser {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                }
            }
            
            if !message.isUser && !isBotResponding {
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: message.isUser ? .trailing : .leading)
        .transition(.slide)
        .animation(.default)
    }
}



struct ChatBotView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatBotView()
        }
    }
}


