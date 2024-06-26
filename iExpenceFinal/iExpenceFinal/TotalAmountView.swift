//
//  TotalAmountView.swift
//  iExpense_Updated
//
//  Created by Vounatsou, Maria on 20/6/24.
//

import SwiftUI

struct TotalAmountView: View {
    @EnvironmentObject var expenses: ExpenseViewModel
    var category : String
    let totalAmount: Double
    
    var body: some View {
        
        HStack {
            Text("Total: ")
                .bold()
                .foregroundColor(.black)
            
            Spacer()
            
            Text("\(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                .bold()
                .foregroundColor(.black)
        }
        .listRowBackground(Color("Colortext"))
        .padding(.vertical, 8)
    }
}

struct TotalAmountView_Previews: PreviewProvider {
    static var previews: some View {
        TotalAmountView(category: "Business", totalAmount: 1000.0)
            .environmentObject(ExpenseViewModel())
            .padding()
    }
}

