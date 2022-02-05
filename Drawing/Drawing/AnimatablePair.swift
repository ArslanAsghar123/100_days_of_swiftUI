//
//  AnimatablePair.swift
//  Drawing
//
//  Created by Macbook Pro on 04/02/2022.
//

import SwiftUI

struct TableData: Shape {
    var rows: Int
    var columns: Int
 
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let rowsSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        for row in 0..<rows{
            for column in 0..<columns{
                if(row + column).isMultiple(of: 2){
                    let startX = columnSize * Double(column)
                    let startY = rowsSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowsSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}

struct AnimatablePair: View {
    
    @State private var rows = 4
    @State private var columns = 4
    var body: some View {
        TableData(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)){
                    rows = 8
                    columns = 16
                }
            }
    }
}

struct AnimatablePair_Previews: PreviewProvider {
    static var previews: some View {
        AnimatablePair()
    }
}
