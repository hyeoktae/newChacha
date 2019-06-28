//
//  AdminVC.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class AdminVC: UIViewController {
  
  let adminView = AdminView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    adminView.delegate = self
    setupAdminView()
  }
  
  private func setupAdminView() {
    view.addSubview(adminView)
    
    let guide = view.safeAreaLayoutGuide
    adminView.translatesAutoresizingMaskIntoConstraints = false
    adminView.centerYAnchor.constraint(equalTo: guide.centerYAnchor).isActive = true
    adminView.widthAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
    adminView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.8).isActive = true
    
    
  }
}


extension AdminVC: AdminViewDelegate {
  func moveToAddBeaconVC() {
    present(AddBeaconVC(), animated: true)
  }
  
  func getAdminTableView(_ sender: UIButton) {
    let detailAdminVC = DetailAdminVC()
    let detailAdminNavi = UINavigationController(rootViewController: detailAdminVC)
    if sender.tag == 0 {
      detailAdminVC.title = "스쿨관리"
    } else if sender.tag == 1 {
      detailAdminVC.title = "학생관리"
    } else if sender.tag == 2 {
      detailAdminVC.title = "관리자"
    }
    present(detailAdminNavi, animated: true)
  }
  
  
}
