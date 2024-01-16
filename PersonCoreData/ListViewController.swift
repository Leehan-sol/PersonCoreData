//
//  ListViewController.swift
//  PersonCoreData
//
//  Created by hansol on 2024/01/16.
//

import UIKit

class ListViewController: UIViewController {

    private let listView = ListView()

    override func loadView() {
        view = listView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabelView()
    }
    
    private func setTabelView() {
        listView.tableView.dataSource = self
        listView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
}


// MARK: - UITableViewDataSource
extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }

        cell.nameLabel.text = "이름"
        cell.ageLabel.text = "나이"

        cell.editButton.addTarget(self, action: #selector(editButtonTapped(_:)), for: .touchUpInside)
        cell.editButton.tag = indexPath.row

        return cell
    }

    @objc func editButtonTapped(_ sender: UIButton) {
        let row = sender.tag
        print("Edit button tapped for row \(row)")
    }
}

