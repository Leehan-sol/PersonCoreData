//
//  CoreDataManager.swift
//  PersonCoreData
//
//  Created by hansol on 2024/01/16.
//

import UIKit
import CoreData

struct CoreDataManager {
    static let manager = CoreDataManager()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private var container: NSPersistentContainer!
    
    private init() {
        container = appDelegate.persistentContainer
    }
    
    // 1. Create
    func createPerson(name: String, age: String) {
        let entity = NSEntityDescription.entity(forEntityName: "PersonCoreData", in: container.viewContext)
        let person = NSManagedObject(entity: entity!, insertInto: container.viewContext)
        person.setValue(name, forKey: "name")
        person.setValue(age, forKey: "age")
        
        appDelegate.saveContext()
    }
    
    
    // 2. Read
    func getPerson() -> [PersonCoreData]? {
        var personList: [PersonCoreData] = []
        
        do {
            let fetchPersonList = try container.viewContext.fetch(PersonCoreData.fetchRequest())
            personList = fetchPersonList
        } catch {
            print("데이터를 가져오는 중 에러 발생: \(error)")
            return nil
        }
        return personList
    }
    
    
    // 3. Update
    func updatePerson(name: String, age: String, predicate: NSPredicate) {
        let request = NSFetchRequest<PersonCoreData>(entityName: "PersonCoreData")
        request.predicate = predicate
        
        do {
            let fetchedPersons = try container.viewContext.fetch(request)
            for person in fetchedPersons {
                person.name = name
                person.age = age
            }
            try container.viewContext.save()
            print("업데이트 성공")
        } catch {
            print("업데이트 실패: \(error.localizedDescription)")
        }
    }
    
    
    // 4. Delete
    func deletePerson(person: PersonCoreData) {
        container.viewContext.delete(person)
        appDelegate.saveContext()
    }
    
    
}
