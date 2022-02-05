//
//  ImagePaint.swift
//  Drawing
//
//  Created by Macbook Pro on 03/02/2022.
//

import SwiftUI

struct ImagePaint: View {
    var body: some View {
        Text("Hello there")
            .frame(width: 200, height: 200, alignment: .center)
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16).stroke(Color.yellow, lineWidth:8))

    }
}

struct ImagePaint_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaint()
    }
}
