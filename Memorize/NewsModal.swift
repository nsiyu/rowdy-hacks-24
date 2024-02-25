import Foundation

struct NewsArticle: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let url: String
    let imageUrl: String
}

class SkinNewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []

    func fetchNews() {
        let apiKey = "88152ba129b84af0b4745599ab143ada"
        let pageSize = 1
        let urlString = "https://newsapi.org/v2/everything?q=melanoma&pageSize=1&language=en&apiKey=\(apiKey)"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dictionary = json as? [String: Any], let articles = dictionary["articles"] as? [[String: Any]] {
                        DispatchQueue.main.async {
                            self.articles = articles.compactMap { articleDict in
                                guard let title = articleDict["title"] as? String,
                                      let description = articleDict["description"] as? String,
                                      let url = articleDict["url"] as? String,
                                      let imageUrl = articleDict["urlToImage"] as? String else { return nil }
                                return NewsArticle(title: title, description: description, url: url, imageUrl: imageUrl)
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

