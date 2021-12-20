//
//  StarsView.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 30/10/2021.
//

import SwiftUI

struct StarsView: View {
    @Binding var currentRating: Movie.Rating
    var starSize: CGFloat = 20
    var onGestureTap: ((Movie.Rating) -> ())?

    var body: some View {
        HStack {
            ForEach(Movie.Rating.allCases, id: \.self) { rating in
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
            .frame(width: starSize, height: starSize)
            .foregroundColor(.yellow)
    }

    var emptyStar: some View {
        ZStack {
            RoundedStar(cornerRadius: 0)
                .stroke(lineWidth: 2.0)
                .foregroundColor(.yellow)
                .frame(width: starSize, height: starSize)

            RoundedStar(cornerRadius: 0)
                .foregroundColor(.white)
                .frame(width: starSize, height: starSize)
        }
    }

    private func isFilled(_ rating: Movie.Rating) -> Bool {
        currentRating.rawValue >= rating.rawValue
    }
}
