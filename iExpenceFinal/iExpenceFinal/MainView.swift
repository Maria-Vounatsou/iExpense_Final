//
//  ContentView.swift
//  iExpense_Updated
//
//  Created by Vounatsou, Maria on 20/6/24.
//

import SwiftUI

struct MainView: View {
    
    @State private var title = TitleView(text: "i", secondText: "Expense")
    @ObservedObject var expenses: ExpenseViewModel
    @Binding var showingAddExpense: Bool
    
    var body: some View {
        NavigationStack {
            BackgroundView()
                .overlay(
                    VStack {
                        Spacer()
                        
                        ExpensesListView(expenses: expenses, showingAddExpense: $showingAddExpense)
                            .environmentObject(expenses)
                        Spacer()
                    }
                )
                .toolbar {
                    Button("Add Expense", systemImage: "plus.viewfinder") {
                        showingAddExpense = true
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        title
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let expenses = ExpenseViewModel()
        MainView(expenses: expenses, showingAddExpense: .constant(false))
    }
}
