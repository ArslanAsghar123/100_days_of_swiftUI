//
//  MissionView.swift
//  moonshot
//
//  Created by Macbook Pro on 01/02/2022.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut:  Astronaut
    }
    
    let crew: [CrewMember]
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    let mission: Mission
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack{
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)
                    
                   
                    
                    
                    VStack(alignment: .leading){
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightColor)
                            .padding(.vertical)
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom,5)
                        Text(mission.description)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightColor)
                            .padding(.vertical)
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }.padding(.horizontal)
                }.padding(.bottom)
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        ForEach(crew, id:\.role){ CrewMember in
                            NavigationLink{
                                AstronautView(astronaut: CrewMember.astronaut)
                            } label: {
                                HStack{
                                    Image(CrewMember.astronaut.id)
                                        .resizable()
                                        .frame(width:104,height:72)
                                        .clipShape(Capsule())
                                        .overlay(Capsule().strokeBorder(.white, lineWidth: 1))
                                    VStack(alignment: .leading){
                                        Text(CrewMember.astronaut.name)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Text(CrewMember.role)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                        
                                }.padding(.horizontal)
                            }
                            
                        }
                    }
                }
            }
            
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.backGroundColor)
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronaut: [String: Astronaut] =     Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0],astronauts: astronaut).preferredColorScheme(.dark)
    }
}
