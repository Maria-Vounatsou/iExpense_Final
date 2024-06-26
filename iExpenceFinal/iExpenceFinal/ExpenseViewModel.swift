//
//  ExpenseViewModel.swift
//  iExpense_Updated
//
//  Created by Vounatsou, Maria on 20/6/24.
//

import SwiftUI
import Combine

struct Expenses: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    var amount: Double
}

class ExpenseViewModel: ObservableObject {
    
    @Published var items = [Expenses]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Expenses].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
    
    var expensesByCategory: [String: [Expenses]] {
        Dictionary(grouping: items, by: { $0.type })
    }
    
    var totalAmount: Double {
        return items.reduce(0) { $0 + $1.amount }
    }
    
    var personalTotalAmount: Double {
        return items.filter { $0.type == "Personal" }.reduce(0) { $0 + $1.amount }
    }
    
    var businessTotalAmount: Double {
        return items.filter { $0.type == "Business" }.reduce(0) { $0 + $1.amount }
    }
    
    func deleteItem(at offsets: IndexSet, in category: String) {
            // Retrieve the items for the specified category
            if let categoryItems = expensesByCategory[category] {
                // Get the IDs of the items to delete
                let itemIDsToDelete = offsets.map { categoryItems[$0].id }
                // Remove items from the main items array
                items.removeAll { itemIDsToDelete.contains($0.id) }
            }
        }
    
    func foregroundColor(for amount: Double) -> Color {
        if amount < 50 {
            return Color.green
        } else if amount < 150 {
            return Color.yellow
        } else {
            return Color.red
        }
    }
    
    func totalAmount(for category: String) -> Double {
            let categoryExpenses = expensesByCategory[category] ?? []
            return categoryExpenses.reduce(0) { $0 + $1.amount }
        }
}
