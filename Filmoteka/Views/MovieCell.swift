//
//  MovieCell.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/10/2021.
//

import SwiftUI

struct MovieCell: View {
    @Binding var movie: Movie
    var body: some View {
        HStack {
            ZStack(alignment: .topLeading) {
                Image("tombraider")
                    .resizable()
                    .frame(height: 200)
                    .aspectRatio(2/3, contentMode: .fit)
                    .shadow(radius: 10)

                if movie.isFavourite {
                    Banner(width: 30, height: 70,
                           content: RoundedStar()
                            .foregroundColor(.yellow))
                        .padding(.horizontal)
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(movie.name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.black)
                Text(movie.year)
                    .font(.caption)
                    .foregroundColor(.black)
                HStack {
                    StarsView(currentRating: $movie.rating)
                        .disabled(true)
                }
            }.padding(.horizontal)
        }
        .background(Color(red: 235/255, green: 245/255, blue: 238/255))
        .cornerRadius(20)
    }
}
