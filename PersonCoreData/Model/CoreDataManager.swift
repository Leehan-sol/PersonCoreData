//
//  CoreDataManager.swift
//  PersonCoreData
//
//  Created by hansol on 2024/01/16.
//

import UIKit
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    private let persistentContainer: NSPersistentContainer
    
    private init() {
         persistentContainer = NSPersistentContainer(name: "PersonCoreData")
         persistentContainer.loadPersistentStores { (storeDescription, error) in
             if let error = error as NSError? {
                 fatalError("Unresolved error \(error), \(error.userInfo)")
             }
         }
     }
    
    private func saveContext() {
           let context = persistentContainer.viewContext
           if context.hasChanges {
               do {
                   try context.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
    
    // 1. Create
    func createPerson(name: String, age: String) {
        let entity = NSEntityDescription.entity(forEntityName: "PersonCoreData", in: persistentContainer.viewContext)
        let person = NSManagedObject(entity: entity!, insertInto: persistentContainer.viewContext)
        person.setValue(name, forKey: "name")
        person.setValue(age, forKey: "age")
        
        saveContext()
    }
    
    
    // 2. Read
    func getPerson() -> [PersonCoreData]? {
        var personList: [PersonCoreData] = []
        
        do {
            let fetchPersonList = try persistentContainer.viewContext.fetch(PersonCoreData.fetchRequest())
            personList = fetchPersonList
        } catch {
            print("데이터를 가져오는 중 에러 발생: \(error)")
            return nil
        }
        return personList
    }
    
    
    // 3. Update
    func updatePerson(name: String, age: String, index: Int) {
        let fetchRequest = NSFetchRequest<PersonCoreData>(entityName: "PersonCoreData")
        
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            if index < result.count {
                let personObject = result[index]
                personObject.setValue(name, forKey: "name")
                personObject.setValue(age, forKey: "age")
                saveContext()
            } else {
                print("Index out of bounds")
            }
        } catch {
            print("Failed to update person: \(error)")
        }
    }

    
    // 4. Delete
    func deletePerson(person: PersonCoreData) {
        persistentContainer.viewContext.delete(person)
        saveContext()
    }
    
    
}
