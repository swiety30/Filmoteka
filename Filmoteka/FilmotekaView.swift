//
//  ContentView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

struct FilmotekaView: View {
    @ObservedObject var filmotekaViewModel: FilmotekaViewModel
    @StateObject var viewRouter: ViewRouter
    
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
                FilmotekaTabBar(viewRouter: viewRouter, size: CGSize(width: geometry.size.width, height: geometry.size.height / 8))
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    var scrollViewWithNotWatchedMovies: some View  {
        ScrollViewWithNavigation(movies: $filmotekaViewModel.toBeWatchedMovies, title: "To Watch")
    }
    
    var scrollViewWithWatchedMovies: some View {
        ScrollViewWithNavigation(movies: $filmotekaViewModel.watchedMovies, title: "Watched")
    }
}

struct ScrollViewWithNavigation: View {
    @Binding var movies: [FilmotekaModel.Movie]
    @EnvironmentObject var filmotekaModel: FilmotekaViewModel
    let title: String
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach($movies) { movie in
                    NavigationLink(destination: MovieDetailsView(movie: movie)) {
                        MovieCell(movie: movie)
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
        FilmotekaView(filmotekaViewModel: FilmotekaViewModel(), viewRouter: ViewRouter())
    }
}
