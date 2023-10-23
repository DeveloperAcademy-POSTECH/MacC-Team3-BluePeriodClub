//
//  HangulEducationTableView.swift
//  Orum
//
//  Created by 차차 on 10/23/23.
//

import SwiftUI

struct HangulEducationTableView: View {
    @EnvironmentObject var educationManager: EducationManager
    @State var isNextButtonPressed = false
    @State var isBackButtonPressed = false
    @State var remainingSeconds: Int = 3600
    @State var isCountdownOver: Bool = false
    
    @AppStorage("arr_time") var arr_time : Date = Date()
    @AppStorage("dep_time") var dep_time : Date?
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        return formatter
    }
    
    var flightPercent: CGFloat {
        return CGFloat(100 - Int(Float(remainingSeconds) / Float(flightTime)  * 100)) / 100
    }
    
    var flightTime:Int {
        return Int(arr_time.timeIntervalSince(dep_time ?? Date()))
    }
        
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: UIColor(hex: "F2F2F7")).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack(spacing: 15) {
                    ZStack {
                        HStack {
                            Spacer()
                            Text(timeString(remainingSeconds))
                                .font(.caption2)
                                .bold()
                                .onReceive(timer) { _ in
                                    if remainingSeconds > 0 {
                                        remainingSeconds -= 1
                                    }
                                    else {
                                        isCountdownOver.toggle()
                                    }
                                }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 7)
                        .background(RoundedRectangle(cornerRadius: 19)
                            .foregroundColor(.white)
                        )
                        
                        HStack {
                            HStack {
                                Text("\(100 - Int(Float(remainingSeconds) / Float(flightTime)  * 100))%")
                                    .font(.caption2)
                                    .bold()
                                    .padding(.trailing, 230 * CGFloat( flightPercent) )
                                
                                Image(systemName: "airplane")
                                    .font(.caption2)
                                    .bold()
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 7)
                            .background(.white)
                            .cornerRadius(29)
                            .overlay(
                                RoundedRectangle(cornerRadius: 29)
                                    .inset(by: 0.5)
                                    .stroke(.black, lineWidth: 1)
                            )
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 15)
                    
                    List {
                        Section(header: Text("\(educationManager.unit.rawValue)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.primary)
                        ) {
                            VStack(alignment: .leading,spacing: 15) {
                                HStack {
                                    Image(systemName: "chevron.up")
                                        .bold()
                                    Text("Consononats")
                                        .bold()
                                }
                                .padding(.top, 15)
                                .padding(.horizontal, 15)
                                
                                HStack {
                                    ForEach (0 ..< 4) { _ in
                                        RoundedRectangle(cornerRadius: 4)
                                            .foregroundColor(.accentColor)
                                            .frame(width: 50 ,height: 70)
                                    }
                                }
                                .padding(.horizontal, 20)
                                
                                Divider()
                                
                                HStack {
                                    Image(systemName: "chevron.up")
                                        .bold()
                                    
                                    Text("Vowels")
                                        .bold()
                                }
                                .padding(.horizontal, 15)
                                .padding(.bottom, 15)
                            }
                            
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                    .padding(.top)
                    
                    Divider()
                    
                    HStack {
                        Button(action: {
                            isBackButtonPressed.toggle()
                        }) {
                            Image(systemName: "arrow.uturn.left")
                                .bold()
                                .padding(.all, 15)
                        }
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.white))
                        
                        Spacer()
                        
                        Button(action: {
                            isNextButtonPressed.toggle()
                        }) {
                            HStack {
                                Image(systemName: "arrow.right.circle.fill")
                                    .bold()
                                
                                Text("Next")
                                    .bold()
                            }
                            .foregroundColor(.white)
                            .padding(.all, 15)
                        }
                        .cornerRadius(15)
                        .background(RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.accentColor))
                    }
                    .padding(.horizontal, 15)
                }
                .padding(.top, 15)
                .padding(.bottom, 40)
            }
            .navigationDestination(isPresented: $isNextButtonPressed, destination: {
                ConsonantCardView(hangulUnit: HangulUnit(unitName: "consonants1", unitIndex: 0, hangulCards: [
                    HangulCard(name: "ㄱ", sound: "g", example1: "가", example2: "구", soundExample1: "ga", soundExample2: "gu"),
                    HangulCard(name: "ㄴ", sound: "n", example1: "나", example2: "누", soundExample1: "na", soundExample2: "nu"),
                    HangulCard(name: "ㄷ", sound: "d", example1: "다", example2: "두", soundExample1: "da", soundExample2: "du"),
                    HangulCard(name: "ㄹ", sound: "r", example1: "라", example2: "루", soundExample1: "ra", soundExample2: "ru")
                ]))
                    .environmentObject(educationManager)
                    .navigationBarBackButtonHidden()
            })
            .navigationDestination(isPresented: $isBackButtonPressed, destination: {
                HangulEducationMainView()
                    .environmentObject(educationManager)
                    .navigationBarBackButtonHidden()
            })
            .onAppear {
                remainingSeconds = Int(arr_time.timeIntervalSince(Date()))
            }
            .onDisappear {
                timer.upstream.connect().cancel()
            }
        }
    }
    
    func timeString(_ seconds: Int) -> String {
            var minutes = seconds / 60
            let hours = minutes / 60
            minutes = minutes % 60
            let seconds = seconds % 60
            return String(format: "%02d:%02d:%02d",hours, minutes, seconds)
        }
}

#Preview {
    HangulEducationTableView()
        .environmentObject(EducationManager())
}