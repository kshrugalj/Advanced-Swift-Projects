//
//  ICaloriesApp.swift
//  ICalories
//
//  Created by Kshrugal Reddy Jangalapalli on 2/15/25.
//

import SwiftUI

@main
struct ICaloriesApp: App {
    @StateObject private var dataContoller = DataContoller()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, dataContoller.container.viewContext)
        }
    }
}
