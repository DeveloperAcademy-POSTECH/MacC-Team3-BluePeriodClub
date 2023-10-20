//
//  CosonantCardView.swift
//  Orum
//
//  Created by Youngbin Choi on 10/20/23.
//

import SwiftUI

struct ConsonantCardView: View {
    
    @State var hangulUnit : HangulUnit
    var body: some View {
        NavigationStack{
            ZStack{
                Color(uiColor: UIColor(hex: "F2F2F7")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack{
                    ConsonantCardContentView(hangulUnit: $hangulUnit)
                }
                .navigationTitle(hangulUnit.unitName.capitalized)
            }
        }
        
    }
}

#Preview {
    ConsonantCardView(hangulUnit: HangulUnit(unitName: "consonant1", unitIndex: 0, hangulCards: [
                HangulCard(name: "ㄱ", sound: "g", example1: "가", example2: "구", soundExample1: "ga", soundExample2: "gu"),
                HangulCard(name: "ㄴ", sound: "n", example1: "나", example2: "누", soundExample1: "na", soundExample2: "nu"),
                HangulCard(name: "ㄷ", sound: "d", example1: "다", example2: "두", soundExample1: "da", soundExample2: "du"),
                HangulCard(name: "ㄹ", sound: "r", example1: "라", example2: "루", soundExample1: "ra", soundExample2: "ru")
    ]))
}
