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
        personList = CoreDataManager.shared.getPerson()
    }
}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let person = personList?[indexPath.row] {
                CoreDataManager.shared.deletePerson(person: person)
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
        
        cell.nameLabel.text = personList[indexPath.row].name
        cell.ageLabel.text = personList[indexPath.row].age
        
        cell.editButtonClosure = { [weak self] in
            guard let self = self else { return }
            self.showAlert(index: indexPath.row)
        }
        
        return cell
    }
    
    func showAlert(index: Int) {
        let alertController = UIAlertController(title: "데이터 수정", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "이름"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "나이"
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let saveAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let newName = alertController.textFields?[0].text,
                  let newAge = alertController.textFields?[1].text,
                  !newName.trimmingCharacters(in: .whitespaces).isEmpty,
                  !newAge.trimmingCharacters(in: .whitespaces).isEmpty else {
                alertController.textFields?[0].placeholder = "이름을 입력해 주세요."
                alertController.textFields?[1].placeholder = "나이를 입력해 주세요."
                return
            }
            
            CoreDataManager.shared.updatePerson(name: newName, age: newAge, index: index)
            self.setPersonList()
            self.listView.tableView.reloadData()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
}

