//
//  AnimatableData.swift
//  Drawing
//
//  Created by Macbook Pro on 04/02/2022.
//

import SwiftUI

struct TrapZaid: Shape {
    var insetAmount: Double
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        return path
    }
}

struct AnimatableData: View {
    @State private var insetAmount: Double = 50.0
    var body: some View {
        TrapZaid(insetAmount: insetAmount).frame(width: 200, height: 100).onTapGesture {
            withAnimation  {
                insetAmount = Double.random(in: 10...90)
            }
        }
    }
}

struct AnimatableData_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableData()
    }
}
