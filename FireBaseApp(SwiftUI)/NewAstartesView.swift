//
//  NewAstartesView.swift
//  FireBaseApp(SwiftUI)
//
//  Created by Екатерина  on 14.04.26.
//

import SwiftUI

struct NewAstartesView: View {
    @Environment(DataManager.self) var dataManager
    @State private var newAstartes = ""

    var body: some View {
        VStack {
            TextField("Astartes", text: $newAstartes)

            Button {
                dataManager.addAstartes(astartesTitle: newAstartes)
            } label: {
                Text("Save")
            }
        }
    }
}

#Preview {
    NewAstartesView()
}
