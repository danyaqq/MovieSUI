//
//  SearchView.swift
//  Moviesx
//
//  Created by Даня on 14.01.2022.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var movieVM: MovieViewModel
    @State var searchText: String = ""
    @State var selectedMovie: Movie? = nil
    var body: some View {
        NavigationView{
            if !searchText.isEmpty{
                searchViewWithQuery
            } else {
                defaultSearchView
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: Text("Search for a Movie or a TV show"))
        .onChange(of: searchText) { newValue in
            let queryText = newValue
            movieVM.searchMovie(with: queryText, completion: { result in
                switch result{
                case .success(let movies):
                    DispatchQueue.main.async {
                        movieVM.searchMovie = movies
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
