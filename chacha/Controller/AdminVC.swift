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
  let detailAdminVC = DetailAdminVC()
  
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
  func didTapStudentList() {
    Firebase.shared.getStudentList(){
      let data = $0.filter { $0.isAdmin == "0" }
      self.detailAdminVC.cellArr = data
      self.present(self.detailAdminVC, animated: true)
    }
  }
  
  func moveToAddBeaconVC() {
    present(AddBeaconVC(), animated: true)
  }
  
  func getAdminTableView() {
    Firebase.shared.getStudentList(){
      let data = $0.filter { $0.isAdmin == "0" }
      self.detailAdminVC.cellArr = data
      self.detailAdminVC.adminState = true
      self.present(self.detailAdminVC, animated: true)
    }
    
  }
  
  
}
