//
//  StrokeBorder.swift
//  Drawing
//
//  Created by Macbook Pro on 03/02/2022.
//

import SwiftUI

struct StrokeBorder: View {
    var body: some View {
        Circle()
            .strokeBorder(.blue,lineWidth: 40)
    }
}

struct StrokeBorder_Previews: PreviewProvider {
    static var previews: some View {
        StrokeBorder()
    }
}
