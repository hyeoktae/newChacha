//
//  DetailAdminVC.swift
//  Chacha
//
//  Created by 차수연 on 26/06/2019.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

class DetailAdminVC: UIViewController {
  
//  private let reloadBtn: UIButton = {
//    let btn = UIButton(type: .system)
//    btn.translatesAutoresizingMaskIntoConstraints = false
//    btn.setTitle("새로고침", for: .normal)
//    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//    btn.addTarget(self, action: #selector(didTapReloadBtn(_:)), for: .touchUpInside)
//    btn.layer.borderWidth = 1
//    return btn
//  }()
  
//  private let popBtn: UIButton = {
//    let btn = UIButton(type: .system)
//    btn.translatesAutoresizingMaskIntoConstraints = false
//    btn.setTitle("뒤로가기", for: .normal)
//    btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
//    btn.addTarget(self, action: #selector(didTapPopBtn(_:)), for: .touchUpInside)
//    btn.layer.borderWidth = 1
//    return btn
//  }()
  
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    return tableView
  }()
  
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let leftButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(didTapPopBtn(_:)))
    let rightButton = UIBarButtonItem(image: UIImage(named: "reload"), style: .plain, target: self, action: #selector(didTapReloadBtn(_:)))
    
    self.navigationItem.setLeftBarButton(leftButton, animated: true)
    self.navigationItem.setRightBarButton(rightButton, animated: true)
    
    view.backgroundColor = .white
    setupLayout()
  }
  
  @objc private func didTapPopBtn(_ sender: UIButton) {
    dismiss(animated: true)
  }
  
  @objc private func didTapReloadBtn(_ sender: UIButton) {
    tableView.reloadData()
  }
  
  private func setupLayout() {
    view.addSubview(tableView)
//    view.addSubview(popBtn)
//    view.addSubview(reloadBtn)
    
    let guide = view.safeAreaLayoutGuide
    
//    reloadBtn.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
//    reloadBtn.leadingAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    
//    popBtn.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
//    popBtn.trailingAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
    
    tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
    tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
  }
}

//extension DetailAdminVC: UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    ()
//  }
//  
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    ()
//  }
//}
