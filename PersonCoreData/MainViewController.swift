//
//  MainViewController.swift
//  PersonCoreData
//
//  Created by hansol on 2024/01/16.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private var container: NSPersistentContainer!
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        setContainer()
//        printSavedPerson()
    }
    
    private func setAddTarget() {
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        mainView.showButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)
    }
    
    func setContainer() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.container = appDelegate.persistentContainer
    }
    
    @objc private func addButtonTapped() {
        if let name = mainView.nameTextField.text, let age = mainView.ageTextField.text {
            createPerson(name: name, age: age)
        }
    }
    
    
    @objc private func showButtonTapped() {
        let listVC = ListViewController()
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    
    func createPerson(name: String, age: String) {
        let entity = NSEntityDescription.entity(forEntityName: "PersonCoreData", in: self.container.viewContext)
        let person = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
        person.setValue("히", forKey: "name")
        person.setValue("ㅇ", forKey: "age")
        
        do {
            try self.container.viewContext.save()
            print("저장 성공")
        } catch {
            print("저장 실패: \(error.localizedDescription)")
        }
    }
    
//    func printSavedPerson() {
//           let fetchRequest: NSFetchRequest<PersonCoreData> = PersonCoreData.fetchRequest()
//           
//           do {
//               let savedPersons = try self.container.viewContext.fetch(fetchRequest)
//               for person in savedPersons {
//                   print("Name: \(person.name ?? "Unknown"), Age: \(person.age)")
//               }
//           } catch {
//               print("Failed to fetch persons: \(error.localizedDescription)")
//           }
//       }
    
    
    
}
