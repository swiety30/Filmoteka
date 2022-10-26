//
//  PlusButton.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 04/11/2021.
//

import SwiftUI

struct PlusButton<Content: View>: View {
    let width, height: CGFloat
    @State private var isPresentingNewMoviePopover = false
    @Environment(\.isEnabled) var isEnabled
    let content: Content

    var body: some View {
        ZStack {
            behindButtonView
            imageView
        }
        .onTapGesture {
            isPresentingNewMoviePopover = true
        }
        .popover(isPresented: $isPresentingNewMoviePopover) {
            content
        }
    }

    var behindButtonView: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: Constants.Sizes.PlusButton.stroke)
                .foregroundColor(Constants.Colors.PlusButton.strokeColor)
                .frame(width: width, height: width)
                .shadow(color: Constants.Colors.PlusButton.shadowColor, radius: Constants.Sizes.glowSize)
            if isEnabled {
                Circle()
                    .foregroundColor(Constants.Colors.PlusButton.enabledBackgroundColor)
                    .opacity(Constants.Sizes.PlusButton.opacity)
                    .frame(width: width, height: width)
            } else {
                Circle()
                    .foregroundColor(Constants.Colors.PlusButton.disabledBackgroundColor)
                    .opacity(Constants.Sizes.PlusButton.opacity)
                    .frame(width: width, height: width)
            }
        }
    }

    var imageView: some View {
        Image(systemName: "plus")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width/2, height: width/2)
            .foregroundColor(Constants.Colors.PlusButton.imageColor)
    }
}
