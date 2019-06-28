//
//  AdminView.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

protocol AdminViewDelegate: class {
  //스쿨관리 버튼 누를시 실행할 메소드
  func getAdminTableView(_ sender: UIButton)
  func moveToAddBeaconVC()
}


class AdminView: UIView {
  
  var delegate: AdminViewDelegate?
  
  // MARK: - Properties
  
  private let adminLabel:UILabel = {
    let label = UILabel()
    label.text = "관리자님, 안녕하세요"
    label.font = UIFont.systemFont(ofSize: 40, weight: .ultraLight)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let schoolButton: UIButton = {
    let button = UIButton(type: .system)
    button.tag = 0
    button.backgroundColor = #colorLiteral(red: 0.9270304569, green: 0.9270304569, blue: 0.9270304569, alpha: 1)
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    button.layer.masksToBounds = false
    button.layer.shadowRadius = 1.0
    button.layer.shadowOpacity = 0.5
    button.setTitle("스쿨관리", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
    button.tintColor = .black
    button.addTarget(self, action: #selector(didTapAdminButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let studentButton: UIButton = {
    let button = UIButton(type: .system)
    button.tag = 1
    button.backgroundColor = #colorLiteral(red: 0.9270304569, green: 0.9270304569, blue: 0.9270304569, alpha: 1)
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    button.layer.masksToBounds = false
    button.layer.shadowRadius = 1.0
    button.layer.shadowOpacity = 0.5
    button.setTitle("학생관리", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
    button.tintColor = .black
    button.addTarget(self, action: #selector(didTapAdminButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let adminButton: UIButton = {
    let button = UIButton(type: .system)
    button.tag = 2
    button.backgroundColor = #colorLiteral(red: 0.9270304569, green: 0.9270304569, blue: 0.9270304569, alpha: 1)
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    button.layer.masksToBounds = false
    button.layer.shadowRadius = 1.0
    button.layer.shadowOpacity = 0.5
    button.setTitle("관리자관리", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
    button.tintColor = .black
    button.addTarget(self, action: #selector(didTapAdminButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let beaconButton: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = #colorLiteral(red: 0.9270304569, green: 0.9270304569, blue: 0.9270304569, alpha: 1)
    button.layer.shadowColor = UIColor.black.cgColor
    button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    button.layer.masksToBounds = false
    button.layer.shadowRadius = 1.0
    button.layer.shadowOpacity = 0.5
    button.setTitle("비콘관리", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .ultraLight)
    button.tintColor = .black
    button.addTarget(self, action: #selector(didTapBeaconButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupAdminView()
    
  }
  private func setupAdminView() {
    addSubview(adminLabel)
    
    addSubview(schoolButton)
    addSubview(studentButton)
    addSubview(adminButton)
    addSubview(beaconButton)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let margin: CGFloat = 20
    
    adminLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    adminLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
    adminLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
    adminLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
    
    schoolButton.topAnchor.constraint(equalTo: adminLabel.bottomAnchor, constant: margin).isActive = true
    schoolButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
    schoolButton.trailingAnchor.constraint(equalTo: studentButton.leadingAnchor, constant: -margin).isActive = true
    schoolButton.bottomAnchor.constraint(equalTo: adminButton.topAnchor, constant: -margin).isActive = true
    
    studentButton.topAnchor.constraint(equalTo: schoolButton.topAnchor).isActive = true
    studentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
    studentButton.bottomAnchor.constraint(equalTo: beaconButton.topAnchor, constant: -margin).isActive = true
    studentButton.heightAnchor.constraint(equalTo: schoolButton.heightAnchor).isActive = true
    studentButton.widthAnchor.constraint(equalTo: schoolButton.widthAnchor).isActive = true
    
    adminButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
    adminButton.trailingAnchor.constraint(equalTo: beaconButton.leadingAnchor, constant: -margin).isActive = true
    adminButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    adminButton.heightAnchor.constraint(equalTo: schoolButton.heightAnchor).isActive = true
    adminButton.widthAnchor.constraint(equalTo: schoolButton.widthAnchor).isActive = true
    
    beaconButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
    beaconButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    beaconButton.heightAnchor.constraint(equalTo: schoolButton.heightAnchor).isActive = true
    beaconButton.widthAnchor.constraint(equalTo: schoolButton.widthAnchor).isActive = true
    
  }
  
  @objc private func didTapAdminButton(_ sender: UIButton) {
    delegate?.getAdminTableView(sender)
  }
  
  @objc private func didTapBeaconButton(_ sender: UIButton) {
    delegate?.moveToAddBeaconVC()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
