//
//  ContentView.swift
//  Overstat
//
//  Created by Александр Корепанов on 20.06.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var profile = DataController.shared
    
    @State var text: String = "jed1master-2772"
    
    @State var isShowingPlayerInfo: Bool = false
    
    var body: some View {
        VStack {
            tagForm
                .sheet(isPresented: $isShowingPlayerInfo) {
                    profileInfoScreen
                }
        }
        .animation(.easeOut)
        .background(Color.black.ignoresSafeArea())
        .onChange(of: profile.playerInfo != nil) { value in
            if value {
                isShowingPlayerInfo = true
            }
        }
    }
    
    var tagForm: some View {
        
        VStack {
            Spacer()
            
            Image("mainlogo")
                .resizable()
                .scaledToFit()
              

            TextField("Введите свой battletag", text: $text)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .foregroundColor(Color.blue)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            
            Button("Найти") {
                
                profile.getUrlAConvert(text: text)
            }
            .frame(width: 110, height: 38, alignment: .center)
            .cornerRadius(16)
            .foregroundColor(.black)
            .background(Color.orange)
            .border(Color.orange, width: 1)
            .padding(.all)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            
            Spacer()
        }
    }

    var profileInfoScreen : some View {
        VStack {
            if let playerInfo = profile.playerInfo {
                StatPage(playerInfo: playerInfo)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
//https://ow-api.com/v1/stats/pc/eu/jed1master-2662/profile
