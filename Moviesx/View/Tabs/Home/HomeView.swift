//
//  HomeView.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var movieVM: MovieViewModel
    var movies: [Movie]{
        var moviesResult: [Movie] = []
        for section in Constant.categories{
            if section == "Trending Movies"{
                moviesResult = movieVM.trendingMovies
            } else if section == "Trending TV"{
                moviesResult = movieVM.trendingTV
            } else if section == "Popular"{
                moviesResult = movieVM.popularMovies
            } else if section == "Upcoming Movies"{
                moviesResult = movieVM.upcomingMovies
            } else if section == "Top Rated"{
                moviesResult = movieVM.topRatedMovies
            }
        }
        return moviesResult
    }
    var body: some View {
        NavigationView{
            ScrollView{
                headerView
                LazyVStack {
                    ForEach(Constant.categories, id: \.self){ section in
                      
                            HomeSectionView(title: section, movieVM: movieVM, movies: movies)
                        
                    }
                }
            }
            .background(Color(uiColor: .systemBackground))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Movies")
            .modifier(
                HomeViewModifier()
            )
        }
    }
}

struct HomeViewModifier: ViewModifier{
    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button {} label: {
                    Image("logo")
                        .resizable()
                        .frame(width: 36, height: 36)
                }
                
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {} label: {
                    Image(systemName: "play.rectangle")
                }
                Button {} label: {
                    Image(systemName: "person")
                }
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        
    }
}
