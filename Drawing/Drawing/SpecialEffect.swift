//
//  SpecialEffect.swift
//  Drawing
//
//  Created by Macbook Pro on 04/02/2022.
//

import SwiftUI

struct SpecialEffect: View {
    @State private var amount = 0.0
    var body: some View {
        VStack{
            ZStack{
            
            Circle()
                .fill(Color(red: 1, green: 0, blue: 0))
                .frame(width: 200 * amount)
                .offset(x: -50, y: -80)
                .blendMode(.screen)
            
            
            Circle()
                .fill(Color(red: 0, green: 1, blue: 0))
                .frame(width: 200 * amount)
                .offset(x: 50, y: -80)
                .blendMode(.screen)
            
            
            Circle()
                .fill(Color(red: 0, green: 0, blue: 1))
                .frame(width: 200 * amount)
                .blendMode(.screen)
            
            
            }.frame(width: 300, height: 300)
            Slider(value: $amount).padding()

        
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct SpecialEffect_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffect()
    }
}
