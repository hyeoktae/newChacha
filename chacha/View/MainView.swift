//
//  MainView.swift
//  Chacha
//
//  Created by hyeoktae kwon on 2019/06/25.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

protocol MainViewDelegate: class {
  //출결현황 버튼 누를 시 실행할 메소드
  func attendCheck()
  
  //설정 버튼 누를 시 실행할 메소드
  func setting()
}


final class MainView: UIView {
  
  var delegate: MainViewDelegate?
  
  // MARK: - Properties
 
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
  
  private let attendButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("출결현황", for: .normal)
    button.backgroundColor = .red
    button.tintColor = .white
    button.addTarget(self, action: #selector(didTapAttendButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let settingButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("설정", for: .normal)
    button.backgroundColor = .blue
    button.tintColor = .white
    button.addTarget(self, action: #selector(didTapSettingButton(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupMainView()
//    let fontSize = UIFont.boldSystemFont(ofSize: 30)
//    let attributedStr = NSMutableAttributedString(string: myName)
//    attributedStr.addAttribute(kCTFontAttributeName as String, value: fontSize, range: (text as NSString).range(of: "님"))
  }
  
  private func setupMainView() {
    addSubview(schoolLabel)
    addSubview(nameLable)
    
    addSubview(attendButton)
    addSubview(settingButton)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    schoolLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    schoolLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    schoolLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    schoolLabel.bottomAnchor.constraint(equalTo: nameLable.topAnchor).isActive = true
    schoolLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
    
    nameLable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
    nameLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    nameLable.bottomAnchor.constraint(equalTo: attendButton.topAnchor, constant: -100).isActive = true
    nameLable.heightAnchor.constraint(equalTo: schoolLabel.heightAnchor).isActive = true
    
    attendButton.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    attendButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor).isActive = true
    attendButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    attendButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
    attendButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
    
    settingButton.topAnchor.constraint(equalTo: attendButton.topAnchor).isActive = true
    settingButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    settingButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    settingButton.widthAnchor.constraint(equalTo: attendButton.widthAnchor).isActive = true
    settingButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
  }
  
  @objc private func didTapAttendButton(_ sender: UIButton) {
    delegate?.attendCheck()
  }
  
  @objc private func didTapSettingButton(_ sender: UIButton) {
    delegate?.setting()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
