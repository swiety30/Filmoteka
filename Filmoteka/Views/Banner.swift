//
//  PlusButton.swift
//  Filmoteka
//
//  Created by Paweł Świątek on 04/11/2021.
//

import SwiftUI

struct Banner<Content: View>: View {
    let width, height: CGFloat
    let content: Content
    private let gold =  Color(red: 218 / 255, green: 165 / 255, blue: 32/255)
    var body: some View {
        ZStack(alignment: .center) {
            Group {
                BannerShape()
                    .stroke(lineWidth: 4)
                    .foregroundColor(gold)
                BannerShape()

                    .foregroundColor(.red)
            }
            .frame(width: width, height: height)

            content
                .frame(width: width - 4, height: width - 4)
        }
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
