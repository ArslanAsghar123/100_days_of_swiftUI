//
//  Petal.swift
//  Drawing
//
//  Created by Macbook Pro on 03/02/2022.
//

import SwiftUI

struct Flower: Shape{
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from:0, to: Double.pi * 2, by: Double.pi / 8){
            let rotaion = CGAffineTransform(rotationAngle: number)
            let position = rotaion.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            let rotatedPetal = originalPetal.applying(position)
            path.addPath(rotatedPetal)
        }
        return path
    }
}

struct Petal: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    var body: some View {
        VStack{
           
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(.blue, style: FillStyle(eoFill: true))
            
            Text("Offset")
            Slider(value: $petalOffset, in: -80...30)
                .padding([.horizontal, .bottom])

            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
        }
    }
}

struct Petal_Previews: PreviewProvider {
    static var previews: some View {
        Petal()
    }
}
