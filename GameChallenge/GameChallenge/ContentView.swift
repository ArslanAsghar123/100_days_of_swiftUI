//
//  ContentView.swift
//  GameChallenge
//
//  Created by Macbook Pro on 10/02/2022.
//

import SwiftUI

enum CaseA{
    case rock,paper,scissors
}
struct ContentView: View {
    @State private var showTitle = ""

    @State private var showScore = false
    @State private var score : Int = 0
    @State private var game = ["paper","scissors","rock"]
    @State private var selectSymbol = Int.random(in: 0...2)

    func addQuestion(){
       // game.shuffle()
        selectSymbol = Int.random(in: 0...2)
    }
    
    func flagTap(_ number:Int){
        if number == selectSymbol{
            showTitle = "Draw"
            score = score
        }else if number == 1 && selectSymbol == 0{
            showTitle = "Won"
            if(score == 10){
                score = score
                showTitle = "Game Finished"

            }else{
                score = score + 1
            }

        }else if number == 2 && selectSymbol == 0{
            showTitle = "Wrong"
            if(score == 0){
                score = score
            }else{
            score = score - 1
            }
        }else if number == 0 && selectSymbol == 1{
            showTitle = "Wrong"
            if(score == 0){
                score = score
            }else{
            score = score - 1
            }
        }else if number == 2 && selectSymbol == 1{
            showTitle = "Won"
            if(score == 10){
                score = score
                showTitle = "Game Finished"

            }else{
                score = score + 1
            }
            
        }else if number == 0 && selectSymbol == 2{
            showTitle = "Won"
                if(score == 10){
                    score = score
                    showTitle = "Game Finished"

                }else{
                    score = score + 1
                }
                
            }else if number == 1 && selectSymbol == 2{
            showTitle = "Wrong"
            if(score == 0){
                score = score
            }else{
            score = score - 1
            }
        }
        
        
        
        else{
            showTitle = "Wrong"
            if(score == 0){
                score = score
            }else{
            score = score - 1
            }
        }
        showScore = true
    }
    var body: some View {
        
        ZStack{
            LinearGradient(gradient: Gradient(stops: [
                Gradient.Stop(color: .black.opacity(0.09), location: 0.45),
                Gradient.Stop(color: .black.opacity(0.1), location: 0.55),
            ]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
           
            VStack{
                VStack{
                    Text("Win The Game").font(.largeTitle.bold()).foregroundColor(.black)
                }
            
                Image(game[selectSymbol])
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 120, height: 120)
                Spacer().frame( height: 120)
                Text("Guess the Sign?").font(.largeTitle).foregroundColor(.black)
                HStack{
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTap(number)

                        } label: {
                            
                            Image(game[number])
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 120, height: 120)

                        }

                    }
                }
            }
        }.alert(showTitle, isPresented: $showScore) {
            Button("Continue", action: addQuestion)
        } message: {
            Text("Your score is \(score)")
        }
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
