//
//  PlusButton.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 20/12/2021.
//

import SwiftUI

struct FavouriteButton: View {
    @Binding var isFavourite: Bool
    var onGestureTap: (Bool) -> ()
    
    var starSize: CGFloat = 30
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 2.0).foregroundColor(.yellow)
                .frame(width: starSize, height: starSize)
                .shadow(color: .orange, radius: 4)
            if isFavourite {
                RoundedStar()
                    .frame(width: starSize, height: starSize)
                    .foregroundColor(.yellow)
                
            } else {
                RoundedStar()
                    .frame(width: starSize, height: starSize)
                    .foregroundColor(.white)
            }
        }
        .onTapGesture {
            onGestureTap(isFavourite)
        }
    }
}
