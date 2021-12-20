//
//  PlusButton.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 04/11/2021.
//

import SwiftUI

struct PlusButton: View {
    let width, height: CGFloat
    @State private var isPresentingNewMoviePopover = false

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3.0).foregroundColor(.white)
                .frame(width: width/7, height: width/7)
                .shadow(color: .orange, radius: 4)
            Circle()
                .foregroundColor(.orange)
                .opacity(80)
                .frame(width: width/7, height: width/7)
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width/14, height: width/14)
                .foregroundColor(.white)
        }

        .onTapGesture {
            isPresentingNewMoviePopover = true
        }
        .popover(isPresented: $isPresentingNewMoviePopover) {
            NewMovieView()
        }
    }
}
