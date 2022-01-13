//
//  HomeSectionView.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeSectionView: View {
    @State var showDetailView = false
    @State var url: String = ""
    var title: String
    var movieVM: MovieViewModel
    var movies: [Movie]
    var body: some View {
        VStack{
            Text(title.uppercased())
                .foregroundColor(Color(uiColor: .label))
                .font(.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            ScrollView(.horizontal){
                HStack{
                    ForEach(movies, id: \.id){movie in
                        let titleMovie = movie.original_name ?? movie.original_title
                        Button {
                            showDetailView = true
                            if let titleMovie = titleMovie{
                            movieVM.getYouTubeMovie(with: titleMovie) { result in
                                switch result{
                                case .success(let video):
                                    self.url = video.id.videoId
                                   
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                            }
                        } label: {
                            WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path ?? "")"))
                                .resizable()
                                .frame(width: 140, height: 200)
                        }
                        .background(
                            NavigationLink(isActive: $showDetailView) {
//                                DetailMovieView(model: movie, url: url)
                            } label: {
                                EmptyView()
                            }
                        )
                    }
                }
            }
        }
        .padding(.bottom)
    }
}
