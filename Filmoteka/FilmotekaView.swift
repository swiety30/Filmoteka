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
        ScrollViewWithNavigation(movies: $filmotekaViewModel.toBeWatchedMovies, showTabBar: $showTabBar, title: "To Watch")
    }
    
    var scrollViewWithWatchedMovies: some View {
        ScrollViewWithNavigation(movies: $filmotekaViewModel.watchedMovies, showTabBar: $showTabBar, title: "Watched")
    }
}

struct ScrollViewWithNavigation: View {
    @Binding var movies: [FilmotekaModel.Movie]
    @EnvironmentObject var filmotekaModel: FilmotekaViewModel
    @Binding var showTabBar: Bool

    let title: String
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(filmotekaModel.categories) { category in
                    if !filmotekaModel.isCategoryEmpty(category, for: movies) {
                        Section {
                            ForEach($movies) { movie in
                                if movie.wrappedValue.category == category {
                                    NavigationLink(destination: MovieDetailsView(movie: movie), isActive: $showTabBar) {
                                        MovieCell(movie: movie)
                                    }
                                }
                            }
                        } header: {
                            HStack {
                                Text(category.name).frame(alignment: .leading)
                                Spacer()
                            }
                            .padding()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
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
