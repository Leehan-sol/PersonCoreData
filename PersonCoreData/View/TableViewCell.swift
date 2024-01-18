//
//  TableViewCell.swift
//  PersonCoreData
//
//  Created by hansol on 2024/01/16.
//

import UIKit

class TableViewCell: UITableViewCell {
    var editButtonClosure: (() -> Void)!
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let editButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("수정", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(ageLabel)
        contentView.addSubview(editButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            ageLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 20),
            ageLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            editButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func setAddTarget() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc func editButtonTapped() {
        editButtonClosure()
    }
    
    
}
