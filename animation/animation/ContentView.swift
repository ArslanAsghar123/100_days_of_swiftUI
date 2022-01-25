//
//  ContentView.swift
//  animation
//
//  Created by Macbook Pro on 24/01/2022.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View{
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition{
    static var pivot: AnyTransition{
        .modifier(active: CornerRotateModifier(amount: -90, anchor: .topLeading), identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    var letter = Array("Hello SwiftUI")
    @State private var enable = false
    @State private var dragAmoiunt  = CGSize.zero

    var body: some View {
        
        ZStack{
            Rectangle().fill(.blue).frame(width: 200, height: 200)
            
            if enable{
                Rectangle().fill(.red).frame(width: 200, height: 200).transition(.pivot)
            }
        }.onTapGesture {
            withAnimation{
                enable.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Button("On Tap"){
//    enabled.toggle()
//}
//
//.frame(width: 200, height: 200)
//.background(enabled ? .red : .blue)
//.animation(.easeInOut(duration: 1), value: enabled)
//.foregroundColor(.white)
//.clipShape(RoundedRectangle(cornerRadius: enabled ? 120 : 0))
//.animation(.easeInOut(duration: 1), value: enabled)


//LinearGradient(gradient: Gradient(colors: [.yellow,.red]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea().frame(width: 300, height: 200).clipShape(RoundedRectangle(cornerRadius: 30)).offset(dragAmoiunt).gesture(DragGesture().onChanged{ dragAmoiunt = $0.translation}.onEnded{ _ in withAnimation(.spring()){
//    dragAmoiunt = .zero
//}}).animation(.spring(), value: dragAmoiunt)

//VStack{
//    Button("Tap me"){
//        withAnimation{ enable.toggle()
//        }
//
//    }
//
//    if enable{
//        Rectangle()
//            .fill(.red)
//            .frame(width: 200, height: 200)
//            .transition(.asymmetric(insertion: .scale, removal: .opacity))
//    }
//}
