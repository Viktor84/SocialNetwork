//
//  User.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 08.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import CoreData

final class User: NSManagedObject {

    @NSManaged private(set) var firstName: String?
    //@NSManaged private(set) var lastName: String
    //@NSManaged private(set) var email: String
    @NSManaged private(set) var uuid: String
    //@NSManaged private(set) var phone: String
    
    @discardableResult
    static func insert(into context: NSManagedObjectContext, item: [String: Any]?) -> User? {
        
        var networkUsers: User?
        
        guard let item = item as? [String: Any] else {
            return nil
        }
   
        guard let uuid = item["uuid"] as? String else {
            return nil
        }

        if let existed = self.objectByUuid(context: context, uuid: uuid) {
            networkUsers = existed
        } else {
            networkUsers = context.insertObject()
            networkUsers?.uuid = uuid
        }

        networkUsers?.firstName = item["firstName"] as? String ?? ""
 
        return networkUsers
    }
}

    
extension User: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(firstName), ascending: true)]
    }
}

