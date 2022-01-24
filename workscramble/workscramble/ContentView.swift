//
//  ContentView.swift
//  workscramble
//
//  Created by Macbook Pro on 23/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWord = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errTitle = ""
    @State private var errMsg = ""
    @State private var isErr = false
    
    var body: some View {
        NavigationView{
            List{
                Section{
                    TextField("Enter your name", text: $newWord).autocapitalization(.none)
                }
                Section{
                    ForEach(usedWord, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        
                    }
                }
            }.navigationTitle(rootWord)
                .onSubmit {
                addNewWord()
                }.onAppear(perform: startGAme).alert(errTitle,isPresented: $isErr){
                    Button("OK",role: .cancel){}
                } message: {
                    Text(errMsg)
                }
        }
    }
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count>0 else{return}
        
        guard originalWord(word: answer) else{
        
            wordErr(title: "Word is already used", msg: "Be more original")
            return
        }
        guard isPossible(word: answer) else{
            wordErr(title: "word not possible", msg: "You can't spell that word from '\(rootWord)'!")
            return
        }
        guard isReal(word: answer) else{
            wordErr(title: "Word not recognized", msg: "You can't just make them up, you know!")
            return
        }
        withAnimation{
            usedWord.insert(answer, at: 0)

        }
        newWord = ""
    }
    func startGAme(){
        if let bundleStart = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWord = try? String(contentsOf: bundleStart){
                let allWords = startWord.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "Silk"
                return
            }
        }
         fatalError("The value is not found")
    }
    
    func originalWord(word:String) -> Bool{
        !usedWord.contains(word)
    }
    func isPossible(word:String) -> Bool{
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    func isReal(word:String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let missSpell = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return missSpell.location == NSNotFound
    }
    func wordErr(title:String, msg:String){
        errTitle = title
        errMsg = msg
        isErr = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
