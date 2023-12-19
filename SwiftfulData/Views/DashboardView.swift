//
//  DashboardView.swift
//  SwiftfulData
//
//  Created by Khondakar Afridi on 12/19/23.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var isShowingItemSheet = false
    @Query(sort: \ExpenseModel.date) var expenses: [ExpenseModel]
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(expenses){
                    expense in
                    ExpenseCell(expense: expense)
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        modelContext.delete(expenses[index])
                    }
                })
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet, content: {
                AddExpenseSheet()
            })
            .toolbar{
                if !expenses.isEmpty {
                    Button("Add Expense", systemImage: "plus"){
                        isShowingItemSheet = true
                    }
                }
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding expenses to see your list.")
                    }, actions: {
                        Button("Add Expense") {
                            isShowingItemSheet = true
                        }
                    })
//                    .offset(y: -60)
                }
            }
        }
    }
}

struct ExpenseCell: View{
    let expense : ExpenseModel
    
    var body: some View{
        HStack{
            Text(expense.date, format: .dateTime.month(.abbreviated).day())
                .frame(width: 70, alignment: .leading)
            Text(expense.name)
            Spacer()
            Text(expense.value, format: .currency(code: "USD"))
        }
    }
}

struct AddExpenseSheet: View{
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    
    var body: some View{
        NavigationStack{
            Form{
                TextField("Expense Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Value", value: $value, format: .currency(code: "USD"))
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar{
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        let exp = ExpenseModel(name: name, date: date, value: value)
                        modelContext.insert(exp)
                        
                        try! modelContext.save() // Not required with SwiftData, since it being done automatically on SwiftData
                        
                        dismiss()
                    }, label: {
                        Text("Save")
                    })
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
