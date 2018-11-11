//
//  EntityAndPredicate.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 11.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import CoreData

final class EntityAndPredicate<A : NSManagedObject> {
    let entity: NSEntityDescription
    let predicate: NSPredicate
    
    init(entity: NSEntityDescription, predicate: NSPredicate) {
        self.entity = entity
        self.predicate = predicate
    }
}

extension EntityAndPredicate {
    var fetchRequest: NSFetchRequest<A> {
        let request = NSFetchRequest<A>()
        request.entity = entity
        request.predicate = predicate
        return request
    }
}
