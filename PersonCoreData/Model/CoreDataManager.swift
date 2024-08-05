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
    private let context: NSManagedObjectContext
    
    // 1. PersistentContainer 생성
    private init() {
        persistentContainer = NSPersistentContainer(name: "PersonCoreData")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        context = persistentContainer.viewContext
    }
    
    func saveContext() {
        // 5. Context에 변화가 있을 시 내용 저장
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    // Create
    func createPerson(name: String, age: String) {
        // 2. Context 기반으로 Entity 생성
        let entity = NSEntityDescription.entity(forEntityName: "PersonCoreData", in: context)
        // 3. Entity를 기반으로 Object 생성
        let person = NSManagedObject(entity: entity!, insertInto: context)
        // 4. Object에 값 setting
        person.setValue(name, forKey: "name")
        person.setValue(age, forKey: "age")
        saveContext()
    }
    
    
    // Read
    func getPerson() -> [PersonCoreData]? {
        var personList: [PersonCoreData] = []
        
        do {
            // 검색방법 1
            let fetchPersonList = try context.fetch(PersonCoreData.fetchRequest())
            personList = fetchPersonList
        } catch {
            print("데이터를 가져오는 중 에러 발생: \(error)")
            return nil
        }
        return personList
    }
    
    
    // Update
    func updatePerson(name: String, age: String, index: Int) {
        // 검색방법 2
        // index를 가져와서 여기서 찾아서 데이터 업데이트
        //        let fetchRequest: NSFetchRequest<PersonCoreData> = NSFetchRequest(entityName: "PersonCoreData")
        
        do {
            let result = try context.fetch(PersonCoreData.fetchRequest())
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
        // 인덱스까지 가진 person이라는 매개변수를 받아서 삭제만 실행
        context.delete(person)
        saveContext()
    }
    
    
}


