//
//  CheckVC.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class CheckVC: UIViewController {
  
  var myUUID = UserDefaults.standard.string(forKey: "uuid")
  
  private let registerVC = RegisterVC()
  private let adminVC = AdminVC()
  
  let shared = Firebase.shared
  let checkView = CheckView()
  let topCheckView = TopCheckView()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    setupCheckView()
    
    print("checkVC_uuid: ", myUUID)
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    topCheckView.setupTopCheckView()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    //학생인지 관리자인지 체크
    firstRunApp()
  }
  
  // uuid 관리자이면 관리자 페이지 띄움
  private func firstRunApp() {
    guard let myUUID = myUUID else { return }
    shared.getAdminData(uuid: myUUID) {
      print("firstRunApp 에서: ", $0)
      guard $0 == "관리자" else { return }
      self.present(self.adminVC, animated: true)
    }
  }
  
  // StatusBar Style 화이트로 변경
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  private func setupCheckView() {
    view.addSubview(checkView)
    view.addSubview(topCheckView)
    
    let guide = view.safeAreaLayoutGuide
    
    topCheckView.translatesAutoresizingMaskIntoConstraints = false
    topCheckView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    topCheckView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    topCheckView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    topCheckView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.4).isActive = true
  
    checkView.translatesAutoresizingMaskIntoConstraints = false
    checkView.topAnchor.constraint(equalTo: topCheckView.bottomAnchor, constant: 100).isActive = true
    checkView.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    checkView.widthAnchor.constraint(equalTo: guide.widthAnchor, multiplier: 0.8).isActive = true
    checkView.heightAnchor.constraint(equalTo: guide.heightAnchor, multiplier: 0.3).isActive = true
  }
}
