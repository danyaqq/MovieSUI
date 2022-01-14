//
//  HomeView.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var movieVM: MovieViewModel
    @State var showDetailView: Bool = false
    var body: some View {
        NavigationView{
            ScrollView{
                headerView
                LazyVStack {
                    ForEach(Constant.categories, id: \.self){ title in
                        HomeSectionView(movies: getMovieForSection(title: title), title: title)
                            .environmentObject(movieVM)
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
    func getMovieForSection(title: String) -> [Movie]{
        if title == "Trending Movies"{
            return movieVM.trendingMovies
        } else if title == "Trending TV"{
            return movieVM.trendingTV
        } else if title == "Popular"{
            return movieVM.popularMovies
        } else if title == "Upcoming Movies"{
            return movieVM.upcomingMovies
        } else if title == "Top Rated"{
            return movieVM.topRatedMovies
        }
        return []
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
