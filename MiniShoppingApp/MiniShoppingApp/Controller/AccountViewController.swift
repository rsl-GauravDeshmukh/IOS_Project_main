//
//  AccountViewController.swift
//  rootTabVC
//
//  Created by Gaurav Deshmukh on 30/03/23.
//

import UIKit

class AccountViewController: UIViewController {

    let customView = AccountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customView)
        setCustomViewConstraints()
        setNavBar()
        
    }
    
    private func setCustomViewConstraints() {
        customView.translatesAutoresizingMaskIntoConstraints = false
                
        let height = navigationController?.navigationBar.frame.height ?? 0
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: height-25),
            customView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setNavBar() {
        title = "Account"
        navigationController?.navigationBar.backgroundColor = .systemTeal
        view.backgroundColor = .white
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
