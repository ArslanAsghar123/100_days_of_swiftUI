//
//  ContentView.swift
//  flagApp
//
//  Created by Macbook Pro on 19/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showTitle = ""
    @State private var showScore = false
    @State private var score : Int = 0
   @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Russia","Spain","UK","US"]
    @State private var selectCOuntry = Int.random(in: 0...2)

    var body: some View {
        ZStack{
          
            RadialGradient(stops: [
                .init(color: Color(red: 0.1,green: 0.2,blue: 0.42), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700).ignoresSafeArea()
                VStack{
                    Text("Guess the flag").font(.largeTitle.bold()).foregroundColor(.white)
                    VStack{
                    VStack{
                        Text("Tap on the flag").foregroundColor(.black).font(.subheadline.weight(.heavy))
                        Text(countries[selectCOuntry]).foregroundColor(.black).font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTap(number)
                            
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original).clipShape(Capsule()).shadow(radius: 5)
                        }
                        Spacer().frame( height: 30)
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))

                    Text("total score is \(score)").font(.title.bold()).foregroundColor(.white)
                }.padding()
        }
        .alert(showTitle, isPresented: $showScore) {
            Button("Continue", action: addQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    func flagTap(_ number:Int){
        if number == selectCOuntry{
            showTitle = "Correct"
            score = score + 1
        }else{
            showTitle = "Wrong"
            if(score == 0){
                score = score
            }else{
            score = score - 1
            }
        }
        showScore = true
    }
    func addQuestion(){
        countries.shuffle()
        selectCOuntry = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
