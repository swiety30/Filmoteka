//
//  ContentView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

struct FilmotekaView: View {
    @StateObject var viewRouter: ViewRouter
    @EnvironmentObject var movieHandler: MoviesHandler
    @EnvironmentObject var movieFilterViewModel: MovieFilterViewModel
    @State private var showTabBar: Bool = false
    @State private var showWatchedMovies: Bool = false
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                switch viewRouter.currentView {
                case .notWatched: MoviesScrollView(viewModel: MoviesScrollViewViewModel(isWatched: false,
                                                                                        moviesHandler: movieHandler,
                                                                                        movieFilterViewModel: movieFilterViewModel),
                                                   showTabBar: $showTabBar)
                case .watched: MoviesScrollView(viewModel: MoviesScrollViewViewModel(isWatched: true,
                                                                                     moviesHandler: movieHandler,
                                                                                     movieFilterViewModel: movieFilterViewModel),
                                                showTabBar: $showTabBar)
                }


                Spacer()
                if !showTabBar {
                    FilmotekaTabBar(viewRouter: viewRouter,
                                    size: CGSize(width: geometry.size.width,
                                                 height: geometry.size.height / 8))
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
