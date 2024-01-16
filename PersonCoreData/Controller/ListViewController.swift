//
//  ListViewController.swift
//  PersonCoreData
//
//  Created by hansol on 2024/01/16.
//

import UIKit

class ListViewController: UIViewController {
    
    private let listView = ListView()
    private var personList: [PersonCoreData]!
    
    override func loadView() {
        view = listView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabelView()
        setPersonList()
    }
    
    private func setTabelView() {
        listView.tableView.dataSource = self
        listView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func setPersonList() {
        personList = CoreDataManager.manager.getPerson()
    }
}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let person = personList?[indexPath.row] {
                CoreDataManager.manager.deletePerson(person: person)
                setPersonList()
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        
        cell.editButton.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
        
        cell.nameLabel.text = personList[indexPath.row].name
        cell.ageLabel.text = personList[indexPath.row].age

        return cell
    }
    
    @objc func editButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "수정하기", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "이름"
        }
        alertController.addTextField { textField in
            textField.placeholder = "나이"
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "저장", style: .default) { [weak self] _ in
            guard let self = self else { return }

            if let newName = alertController.textFields?.first?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
               !newName.isEmpty,
               let newAge = alertController.textFields?.last?.text?.trimmingCharacters(in: .whitespacesAndNewlines),
               !newAge.isEmpty {
                let currentName = newName
                let predicate = NSPredicate(format: "name == %@", currentName)

                CoreDataManager.manager.updatePerson(name: newName, age: newAge, predicate: predicate)
            }
            setPersonList()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }
    

    
}

