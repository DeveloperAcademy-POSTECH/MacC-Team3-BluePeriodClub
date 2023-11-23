//
//  BatchimLearningView.swift
//  Orum
//
//  Created by Youngbin Choi on 11/21/23.
//

import SwiftUI

struct BatchimLearningView: View {
    
    @EnvironmentObject var educationManager: EducationManager
    
    @Binding var progressValue: Int
    @Binding var currentEducation: CurrentEducation
    @Binding var isPresented: Bool
    
    var lessonName : String {
        educationManager.nowStudying
    }
    
    var pageIndex : Int {
        educationManager.index
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ProgressView(value: Double(progressValue) / Double(educationManager.content.count * 2 + 2))
                        .padding(.vertical, 16)
                    
                    VStack {
                        Text("Principle")
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                            .onAppear{
                                print(educationManager.nowStudying)
                            }
                        
                        Text(Constants.Hangul.batchimTitle[lessonName]![pageIndex])
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        BatchimExplainView(
                            explainTitle: Constants.Hangul.batchimExplainTitle[lessonName]![pageIndex],
                            explain: Constants.Hangul.batchimExplain[lessonName]![pageIndex])
                        
                        if ((Constants.Hangul.batchimCardCount[lessonName]?[pageIndex])! > 1) {
                            VStack {
                                LazyVGrid(columns: [GridItem(.flexible(), spacing: 15), GridItem(.flexible())], spacing: 15) {
                                    ForEach(0 ..< (Constants.Hangul.batchimCardCount[lessonName]?[pageIndex])!, id: \.self) { index in
                                        HangulCardView(onTapGesture: {}, hangulCard: educationManager.content[pageIndex == 0 ? index : index + 4], cardType: .medium)
                                    }
                                }

                            }
                            .padding(.horizontal, 7)
                            .padding(.bottom, 130)
                        } else {
                            HangulCardView(onTapGesture: {}, hangulCard: HangulCard(name: "ㅇb"), cardType: .large)
                                .padding(.horizontal, 48)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .navigationTitle(educationManager.nowStudying)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    isPresented.toggle()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title3)
                        .foregroundStyle(.blue, Color(uiColor: .secondarySystemFill))
            }))
            }
            
            // 버튼 뒷 배경
            VStack {
                Spacer()
                
                HStack {
                    Button(action: {}, label: {
                        Text("Continue")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                    })
                    .buttonStyle(.borderedProminent)
                    .hidden()
                }
                .padding(24)
                .background(.ultraThinMaterial)
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    if educationManager.index == 1{
                        currentEducation = .recap
                    } else{
                        educationManager.index += 1
                    }
                }, label: {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .bold()
                })
                .buttonStyle(.borderedProminent)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
    }
}

#Preview {
    BatchimLearningView(progressValue: .constant(0), currentEducation: .constant(.learning), isPresented: .constant(true))
        .environmentObject(EducationManager())
}