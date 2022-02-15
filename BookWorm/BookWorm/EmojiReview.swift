//
//  EmojiReview.swift
//  BookWorm
//
//  Created by Macbook Pro on 15/02/2022.
//

import SwiftUI

struct EmojiReview: View {
    
    let rating: Int16
    var body: some View {

        switch rating{
        case 1:
            Text("😒")
        case 2:
            Text("😕")
        case 3:
            Text("😏")
        case 4:
            Text("🤩")
        case 5:
            Text("🥳")
        default :
            Text("😝")
        }
    }
}

struct EmojiReview_Previews: PreviewProvider {
    static var previews: some View {
        EmojiReview(rating: 3)
    }
}
