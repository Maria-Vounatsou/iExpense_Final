//
//  iExpense_UpdatedApp.swift
//  iExpense_Updated
//
//  Created by Vounatsou, Maria on 20/6/24.
//

import SwiftUI

@main
struct iExpenceFinalApp: App {
    @StateObject private var expenses = ExpenseViewModel()
    @State private var showingAddExpense = false
    
    var body: some Scene {
        WindowGroup {
            MainView(expenses: expenses, showingAddExpense: $showingAddExpense)
                .environmentObject(expenses)
        }
    }
}
