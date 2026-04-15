//
//  FireBaseApp_SwiftUI_App.swift
//  FireBaseApp(SwiftUI)
//
//  Created by Екатерина  on 2.04.26.
//

import SwiftUI
import Firebase

@main
struct FireBaseApp_SwiftUI_App: App {
    @State private var dataManager = DataManager()

    init() {
       // FireBaseApp_SwiftUI_App.configure()
       // FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataManager)
        }
    }
}
