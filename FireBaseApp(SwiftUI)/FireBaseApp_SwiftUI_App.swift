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

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
