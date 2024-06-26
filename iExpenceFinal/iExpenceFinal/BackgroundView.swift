//
//  BackgroundView.swift
//  iExpense_Updated
//
//  Created by Vounatsou, Maria on 20/6/24.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            Color.colorV
                .edgesIgnoringSafeArea(.all)
                .ignoresSafeArea()
            
            Image("autumn")
                .opacity(0.3)
                .ignoresSafeArea()
                .padding(-190)
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 750, alignment: .bottom)
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
