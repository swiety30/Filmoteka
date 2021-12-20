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
            Image("tombraider")
                .resizable()
                .frame(width: 150)
                .aspectRatio(2/3, contentMode: .fit)
                .cornerRadius(20)
                .shadow(radius: 10)
            Spacer()
            VStack(alignment: .trailing) {
                Text(movie.name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
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
