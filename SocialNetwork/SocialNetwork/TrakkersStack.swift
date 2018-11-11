//
//  TrakkersStack.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 11.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import CoreData

func createTrakkersContainer(completion: @escaping (NSPersistentContainer) -> ()) {
    let container = NSPersistentContainer(name: "SocialNetwork")
    container.loadPersistentStores { _, error in
        guard error == nil else { fatalError("Failed to load store: \(error)") }
        DispatchQueue.main.async { completion(container) }
    }
}
