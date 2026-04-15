//
//  DataManager.swift
//  FireBaseApp(SwiftUI)
//
//  Created by Екатерина  on 14.04.26.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Observation

@Observable
class DataManager {
    var astartes: [Astartes] = []

    init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        fetchAstartes()
    }

    func fetchAstartes() {
        astartes.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Astartes")

        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print("Ошибка при получении документов: \(error!.localizedDescription)")
                return
            }

            guard let snapshot else {
                print("Снимок не получен")
                return
            }

            Task {
                @MainActor in
                for document in snapshot.documents {
                    let data = document.data()
                    let id = data["id"] as? String ?? ""
                    let title = data["title"] as? String ?? ""

                    let astartesItem = Astartes(id: id, title: title)
                    self.astartes.append(astartesItem)
                }
            }
        }
    }

    func addAstartes(astartesTitle: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Astartes").document()

        ref.setData([
            "title": astartesTitle,
            "id": ref.documentID
        ]) { error in
            guard error == nil else {
                print("Ошибка при добавлении: \(error!.localizedDescription)")
                return
            }
            print("Astartes успешно добавлен с ID: \(ref.documentID)")
            self.fetchAstartes()
        }
    }
}
