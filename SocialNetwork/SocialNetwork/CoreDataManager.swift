//
//  CoreDataManager.swift
//  SocialNetwork
//
//  Created by Viktor Pechersky on 11.11.2018.
//  Copyright © 2018 Viktor Pecherskyi. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SocialNetwork")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
    
    static let sharedInstance = CoreDataManager()
    fileprivate var mainContext: NSManagedObjectContext!
    fileprivate var privateContext: NSManagedObjectContext!
    
    private init() {
        self.mainContext = persistentContainer.viewContext
        self.privateContext = persistentContainer.newBackgroundContext()
        
    }
    func getPrivateContext() -> NSManagedObjectContext {
        return self.privateContext
    }
    
    func createCuncurrentContext() -> NSManagedObjectContext {
        return persistentContainer.newBackgroundContext()
    }
    
    func saveUser(data: [String: Any]?, completion: @escaping ()->()) {
        guard let item = data else {
            completion()
            return
        }
        privateContext.perform {
            User.insert(into: self.privateContext, item: item)
            self.privateContext.performChanges(block: {
                print("saved successfully")
                completion()
            })
        }
    }
    
    func getUser(completion: @escaping (_ users: [User])->()) {
        privateContext.perform {
            let request = User.sortedFetchRequest
            request.returnsObjectsAsFaults = false
            let users: [User] = try! self.privateContext.fetch(request)
            print("users:", users)
            completion(users)
        }
    }
    
    func deleteUser(user: User, completion: @escaping ()->()) {
     
        privateContext.perform {
            let request = NSFetchRequest<NSFetchRequestResult>()
            request.entity = NSEntityDescription.entity(forEntityName: "User", in: self.privateContext)
            request.predicate = NSPredicate(format: "uuid == %@", user.uuid)
            
            if let resultFetchRequest = try? self.privateContext.fetch(request), !resultFetchRequest.isEmpty {
                if let object = resultFetchRequest[0] as? NSManagedObject {
                    self.privateContext.delete(object)
                }
            }
            
            self.privateContext.performChanges(block: {
                print("delete successfully")
                completion()
            })
        }
    }}

