//
//  TopCheckView.swift
//  chacha
//
//  Created by 차수연 on 28/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class TopCheckView: UIView {
  
  var myName: String = {
    let temp = UserDefaults.standard.string(forKey: "name") ?? ""
    
    return temp
    }() {
    willSet {
      nameLable.text = newValue
    }
  }
  
  var mySchool: String = {
    let temp = UserDefaults.standard.string(forKey: "school") ?? ""
    
    return temp
    }() {
    willSet {
      schoolLabel.text = newValue
    }
  }
  
  private lazy var nameLable: UILabel = {
    let label = UILabel()
    label.text = "\(myName)님 안녕하세요."
    label.font = UIFont.systemFont(ofSize: 40, weight: .ultraLight)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var schoolLabel: UILabel = {
    let label = UILabel()
    label.text = "\(mySchool),"
    label.font = UIFont.systemFont(ofSize: 20, weight: .ultraLight)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
  
    setupTopCheckView()
  }
  
  private func setupTopCheckView() {
    addSubview(schoolLabel)
    addSubview(nameLable)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    schoolLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    schoolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    schoolLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    schoolLabel.bottomAnchor.constraint(equalTo: nameLable.topAnchor).isActive = true
    
    nameLable.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    nameLable.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    nameLable.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
