//
//  MainView.swift
//  PersonCoreData
//
//  Created by hansol on 2024/01/16.
//

import UIKit

class MainView: UIView {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        return label
    }()
    
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 10.0
        return tf
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.text = "나이"
        return label
    }()
    
    let ageTextField: UITextField = {
        let tf = UITextField()
        tf.layer.borderWidth = 1.0
        tf.layer.cornerRadius = 10.0
        return tf
    }()
    
    let addButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" 추가하기 ", for: .normal)
        btn.backgroundColor = .lightGray
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    let showButton: UIButton = {
        let btn = UIButton()
        btn.setTitle(" 데이터 ", for: .normal)
        btn.backgroundColor = .lightGray
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .systemBackground
        
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(ageLabel)
        addSubview(ageTextField)
        addSubview(addButton)
        addSubview(showButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        showButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 250),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            nameLabel.widthAnchor.constraint(equalToConstant: 40),
            
            nameTextField.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            ageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            ageLabel.widthAnchor.constraint(equalToConstant: 40),
            
            ageTextField.centerYAnchor.constraint(equalTo: ageLabel.centerYAnchor),
            ageTextField.leadingAnchor.constraint(equalTo: ageLabel.trailingAnchor, constant: 30),
            ageTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            ageTextField.heightAnchor.constraint(equalToConstant: 40),
            
            addButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 100),
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 120),
            
            showButton.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 100),
            showButton.leadingAnchor.constraint(equalTo: addButton.trailingAnchor, constant: 10)
        ])
    }
    
}

