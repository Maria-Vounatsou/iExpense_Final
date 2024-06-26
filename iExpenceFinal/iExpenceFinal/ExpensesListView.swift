
//
//  ExpensesListView.swift
//  iExpense_Updated
//
//  Created by Vounatsou, Maria on 20/6/24.
//


import SwiftUI

struct ExpensesListView: View {
    @ObservedObject var expenses: ExpenseViewModel
    @Binding var showingAddExpense: Bool
    
    var body: some View {
        
            VStack {
                Spacer()
                    .frame(maxHeight: 30)
                
                List {
                    ForEach(expenses.expensesByCategory.keys.sorted(by: <), id: \.self) { category in
                        Section(header: HStack {
                            Spacer()
                            Text(category)
                                .font(.title3)
                                .bold()
                                .foregroundStyle(Color("ColorTitle"))
                            Spacer()
                        }) {
                            ForEach(expenses.expensesByCategory[category] ?? []) { item in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.name)
                                    }
                                    Spacer()
                                    Text("\(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                                        .foregroundColor(expenses.foregroundColor(for: item.amount))
                                }
                                .foregroundColor(.black)
                                .listRowBackground(Color("Colortext"))
                            }
                            .onDelete { indexSet in
                                expenses.deleteItem(at: indexSet, in: category)
                            }
                            TotalAmountView(category: category, totalAmount: expenses.totalAmount(for: category))
//                            if category == "Business" {
//                                TotalAmountView(category: "Business", totalAmount: expenses.businessTotalAmount)
//                            } else if category == "Personal" {
//                                TotalAmountView(category: "Personal", totalAmount: expenses.personalTotalAmount)
//                            }
                        }
                    }
                }
                .background(Color.clear)
                .scrollContentBackground(.hidden)
                
                Text("Total: \(expenses.totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                    .padding()
                    .font(.system(size: 15))
                    .frame(width: 200, height: 40)
                    .background(Color("ColorTitle"))
                    .foregroundColor(.yellow)
                    .cornerRadius(15)
            }
            .padding(5)
        Spacer()
        Spacer()
            .statusBar(hidden: true)
            Spacer()
            .sheet(isPresented: $showingAddExpense) {
                AddView()
                    .environmentObject(expenses)
            }
    }
}

struct ExpensesListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockExpenses = ExpenseViewModel()
        ExpensesListView(expenses: mockExpenses, showingAddExpense: .constant(false))
    }
}
