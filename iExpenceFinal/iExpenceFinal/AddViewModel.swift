//
//  AddViewModel.swift
//  iExpense_Updated
//
//  Created by Vounatsou, Maria on 25/6/24.
//

import SwiftUI
import Combine

class AddViewModel: ObservableObject {
    @Published var name = ""
    @Published var type = "Personal"
    @Published var amount = 0.0
    @Published var newType = ""
    @Published var toBeDeleted = ""

    @Published private var _types: [String]

    
    var types: [String] {
            get { _types }
            set {
                _types = newValue
                UserDefaults.standard.set(_types, forKey: "types")
                objectWillChange.send() // Notify SwiftUI of the change
            }
        }
        
        init() {
            self._types = UserDefaults.standard.stringArray(forKey: "types") ?? ["Personal", "Business", "Entertainment", "Home"].sorted()
        }
        
        func isNewTypeUnique(_ newType: String) -> Bool {
            !_types.contains(newType)
        }
        
        func isToBeDeletedValid() -> Bool {
            _types.contains(toBeDeleted)
        }
        
        func deleteType(named toBeDeleted: String) {
            if let index = _types.firstIndex(of: toBeDeleted) {
                _types.remove(at: index)
                UserDefaults.standard.set(_types, forKey: "types")
                objectWillChange.send() 
            }
        }
        
    func addNewType() {
         let trimmedType = newType.trimmingCharacters(in: .whitespaces)
         guard !trimmedType.isEmpty else { return }
         _types.append(trimmedType)
         newType = ""
         UserDefaults.standard.set(_types, forKey: "types")
         objectWillChange.send()
     }
        
        func backgroundColor(for amount: Double) -> Color {
            if amount < 50 {
                return Color.blue.opacity(0.3)
            } else if amount < 150 {
                return Color.yellow.opacity(0.3)
            } else {
                return Color.red.opacity(0.3)
            }
        }
    }
//    @Published var types: [String] {
//            didSet {
//                UserDefaults.standard.set(types, forKey: "types")
//            }
//        }
//        
//        init() {
//            self.types = UserDefaults.standard.stringArray(forKey: "types") ?? ["Personal", "Business", "Entertainment", "Home"].sorted()
//        }
//    
//    func isNewTypeUnique(_ newType: String) -> Bool {
//           return !types.contains(newType)
//       }
//    
//    func isToBeDeletedValid() -> Bool {
//          return types.contains(toBeDeleted)
//      }
//    
//    func deleteType(named toBeDeleted: String) {
//           if let index = types.firstIndex(of: toBeDeleted) {
//               types.remove(at: index)
//           }
//       }
//    
//    func addNewType() {
//        guard !newType.isEmpty else { return }
//        types.append(newType)
//        newType = ""
//    }
//    
//    func backgroundColor(for amount: Double) -> Color {
//        if amount < 50 {
//            return Color.blue.opacity(0.3)
//        } else if amount < 150 {
//            return Color.yellow.opacity(0.3)
//        } else {
//            return Color.red.opacity(0.3)
//        }
//    }
//    
//}


