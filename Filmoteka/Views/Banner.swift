//
//  Banner.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 04/11/2021.
//

import SwiftUI

struct Banner<Content: View>: View {
    let width, height: CGFloat
    let content: Content
    
    var body: some View {
        ZStack(alignment: .center) {
            bannerView
            contentView
        }
    }

    var bannerView: some View {
        Group {
            BannerShape()
                .stroke(lineWidth: Constants.Sizes.Banner.padding)
                .foregroundColor(Constants.Colors.Banner.frameColor)
            BannerShape()

                .foregroundColor(Constants.Colors.Banner.backgroundColor)
        }
        .frame(width: width, height: height)
    }

    var contentView: some View {
        content
            .frame(width: width - Constants.Sizes.Banner.padding, height: width - Constants.Sizes.Banner.padding)
    }
}

private struct BannerShape: Shape {
    func path(in rect: CGRect) -> Path {
        let rightTopEdge = CGPoint(x: rect.minX, y: rect.minY)
        let leftTopEdge = CGPoint(x: rect.maxX, y: rect.minY)
        let leftBottomEdge = CGPoint(x: rect.maxX, y: rect.maxY)
        let triangleBottomEdge = CGPoint(x: rect.midX, y: rect.midY + (rect.midY / 2))
        let rightBottomEdge = CGPoint(x: rect.minX, y: rect.maxY)
        var path = Path()

        path.move(to: rightTopEdge)
        path.addLine(to: leftTopEdge)
        path.addLine(to: leftBottomEdge)
        path.addLine(to: triangleBottomEdge)
        path.addLine(to: rightBottomEdge)
        path.addLine(to: rightTopEdge)

        return path
    }
}

struct BannerShape_Previews: PreviewProvider {
    static var previews: some View {
        BannerShape()
            .foregroundColor(.yellow)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
