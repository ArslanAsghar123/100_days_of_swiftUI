//
//  ContentView.swift
//  CoreML
//
//  Created by Macbook Pro on 23/01/2022.
//
import CoreML
import SwiftUI
struct ContentView: View {
    @State private var wakeUp = defaulTime
    @State private var sleepTime = 8.0
    @State private var cupOfCoffee = 1
    @State private var alertTitle = ""
    @State private var alertMsg = ""
    @State private var showDialog = false
    static var defaulTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        
        NavigationView{
            Form{
                VStack(alignment: .leading, spacing: 12){
                    Text("Desired time to wake up").font(.headline)
                    DatePicker("Choose the time",selection: $wakeUp,displayedComponents: .hourAndMinute).labelsHidden()
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text("Desired Amount of sleep").font(.headline)
                    Stepper("\(sleepTime.formatted()) hours", value: $sleepTime, in: 4...12,step: 0.25)
                }
                VStack(alignment: .leading, spacing: 12){
                    Text("Number Of cups").font(.headline)
                    Stepper(cupOfCoffee == 1 ? "1 cup":"\(cupOfCoffee) cups",value: $cupOfCoffee,in: 1...20,step: 1)
                }
            }.navigationTitle("BetterRest")
                .toolbar {
                    Button("calculate",action: calcBedTime)
                    
                }.alert(alertTitle, isPresented: $showDialog){
                    Button("Ok"){
                        
                    }
                }message: {
                    Text(alertMsg)
                }
        }
    }
    func calcBedTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute) , estimatedSleep: sleepTime, coffee: Double(cupOfCoffee))
            let sleepTime = wakeUp - prediction.actualSleep
            alertTitle = "Ideal time for you"
            alertMsg = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            alertTitle = "Error"
            alertMsg = "Sorry something wrong"
        }
    showDialog = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
