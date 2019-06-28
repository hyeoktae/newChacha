//
//  TopCheckView.swift
//  chacha
//
//  Created by 차수연 on 28/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class TopCheckView: UIView {
  
  var myName: String = "" {
    willSet {
      nameLable.text = "\(newValue)님 안녕하세요."
    }
  }
  
  var mySchool: String = "" {
    willSet {
      schoolLabel.text = "\(newValue) 스쿨,"
    }
  }
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "background")
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let view: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var nameLable: UILabel = {
    let label = UILabel()
//    label.text = "\(myName)님 안녕하세요."
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 40, weight: .ultraLight)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var schoolLabel: UILabel = {
    let label = UILabel()
//    label.text = "\(mySchool) 스쿨,"
    label.textColor = .white
    label.font = UIFont.systemFont(ofSize: 20, weight: .light)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
  
    setupTopCheckView()
  }
  
  func setupTopCheckView() {
    myName = UserDefaults.standard.string(forKey: "name") ?? ""
    mySchool = UserDefaults.standard.string(forKey: "school") ?? ""
    
    addSubview(imageView)
    imageView.addSubview(view)
    
    view.addSubview(schoolLabel)
    view.addSubview(nameLable)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    view.topAnchor.constraint(equalTo: topAnchor).isActive = true
    view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    
    schoolLabel.topAnchor.constraint(equalTo: topAnchor, constant: 120).isActive = true
    schoolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    schoolLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    schoolLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    
    nameLable.topAnchor.constraint(equalTo: schoolLabel.bottomAnchor).isActive = true
    nameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    nameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    nameLable.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
