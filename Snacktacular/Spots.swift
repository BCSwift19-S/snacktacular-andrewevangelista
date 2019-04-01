//
//  Spots.swift
//  Snacktacular
//
//  Created by Andrew on 3/29/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import Firebase


class Spots {
    var spotArray = [Spot]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completion: @escaping () -> ()) {
        db.collection("spots").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completion()
            }
            self.spotArray = []
            for document in querySnapshot!.documents {
                let spot = Spot(dictionary: document.data())
                spot.documentID = document.documentID
                self.spotArray.append(spot)
            }
            completion()
        }
    }
    
}
