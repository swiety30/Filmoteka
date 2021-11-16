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
    @State var isWatched: Bool = false
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
                Text(movie.category.name)
                    .font(.caption)
                Text(movie.year)
                    .font(.caption)
                StarsView(currentRating: $movie.rating) { rating in
                    filmotekaModel.changeRating(for: movie.id, to: rating)
                }
                WatchedButton(isWatched: $isWatched) { watched in
                    isWatched = !isWatched
                }
            }
        }
        .onAppear {
            isWatched = movie.isWatched
        }
        .onDisappear {
            if isWatched != movie.isWatched {
                filmotekaModel.changeWatched(movie.id)
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

