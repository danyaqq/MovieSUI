//
//  HomeHeaderView.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import SwiftUI
import SDWebImageSwiftUI


//Random Trending Movie
extension HomeView{
    var headerView: some View{
        ZStack{
            if let randomMovie = movieVM.randomTrendingMovie{
                WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movieVM.randomTrendingMovie?.poster_path ?? "")"))
                    .resizable()
                    .placeholder(content: {
                        ProgressView()
                    })
                    .frame(height: 450)
                    .overlay(
                        LinearGradient(colors: [Color(uiColor: UIColor.clear), Color(uiColor: UIColor.black)], startPoint: .top, endPoint: .bottom)
                    )
                    .overlay(
                        VStack(spacing: 20){
                            
                            Button {
                                showDetailView = true
                                let titleMovie = randomMovie.original_title ?? randomMovie.original_name ?? ""
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
                                Text("Play")
                                    .modifier(
                                        CustomButtonModifier(borderColor: .white, backgroundColor: .clear)
                                    )
                            }
                            .background(
                                NavigationLink(isActive: $showDetailView) {
                                    DetailMovieView(model: randomMovie)
                                        .environmentObject(movieVM)
                                } label: {
                                    EmptyView()
                                }
                            )
                            
                            Button {} label: {
                                Text("Download")
                                    .modifier(
                                        CustomButtonModifier(borderColor: Color(uiColor: UIColor.red), backgroundColor: Color(uiColor: UIColor.red))
                                    )
                            }
                        }
                            .padding(.bottom, 50),
                        alignment: .bottom
                    )
            }
        }
    }
}
