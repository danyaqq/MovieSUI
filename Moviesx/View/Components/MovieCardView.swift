//
//  MovieCardView.swift
//  Moviesx
//
//  Created by Даня on 14.01.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCardView: View{
    @EnvironmentObject var movieVM: MovieViewModel
    @State var selectedMovie: Movie? = nil
    var model: Movie
    var body: some View{
        Button(action: {
            selectedMovie = model
            let titleMovie = model.original_name ?? model.original_title ?? ""
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
        }, label: {
            HStack(spacing: 20){
                WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(model.poster_path ?? "")"))
                    .resizable()
                    .placeholder(content: {
                        ProgressView()
                    })
                    .scaledToFit()
                    .frame(width: 100, height: 120)
                Text(model.original_title ?? model.original_name ?? "Unknown")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "play.circle")
                    .font(.system(size: 32))
                    .foregroundColor(Color(uiColor: .label))
                
                
            }
        })
            .frame(height: 130)
            .background(
                NavigationLink(tag: model, selection: $selectedMovie, destination: {
                    DetailMovieView(model: model)
                        .environmentObject(movieVM)
                }, label: {
                    EmptyView()
                })    
            )
    }
}
