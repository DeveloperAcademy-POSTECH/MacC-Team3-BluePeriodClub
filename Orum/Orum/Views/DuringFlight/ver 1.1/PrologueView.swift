//
//  PrologueView.swift
//  Orum
//
//  Created by 차차 on 11/14/23.
//

import SwiftUI

struct PrologueView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PrologueView(isPresented: .constant(false))
}
