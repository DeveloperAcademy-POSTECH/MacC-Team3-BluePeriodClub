//
//  HangulEducationLearningView.swift
//  Orum
//
//  Created by Youngbin Choi on 10/31/23.
//

import SwiftUI

struct HangulEducationLearningView: View {
    @State var touchCardsCount : Int = 0
    @State var isOnceFlipped = false
    @State var isFlipped = false
    @State var isExample1Listened = false
    @State var isExample2Listened = false
    @State var isDrawingViewShowing = true
    
    
    @EnvironmentObject var educationManager: EducationManager
    
    @Namespace var bottomID
    
    let ttsManager = TTSManager()
    
    @Binding var progressValue: Int
    
    var body: some View {
        
        ScrollViewReader { proxy in
            ZStack {
                ScrollView {
                    VStack {
                        ProgressView(value: Double(progressValue) / Double(educationManager.content.count * 2 + 2))
                            .padding(.vertical, 16)
                        VStack {
                            Text("\(touchCardsCount)/3")
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                            
                            Text("Touch the Cards")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.center)
                        }
                        
                        if educationManager.nowStudying == Constants.Lesson.vowel1 && educationManager.index == 0 {
                            BatchimExplainView(explainTitle: "\(Image(systemName: "lightbulb.max")) Tip" , explain: "The closest pronunciation in English to the given word, and listen carefully to the Korean pronunciation below")
                                .padding(.bottom, 30)
                        }                        
                        
                        VStack(spacing: 25){
                            HangulCardView(onTapGesture: {
                                if !isOnceFlipped {
                                    touchCardsCount += 1
                                }
                                
                                isOnceFlipped = true
                            }, hangulCard: educationManager.content[educationManager.index], cardType: .large, canBorderColorChange: true)
                            .environmentObject(educationManager)
                            
                            if educationManager.chapterType == .consonant || educationManager.chapterType == .vowel {
                                HStack(spacing: 25) {
                                    Text(educationManager.content[educationManager.index].example1) //TODO: ForEach로 구현하기
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .font(.largeTitle)
                                        .padding(20)
                                        .overlay(RoundedRectangle(cornerRadius: 24)
                                            .strokeBorder(isExample1Listened ? Color(uiColor: .systemGray4) : .blue , lineWidth: 11))
                                        .onTapGesture {
                                            if !isExample1Listened {
                                                touchCardsCount += 1
                                            }
                                            withAnimation(.easeIn(duration: 0.5)){
                                                isExample1Listened = true
                                            }
                                            SoundManager.instance.playSound(sound: "\(educationManager.content[educationManager.index].example1)")
                                        }
                                    
                                    Text(educationManager.content[educationManager.index].example2)
                                        .bold()
                                        .frame(maxWidth: .infinity)
                                        .font(.largeTitle)
                                        .padding(20)
                                        .overlay(RoundedRectangle(cornerRadius: 24)
                                            .strokeBorder(isExample2Listened ? Color(uiColor: .systemGray4) : .blue , lineWidth: 11))
                                        .onTapGesture {
                                            if !isExample2Listened {
                                                touchCardsCount += 1
                                            }
                                            withAnimation(.easeIn(duration: 0.5)){
                                                isExample2Listened = true
                                            }
                                            SoundManager.instance.playSound(sound: "\(educationManager.content[educationManager.index].example2)")
                                        }
                                }
                            }
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(.clear)
                                    .id(bottomID)
                            }
                                .padding(.horizontal, 48)
                        }
                        .padding(.horizontal, 16)
                    
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height * 0.15)
                    }
                    
                VStack {
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .foregroundStyle(.ultraThinMaterial)
                            .frame(height: UIScreen.main.bounds.height * 0.15)
                        
                        VStack(spacing: 0){
                            
                            Button(action: {
                                if educationManager.index < educationManager.content.count - 1 {
                                    progressValue += 1
                                    
                                    if educationManager.chapterType == .vowel {
                                        if educationManager.nowStudying == Constants.Lesson.vowel1 && (educationManager.index == 1 || educationManager.index == 5) {
                                            print(educationManager.index)
                                            educationManager.currentEducation = .basicVowelCheck
                                            return
                                        }
                                        else {
                                            educationManager.currentEducation = .vowelDrawing
                                        }
                                    }
                                    
                                    educationManager.index += 1
                                }
                                else {
                                    if educationManager.chapterType == .vowel {
                                        if educationManager.nowStudying == Constants.Lesson.vowel1 && educationManager.index == 7 {
                                            educationManager.currentEducation = .basicVowelCheck
                                            return
                                        }
                                    }
                                    
                                    isOnceFlipped = false
                                    educationManager.index = 0
                                    withAnimation(.easeIn(duration: 1)) {
                                        progressValue += 1
                                        educationManager.currentEducation = .recap
                                    }
                                }
                                
                                withAnimation (.easeIn(duration: 1)){
                                    isOnceFlipped = false
                                    isExample1Listened = false
                                    isExample2Listened = false
                                    touchCardsCount = 0
                                }
                            },label: {
                                Text("Continue")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 8)
                                    .bold()
                            })
                            .buttonStyle(.borderedProminent)
                            .background((educationManager.index == 0 && isOnceFlipped && isExample1Listened && isExample2Listened) ? .blue.opacity(0.05) : .clear)
                            .disabled((educationManager.chapterType == .consonant && (!isOnceFlipped || !isExample1Listened || !isExample2Listened)) || (educationManager.chapterType == .vowel && !isOnceFlipped))
                            .padding(.horizontal, 24)
                            .padding(.top, 24)
                            .padding(.bottom, 48)
                        }
                    }
                }
                .ignoresSafeArea(edges: .bottom)
                }
            }
        }
    }


#Preview {
    HangulEducationLearningView(progressValue: .constant(0))
        .environmentObject(EducationManager())
}


