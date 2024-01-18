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
    
    // 1. PersistentContainer 생성
    private init() {
         persistentContainer = NSPersistentContainer(name: "PersonCoreData")
         persistentContainer.loadPersistentStores { (storeDescription, error) in
             if let error = error as NSError? {
                 fatalError("Unresolved error \(error), \(error.userInfo)")
             }
         }
     }
    
    private func saveContext() {
        // Context에 내용 저장
           if persistentContainer.viewContext.hasChanges {
               do {
                   try persistentContainer.viewContext.save()
               } catch {
                   let nserror = error as NSError
                   fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
               }
           }
       }
    
    // Create
    func createPerson(name: String, age: String) {
        // 2. Context 기반으로 Entity 생성
        let entity = NSEntityDescription.entity(forEntityName: "PersonCoreData", in: persistentContainer.viewContext)
        // 4. Entity를 기반으로 Object 생성
        let person = NSManagedObject(entity: entity!, insertInto: persistentContainer.viewContext)
        // 5. Object에 값 setting
        person.setValue(name, forKey: "name")
        person.setValue(age, forKey: "age")
        saveContext()
    }
    
    
    // Read
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
    
    
    // Update
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

    
    // Delete
    func deletePerson(person: PersonCoreData) {
        persistentContainer.viewContext.delete(person)
        saveContext()
    }
    
    
}
