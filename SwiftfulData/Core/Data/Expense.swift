//
//  Expense.swift
//  SwiftfulData
//
//  Created by Khondakar Afridi on 12/19/23.
//

import Foundation
import SwiftData

@Model
class ExpenseModel{
    var name: String
    var date: Date
    var value: Double
    
    init(name: String, date: Date, value: Double) {
        self.name = name
        self.date = date
        self.value = value
    }
    
}
