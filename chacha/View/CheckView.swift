//
//  CheckView.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class CheckView: UIView {
  
  // MARK: - Properties
  
  private var state: ForCheckModel = ForCheck.shared.amICheck {
    willSet(new) {
      stateImageView.setImage(UIImage(named: new.imgName), for: .normal)
      stateLabel.text = new.text
    }
  }
  
  private var stateImageView: UIButton = {
    let imageView = UIButton()
    imageView.contentMode = .scaleAspectFit
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.addTarget(self, action: #selector(didTapStateImageView(_:)), for: .touchUpInside)
    return imageView
  }()
  
  private var stateLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupCheckView()
    didTapStateImageView(stateImageView)
    
  }
  
  @objc private func didTapStateImageView(_ sender: UIButton) {
    print("didTapStateImageView")
    print(ForCheck.shared.amICheck.text)
    state = ForCheck.shared.amICheck
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    stateImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stateImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    stateImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    stateImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    stateLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    stateLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    stateLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    stateLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
  }
  
  private func setupCheckView() {
    addSubview(nameLable)
    addSubview(schoolLabel)
    
    addSubview(stateImageView)
    addSubview(stateLabel)
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
