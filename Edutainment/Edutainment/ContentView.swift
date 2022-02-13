//
//  ContentView.swift
//  Edutainment
//
//  Created by Macbook Pro on 10/02/2022.
//

import SwiftUI
struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct ContentView: View {
    @State private var questions = 5
    @State private var selectTable = 2
    @State private var startQuiz = false
    @State private var rightAns = 0
    @State private var title = ""
    @State private var randomNum = Int.random(in: 1...10)
    @State private var score = 0
    @State private var showScore = false
    @State private var showTitle = ""




    func countinue(){
        question()
    }
    func doNothing(){
        if startQuiz == false {
            startQuiz.toggle()
            question()
        } else {
            startQuiz.toggle()
        }
    }
    func rightAnswer(){
        if (rightAns == selectTable * randomNum){
            score = score + 1
            showTitle = "Right answer"
        }else{
            score = score - 1
            showTitle = "Wrong answer"

        }
        showScore = true

    }
    
   
    func question(){
        for _ in 1...questions{
            title = "\(selectTable) x \(randomNum) = ?"
            
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Form {
                VStack(alignment: .leading){
                    Text("Select Table")
                    Stepper("Table of \(selectTable)", value: $selectTable, in:2...12,step: 1)
                }
                VStack(alignment: .leading){
                    Text("Number of Question")
                    Stepper("\(questions) Questiona", value: $questions, in:5...15,step: 5)
                }
                    Section {
                        if startQuiz{
                            
                                                  Text("\(title) guess")
                           
                            TextField("0.0",value: $rightAns,format: .number).keyboardType(.decimalPad)
                            VStack{
                                Button("Submit"){
                                    rightAnswer()
                                }
                            }
                    }
            }
               
            }
            }.navigationTitle("Edutainment")
                .toolbar {
                    Button("Start the Quiz",action: doNothing).disabled(startQuiz)
                
            }.alert(showTitle,isPresented: $showScore) {
                Button("Continue", action: countinue)
            } message: {
                Text("Your score is \(score)")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
