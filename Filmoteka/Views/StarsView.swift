//
//  StarsView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 30/10/2021.
//

import SwiftUI

struct StarsView: View {
    @Binding var currentRating: FilmotekaModel.Movie.Rating
    var onGestureTap: ((FilmotekaModel.Movie.Rating) -> ())?

    var body: some View {
        HStack {
            ForEach(FilmotekaModel.Movie.Rating.allCases, id: \.self) { rating in
                Group {
                    if isFilled(rating) {
                        filledStar
                    } else {
                        emptyStar
                    }
                }
                .onTapGesture {
                    onGestureTap?(rating)
                }
            }
        }
    }

    var filledStar: some View {
        RoundedStar()
            .frame(width: 20, height: 20)
            .foregroundColor(.yellow)
    }

    var emptyStar: some View {
        ZStack {
            RoundedStar(cornerRadius: 0)
                .stroke(lineWidth: 2.0)
                .foregroundColor(.yellow)
                .frame(width: 20, height: 20)

            RoundedStar(cornerRadius: 0)
                .foregroundColor(.white)
                .frame(width: 20, height: 20)
        }
    }

    private func isFilled(_ rating: FilmotekaModel.Movie.Rating) -> Bool {
        currentRating.rawValue >= rating.rawValue
    }
}
