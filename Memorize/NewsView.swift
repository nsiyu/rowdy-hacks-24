import SwiftUI

struct SkinNewsCard: View {
    @StateObject private var viewModel = SkinNewsViewModel()

    var body: some View {
        VStack(spacing: 10) {
            ForEach(viewModel.articles) { article in
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: article.imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 120)
                    .clipped()

                    VStack(alignment: .leading) {
                        Text(article.title)
                            .font(.subheadline)
                            .foregroundColor(Color.darkBlue)
                            .lineLimit(2)

                        Text(article.description)
                            .font(.caption)
                            .foregroundColor(Color.darkGray)
                            .lineLimit(3)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                .shadow(radius: 5)
            }
        }
        .padding(.horizontal)
        .onAppear {
            viewModel.fetchNews()
        }
    }
}


#Preview {
    SkinNewsCard()
}
