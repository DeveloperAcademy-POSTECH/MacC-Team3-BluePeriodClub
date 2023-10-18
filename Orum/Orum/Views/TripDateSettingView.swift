//
//  TripDateSettingView.swift
//  Orum
//
//  Created by 차차 on 10/16/23.
//

import SwiftUI

struct TripDateSettingView: View {
    @State var today = Date()
    @AppStorage("dDay") var dDay: Date = Date()
    @EnvironmentObject var navigationManager: NavigationManager
    let dateFormatter = DateFormatter()
    
    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "D - Day",
                    selection: $dDay,
                    displayedComponents: [.date]
                )
                .padding()
                
                let remainingDay = Calendar.current.compareDays(today, and: dDay)
                
                if remainingDay != 0 {
                    NavigationLink(destination: TripRemainingDayView()) {
                        Button (action: {
                            navigationManager.viewCycle = .second
                        }){
                            Text("Next")
                        }
                    }
                }
                else {
                    NavigationLink(destination: FlightInfoSubmitView()) {
                        Button (action: {
                            navigationManager.viewCycle = .third
                        }){
                            Text("Next")
                        }
                    }
                }
            }
        }

    }
}

#Preview {
    TripDateSettingView()
}
