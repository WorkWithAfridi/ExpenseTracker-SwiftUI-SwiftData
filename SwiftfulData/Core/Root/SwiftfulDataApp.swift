//
//  SwiftfulDataApp.swift
//  SwiftfulData
//
//  Created by Khondakar Afridi on 12/19/23.
//

import SwiftUI
import SwiftData


@main
struct SwiftfulDataApp: App {
//    let container: ModelContainer = {
//        let schema = Schema([ExpenseModel.self])
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
//        .modelContainer(container) // for more customization and control
        .modelContainer(for: [ExpenseModel.self])
    }
}
