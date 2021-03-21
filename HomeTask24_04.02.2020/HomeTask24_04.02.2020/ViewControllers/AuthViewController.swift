//
//  AuthViewController.swift
//  HomeTask24_04.02.2020
//
//  Created by MAKABOND on 6.02.21.
//

import UIKit

class AuthViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var hidenLable: UILabel!
    @IBOutlet weak var usernameTextFild: UITextField!
    @IBOutlet weak var userPasswordTextFild: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Life Cycle VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAuthUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(
                                                self.sendDataWithObserver(notification:)
                                                ),
                                               name: .userDataWasUpdated,
                                               object: nil)
    }
    
    // MARK: - Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let statusVC = UIStoryboard(name: "Status",
                                       bundle: nil).instantiateViewController(
                                        identifier: "StatusViewController"
                                       ) as? StatusViewController {
            
            guard self.usernameTextFild.text?.isEmpty != true,
                  self.userPasswordTextFild.text?.isEmpty != true else {
                return AlertHelper.shared.show(for: self,
                                               title: "Empty user data",
                                               message: "Please, enter your name and password",
                                               rightBittonTitle: "Ok",
                                               actionStyle: .default,
                                               rightBittonAction: nil) }
            
            statusVC.modalPresentationStyle = .fullScreen
            
            statusVC.usernameText = self.usernameTextFild.text
            
            if let password = self.userPasswordTextFild.text {
                statusVC.setPassword(password: password)
            }
            
            statusVC.delegate = self
            
            statusVC.action = { [weak self] status, name in
                guard let self = self else { return }
                self.hidenLable.isHidden = false
                switch status {
                case .confirmed:
                    self.hidenLable.text = "Velcome \(name)!"
                    self.hidenLable.tintColor = .blue
                default:
                    self.hidenLable.text = "Error"
                    self.hidenLable.tintColor = .orange
                }
            }
            
            present(statusVC, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Methods
    
    @objc private func sendDataWithObserver(notification: Notification) {
        if let userStatus = notification.userInfo {
            if userStatus["UserStatus"] as! String == "confirmed" {
                print("вы вошли")
                AlertHelper.shared.show(for: self,
                                        title: "You are logined",
                                        message: "",
                                        rightBittonTitle: "Ok",
                                        actionStyle: .default,
                                        rightBittonAction: nil)
            } else {
                print("вы не вошли")
                AlertHelper.shared.show(for: self,
                                        title: "Error",
                                        message: "You are not logined",
                                        rightBittonTitle: "Ok",
                                        actionStyle: .default,
                                        rightBittonAction: nil)
            }
        }
    }
    
    private func setupAuthUI() {
        self.view.backgroundColor = .gray
        self.hidenLable.isHidden = true
        
        self.usernameTextFild.placeholder = "Enter your name"
        self.usernameTextFild.clearButtonMode = .whileEditing
        
        self.userPasswordTextFild.placeholder = "Enter your password"
        self.userPasswordTextFild.clearButtonMode = .whileEditing
        self.userPasswordTextFild.isSecureTextEntry = true
        
        self.loginButton.layer.cornerRadius = 5
        self.loginButton.backgroundColor = .systemBlue
        self.loginButton.setTitle("Logine", for: .normal)
        self.loginButton.setTitleColor(.white, for: .normal)
    }
}
