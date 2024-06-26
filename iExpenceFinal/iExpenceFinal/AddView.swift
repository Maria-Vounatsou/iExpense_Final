//
//  AddView.swift
//  iExpense_Updated
//
//  Created by Vounatsou, Maria on 20/6/24.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var expenses: ExpenseViewModel
    
    @StateObject private var viewModel = AddViewModel()
    
    @State private var title0 = TitleView(text: "A", secondText: "dd")
    @State private var title1 = TitleView(text: "N", secondText: "ew")
    @State private var title2 = TitleView(text: "E", secondText: "xpence")
    
    @State private var showAddAlert = false
    @State private var showDeleteAlert = false
    
    @State private var keyboardHeight: CGFloat = 10
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    
                    Color.colorV
                        .edgesIgnoringSafeArea(.all)
                    
                    Image("autumn")
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .padding(-190)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height:700, alignment: .bottom)
                    
                    VStack {
                        Spacer()
                        Form {
                            Section(header: HStack {
                                Spacer()
                                Text("Expence")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(Color("ColorTitle"))
                                Spacer()
                            }) {
                                TextField("Name", text: $viewModel.name)
                                    .bold()
                                
                                Picker("Type", selection: $viewModel.type) {
                                    ForEach(viewModel.types, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .bold()
                                
                                TextField("Amount", value: $viewModel.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .padding(5)
                                    .background(viewModel.backgroundColor(for: viewModel.amount))
                                    .keyboardType(.decimalPad)
                                    .bold()
                                    .cornerRadius(20)
                                    .frame(maxWidth: 100)
                            }
                            .listRowBackground(Color("Colortext"))
                            
                            Section(header: HStack {
                                Spacer()
                                Text("Add New Type")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(Color("ColorTitle"))
                                Spacer()
                            }) {
                                TextField("New type", text: $viewModel.newType)
                                    .bold()
                            }
                            .listRowBackground(Color("Colortext"))
                            
                            Section(header: HStack {
                                Spacer()
                                Text("Delete Type")
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(Color("ColorTitle"))
                                Spacer()
                            }) {
                                TextField("To be deleted", text: $viewModel.toBeDeleted)
                                    .bold()
                            }
                            .listRowBackground(Color("Colortext"))
                        }
                        .background(Color.clear)
                        .scrollContentBackground(.hidden)
                        
                        HStack {
                            Spacer()
                            Button(action: {
                                if viewModel.isNewTypeUnique(viewModel.newType) {
                                    viewModel.addNewType()
                                } else {
                                    showAddAlert = true
                                }
                            }) {
                                Text("Add")
                                    .padding()
                                    .bold()
                                    .font(.system(size: 23))
                                    .frame(width: 100, height: 40)
                                    .background(Color("ColorTitle"))
                                    .foregroundColor(.yellow)
                                    .cornerRadius(15)
                            }
                            .alert(isPresented: $showAddAlert) {
                                Alert(title: Text("Duplicate Type"), message: Text("Type '\(viewModel.newType)' already exists."), dismissButton: .default(Text("OK")))
                            }
                            Spacer()
                  
                            Button(action: {
                                if viewModel.isToBeDeletedValid() {
                                    viewModel.deleteType(named: viewModel.toBeDeleted)
                                    viewModel.toBeDeleted = ""
                                } else {
                                    showDeleteAlert = true
                                }
                            }) {
                                Text("Delete")
                                    .padding()
                                    .bold()
                                    .font(.system(size: 23))
                                    .frame(width: 100, height: 40)
                                    .foregroundColor(.yellow)
                                    .background(Color("ColorTitle"))
                                    .opacity(10)
                                    .cornerRadius(15)
                            }
                            .alert(isPresented: $showDeleteAlert) {
                                Alert(title: Text("Invalid Deletion"), message: Text("Type '\(viewModel.toBeDeleted)' does not exist."), dismissButton: .default(Text("OK")))
                            }
                            Spacer()
                        }
                        Spacer()
                            .frame(maxHeight: 200)
                    }
                    .statusBar(hidden: true)
                    
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                title0
                                title1
                                title2
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                let item = Expenses(name: viewModel.name, type: viewModel.type, amount: viewModel.amount)
                                expenses.items.append(item)
                                dismiss()
                            } label: {
                                Label("Save", systemImage: "square.and.arrow.down")
                            }
                            .foregroundColor(.yellow)
                            .bold()
                        }
                    }
                }
            }
            .ignoresSafeArea(.keyboard)
        }
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environmentObject(ExpenseViewModel())
    }
}
