//
//  ListView.swift
//  FireBaseApp(SwiftUI)
//
//  Created by Екатерина  on 14.04.26.
//

import SwiftUI

struct Astartes {
    var id: String
    var title: String
}

struct ListView: View {
    @Environment(DataManager.self) var dataManager
    @State private var showPup = false

    var body: some View {
        NavigationStack {
            List(dataManager.astartes, id: \.id) { astartes in
                Text(astartes.title)
            }
            .navigationTitle("Astartes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showPup.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showPup) {
                NewAstartesView()
            }
        }
    }
}

#Preview {
    ListView()
}
