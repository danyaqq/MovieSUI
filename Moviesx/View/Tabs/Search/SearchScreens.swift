//
//  SearchScreens.swift
//  Moviesx
//
//  Created by Даня on 14.01.2022.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

extension SearchView{
    var defaultSearchView: some View{
        List(movieVM.popularMovies){movie in
            MovieCardView(model: movie)
                .environmentObject(movieVM)
                .contextMenu {
                    Button { } label: {
                        Label("Download", systemImage: "square.and.arrow.down")
                    }
                }
        }
        .listStyle(.inset)
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.automatic)
    }
    var searchViewWithQuery: some View{
        ScrollView{
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], alignment: .center, spacing: 5, pinnedViews: []) {
                ForEach(movieVM.searchMovie, id: \.id){movie in
                    Button {
                        selectedMovie = movie
                        let titleMovie = movie.original_name ?? movie.original_title ?? ""
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
                            .frame(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
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
}
