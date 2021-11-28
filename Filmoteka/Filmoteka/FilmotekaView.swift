//
//  ContentView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

struct FilmotekaView: View {
    @EnvironmentObject var filmotekaViewModel: FilmotekaViewModel
    @StateObject var viewRouter: ViewRouter
    @State private var showTabBar: Bool = false

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                switch viewRouter.currentView {
                case .notWatched:
                    scrollViewWithNotWatchedMovies
                case .watched:
                    scrollViewWithWatchedMovies
                }
                Spacer()
                if !showTabBar {
                    FilmotekaTabBar(viewRouter: viewRouter, size: CGSize(width: geometry.size.width, height: geometry.size.height / 8))
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    var scrollViewWithNotWatchedMovies: some View  {
        ScrollViewWithNavigation(filteredMovies: $filmotekaViewModel.toBeWatchedMovies, showTabBar: $showTabBar, title: "To Watch")
    }
    
    var scrollViewWithWatchedMovies: some View {
        ScrollViewWithNavigation(filteredMovies: $filmotekaViewModel.watchedMovies, showTabBar: $showTabBar, title: "Watched")
    }
}

struct ScrollViewWithNavigation: View {
    @Binding var filteredMovies: [MovieFilterModel.FilteredMovies]
    @EnvironmentObject var filmotekaModel: FilmotekaViewModel
    @Binding var showTabBar: Bool

    let title: String

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($filteredMovies) { filter in
                    Section {
                        ForEach(filter.filterMovies) { movie in
                            NavigationLink(destination: MovieDetailsView(movie: movie), isActive: $showTabBar) {
                                MovieCell(movie: movie)
                            }
                        }
                    } header: {
                        HStack {
                            TextField("", text: filter.filterName)
                                .frame(alignment: .leading)
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                }
                ToolbarItem() {
                    MovieFilterView(filterViewModel: filmotekaModel.filterViewModel)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FilmotekaView(viewRouter: ViewRouter())
    }
}
