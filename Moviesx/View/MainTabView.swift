//
//  MainTabView.swift
//  Moviesx
//
//  Created by Student on 13.01.2022.
//

import SwiftUI

enum Tabs: Hashable{
    case home
    case coming
    case search
    case downloads
}

struct MainTabView: View {
    @StateObject var movieVM = MovieViewModel()
    @State var selection = Tabs.home
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Movies")
                }
                .tag(Tabs.home)
                .environmentObject(movieVM)
            UpcomingView()
                .tabItem {
                    Image(systemName: "play.circle")
                    Text("Upcoming")
                }
                .tag(Tabs.coming)
                .environmentObject(movieVM)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(Tabs.search)
                .environmentObject(movieVM)
            Text("Downloads")
                .tabItem {
                    Image(systemName: "arrow.down.to.line")
                    Text("Downloads")
                }
                .tag(Tabs.downloads)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
