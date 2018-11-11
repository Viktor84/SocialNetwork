
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
}
