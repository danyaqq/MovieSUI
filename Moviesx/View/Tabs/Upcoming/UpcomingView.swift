//
//  UpcomingView.swift
//  Moviesx
//
//  Created by Даня on 14.01.2022.
//

import SwiftUI

struct UpcomingView: View {
    @EnvironmentObject var movieVM: MovieViewModel
    var body: some View {
        NavigationView{
            List(movieVM.upcomingMovies){movie in
                MovieCardView(model: movie)
                    .environmentObject(movieVM)
                    .contextMenu {
                        Button { } label: {
                            Label("Download", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .listStyle(.inset)
            .navigationTitle("Upcoming")
        }
        
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
    }
}
