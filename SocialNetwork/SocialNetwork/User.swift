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
    @NSManaged private(set) var lastName: String?
    @NSManaged private(set) var email: String
    @NSManaged private(set) var uuid: String
    @NSManaged private(set) var phone: String
    @NSManaged private(set) var picture: String
    
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
        networkUsers?.lastName = item["lastName"] as? String ?? ""
        networkUsers?.email = item["email"] as? String ?? ""
        networkUsers?.phone = item["phone"] as? String ?? ""
        if let picture = item["picture"] as? String {
            networkUsers?.picture = picture
        }
   
 
        return networkUsers
    }
}

    
extension User: Managed {
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(firstName), ascending: true)]
    }
}

