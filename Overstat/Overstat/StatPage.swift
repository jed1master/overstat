//
//  StatPage.swift
//  Overstat
//
//  Created by Александр Корепанов on 26.06.2021.
//

import SwiftUI

struct StatPage: View {
    
    let playerInfo: PlayerInfo
    
    let profile = DataController.shared
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(alignment: .leading) {
                
                Spacer()
                
                HStack(alignment: .center) {
                    Image("p_icon")
                        .resizable()
                        .frame(width: 80, height: 80)
                    Text("\(playerInfo.name)")
                }
                
                HStack (alignment: .center){
                    Spacer()
                    ZStack {
                        Text("\(playerInfo.level)")
                        Image("lvlicon")
                        Image("prestigeicon")
                            .offset(x: 0, y: 70)
                            .padding()
                    }
                    Spacer()
                }
                
                VStack(alignment: .leading) {
                    
                    ForEach(playerInfo.ratings ?? []) { role in
                        roleView(role)
                    }
                    
                    Text("Выиграно игр: \(playerInfo.gamesWon)")
                }
                
                Spacer()
                
            }
            .foregroundColor(.white)
        }
    }
    
    
    func roleView(_ role: PlayerInfo.Role) -> some View {
        HStack {
            Image("\(role.role)")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Image("\(role.rank)")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text("\(role.level)")
        }
    }
    
}
struct StatPage_Previews: PreviewProvider {
    static var previews: some View {
        StatPage(playerInfo: .sample)
    }
}

extension PlayerInfo {
    static var sample: PlayerInfo {
        PlayerInfo(gamesWon: 10,
                   level: 100,
                   name: "Akira",
                   prestige: 0,
                   private: false,
                   quickPlayStats: QPStats(awards: QPStats.Awards(cards: 1,
                                                                  medals: 2,
                                                                  medalsBronze: 3,
                                                                  medalsSilver: 4,
                                                                  medalsGold: 5),
                                           games: QPStats.Games(played: 1,
                                                                won: 1)
                   ),
                   ratings: [Role(level: 2600, role: "tank"),
                             Role(level: 2600, role: "damage"),
                             Role(level: 2700, role: "support")]
        )
    }
}
private var __myVar: String = ""

extension PlayerInfo.Role: Identifiable {
    var id: String {
        role
    }
    
    var rank: String {
        
        switch level {
        case ..<1500:
            return "broze"
        case 1500..<2000:
            return "silver"
        case 2000..<2500:
            return "gold"
        case 2500..<3000:
            return "platinum"
        case 3000..<3500:
            return "diamond"
        case 3500..<4000:
            return "master"

        default:
            return "grandmaster"
        }
        
    }
    
}

