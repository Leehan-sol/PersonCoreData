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
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    private func setAddTarget() {
        mainView.addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        mainView.showButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)
    }
    
    func setTextField() {
        mainView.nameTextField.text = ""
        mainView.ageTextField.text = ""
    }
    
    @objc private func addButtonTapped() {
        guard let name = mainView.nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !name.isEmpty,
              let age = mainView.ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !age.isEmpty else {
            print("Name or age is empty")
            return
        }
        CoreDataManager.manager.createPerson(name: name, age: age)
        setTextField()
    }
    
    @objc private func showButtonTapped() {
        let listVC = ListViewController()
        navigationController?.pushViewController(listVC, animated: true)
    }
    
  

}

