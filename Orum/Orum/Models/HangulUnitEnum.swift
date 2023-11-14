//
//  HangulUnitEnum.swift
//  Orum
//
//  Created by 차차 on 11/5/23.
//

import Foundation

struct HangulUnitEnum: RawRepresentable { // 자모 분리를 통해서 ㄱ -> g & 가 -> ga, 구 -> gu 로 변환 되게 하기
    let rawValue: Int
    
    static let system: [HangulCard] = []
    
    static let consonant1: [HangulCard] = [
        HangulCard(name: "ㄱ"),
        HangulCard(name: "ㄴ"),
        HangulCard(name: "ㄷ"),
        HangulCard(name: "ㄹ"),
    ]
    
    static let consonant2 = [
        HangulCard(name: "ㅁ"),
        HangulCard(name: "ㅂ"),
        HangulCard(name: "ㅅ"),
        HangulCard(name: "ㅇ"),
        HangulCard(name: "ㅈ"),
    ]

    static let consonant3: [HangulCard] = [
        HangulCard(name: "ㅊ"),
        HangulCard(name: "ㅌ"),
        HangulCard(name: "ㅋ"),
        HangulCard(name: "ㅍ"),
        HangulCard(name: "ㅎ"),
    ]
    
    static let consonant4: [HangulCard] = [
        HangulCard(name: "ㄲ"),
        HangulCard(name: "ㄸ"),
        HangulCard(name: "ㅃ"),
        HangulCard(name: "ㅆ"),
        HangulCard(name: "ㅉ"),
        
    ]
    
    static let consonant5: [HangulCard] = []
    
    static let vowel1: [HangulCard] = [
        HangulCard(name: "ㄱ"),
        HangulCard(name: "ㄴ"),
        HangulCard(name: "ㄷ"),
        HangulCard(name: "ㄹ"),
    ]
    
    static let vowel2: [HangulCard] = []
    
    static let vowel3: [HangulCard] = []
}
