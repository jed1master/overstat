//
//  ControlData.swift
//  Overstat
//
//  Created by Александр Корепанов on 23.06.2021.
//

import Foundation
import SwiftUI

struct MyError: Error {
    
    
}

private var instance: DataController?

class DataController: ObservableObject {
    
    @Published var playerInfo: PlayerInfo?
    
    
    //singleton
    static let shared: DataController = {
        let instance = DataController()
        print("создал синглчетототам")
        return instance
    }()
    
    private init() {
        print("hello")
    }
    
    func getUrlAConvert(text: String) {
        let myUrl = URL(string: "https://ow-api.com/v1/stats/pc/eu/\(text)/profile")
        
        if let nonOptionalUrl = myUrl {
            print(nonOptionalUrl)
            let urlXXX = URLSession.shared.dataTask(with: nonOptionalUrl) { data, response, error in
                if let data = data {
                    print(String(data: data, encoding: .utf8))
                    let decoder = JSONDecoder()
                    
                    do {
                        let playerInfo = try decoder.decode(PlayerInfo.self, from: data)
                        print("success:",playerInfo)
                        DispatchQueue.main.async {
                            self.playerInfo = playerInfo
                        }
                    } catch {
                        print("error:", error)
                    }
                }
            }
            
            urlXXX.resume()
        }
    }
}

struct PlayerInfo: Decodable {
    let gamesWon: Int
    let level: Int
    let name: String
    let prestige: Int
    let `private`: Bool
    
    let quickPlayStats: QPStats
    
    struct Role: Decodable {
        let level: Int
        let role: String
        
    }
    
    let ratings: [Role]?
    
    struct QPStats: Decodable {
        let awards: Awards
        let games: Games
        
        struct Awards: Decodable {
            let cards: Int
            let medals: Int
            let medalsBronze: Int
            let medalsSilver: Int
            let medalsGold: Int
        }
        
        struct Games: Decodable {
            let played: Int
            let won: Int
        }
    }
}

