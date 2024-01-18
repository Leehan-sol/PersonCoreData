//
//  ListView.swift
//  PersonCoreData
//
//  Created by hansol on 2024/01/16.
//

import UIKit

class ListView: UIView {
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.layer.borderWidth = 1.0
        tv.layer.cornerRadius = 10
        tv.layer.masksToBounds = true
        tv.layer.borderColor = UIColor.black.cgColor
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setTableView() {
        self.backgroundColor = .systemBackground
        
        addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
}
