//
//  MovieDetailsView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 30/10/2021.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var filmotekaModel: FilmotekaViewModel
    @Binding var movie: FilmotekaModel.Movie
    @State private var showCategories: Bool = false

    @State private var isWatched: Bool = false
    @State private var currentRating: FilmotekaModel.Movie.Rating = .one
    @State private var currentCategoryName: String = ""

    var body: some View {
        VStack {
            ScrollView {
                Image("tombraider")
                    .resizable()
                    .frame(width: 150)
                    .aspectRatio(2/3, contentMode: .fit)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                Text(movie.name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                NavigationLink(destination: CategoriesView(movieCategory: $currentCategoryName), isActive: $showCategories) {
                    Text(currentCategoryName)
                        .font(.caption)
                }
                Text(movie.year)
                    .font(.caption)
                StarsView(currentRating: $currentRating) { rating in
                    currentRating = rating
                }
                WatchedButton(isWatched: $isWatched) { watched in
                    isWatched = !isWatched
                }
            }
        }
        
        .onAppear {
            if currentCategoryName == "" {
                currentCategoryName = movie.category.name
                isWatched = movie.isWatched
                currentRating = movie.rating
            }

        }
        .onDisappear {
            if !showCategories {
                filmotekaModel.updateMovie(movieId: movie.id, isWatched: isWatched, category: filmotekaModel.category(named: currentCategoryName), rating: currentRating)
            }
        }
    }
}

struct WatchedButton: View {
    @Binding var isWatched: Bool
    var onGestureTap: (Bool) -> ()
    var body: some View {
        Button {
            onGestureTap(isWatched)
        } label: {
            if isWatched {
                Text("Mark as not watched")
            } else {
                Text("Mark as watched")
            }
        }
    }

}

