//
//  ShapeAndPath.swift
//  Drawing
//
//  Created by Macbook Pro on 03/02/2022.
//

import SwiftUI
struct Triangle: Shape {
    func path(in rect:CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
}
struct Arc: InsettableShape {
    var startAngle: Angle
    var endAngle: Angle
    var clockWose: Bool
    var insetAmount = 0.0
    func path(in rect:CGRect) -> Path{
        
        var  rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        var path = Path()
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart , endAngle: modifiedEnd, clockwise: !clockWose)
        return path
    }
    func inset(by amount: CGFloat) -> some InsettableShape{
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ShapeAndPath: View {
    @State private var degree = 0.0
    @State private var startDegree = 0.0

    var body: some View {
        VStack{   Arc(startAngle: .degrees(startDegree), endAngle: .degrees(Double(degree)), clockWose: true)
                .strokeBorder(.blue, lineWidth: 10)
                .frame(width: 300, height: 300)
            Text("endAngle")
            Slider(value: $degree, in: 0...360).padding(.horizontal)
            Text("StartAngle")
            Slider(value: $startDegree, in: -90...360).padding(.horizontal)
        }
    }
}

struct ShapeAndPath_Previews: PreviewProvider {
    static var previews: some View {
        ShapeAndPath()
    }
}
