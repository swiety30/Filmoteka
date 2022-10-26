//
//  FilmotekaApp.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

@main
struct FilmotekaApp: App {
    var movieHandler = MoviesHandler()
    var movieFilterViewModel = MovieFilterViewModel()
    var viewRouter = ViewRouter()

    var body: some Scene {
        WindowGroup {
            FilmotekaView(viewRouter: viewRouter)
                .environmentObject(movieHandler)
                .environmentObject(movieFilterViewModel)
        }
    }
}
