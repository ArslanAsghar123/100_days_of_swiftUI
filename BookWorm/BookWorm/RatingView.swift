//
//  RatingView.swift
//  BookWorm
//
//  Created by Macbook Pro on 14/02/2022.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    
    var label = ""
    
    var maxRating = 5
    
    var offImage : Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    func image(for number:Int) -> Image{
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    var body: some View {

        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maxRating + 1,id: \.self){ num in
                image(for: num)
                    .foregroundColor(num > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = num
                    }
                
            }
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
