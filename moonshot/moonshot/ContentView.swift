//
//  ContentView.swift
//  moonshot
//
//  Created by Macbook Pro on 01/02/2022.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationView{
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                
                                VStack{
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding(2)
                                    Text(mission.formattedDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightColor)
                            }.clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.lightColor))
                            
                        }
                    }
                }.padding([.horizontal,.bottom])
        }
            .navigationTitle("MoonShoot")
            .background(.backGroundColor)
            .preferredColorScheme(.dark)
    }
  }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
