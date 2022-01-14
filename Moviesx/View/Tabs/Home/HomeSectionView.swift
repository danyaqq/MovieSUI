//
//  HomeSectionView.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeSectionView: View {
    @EnvironmentObject var movieVM: MovieViewModel
    @State var selectedMovie: Movie? = nil
    @State var showDetailView = false
    @State var url: String = ""
    var movies: [Movie]
    var title: String
    var body: some View {
        VStack{
            Text(title.uppercased())
                .foregroundColor(Color(uiColor: .label))
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            ScrollView(.horizontal){
                HStack{
                    ForEach(movies, id: \.id){movie in
                        let titleMovie = movie.original_name ?? movie.original_title ?? ""
                        Button {
                            selectedMovie = movie
                            movieVM.getYouTubeMovie(with: titleMovie, completion: {result in
                                switch result{
                                case .success(let video):
                                    DispatchQueue.main.async {
                                        movieVM.movieURL = video.id.videoId
                                    }
                                case .failure(let error):
                                    print(error)
                                    DispatchQueue.main.async {
                                    movieVM.movieURL = ""
                                    }
                                }
                            })
                        } label: {
                            WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path ?? "")"))
                                .resizable()
                                .placeholder(content: {
                                    ProgressView()
                                })
                                .scaledToFit()
                                .frame(width: 140, height: 200)
                                .contextMenu {
                                    Button { } label: {
                                        Label("Download", systemImage: "square.and.arrow.down")
                                    }
                                }
                        }
                        .background(
                            NavigationLink(tag: movie, selection: $selectedMovie, destination: {
                                DetailMovieView(model: movie)
                                    .environmentObject(movieVM)
                            }, label: {
                                EmptyView()
                            })
                            
                        )
                        
                    }
                }
            }
        }
        .padding(.bottom)
    }
}
