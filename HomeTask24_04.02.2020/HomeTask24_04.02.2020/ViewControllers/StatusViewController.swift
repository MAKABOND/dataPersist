//
//  StatusViewController.swift
//  HomeTask24_04.02.2020
//
//  Created by MAKABOND on 6.02.21.
//

import UIKit

class StatusViewController: UIViewController {
    
    // MARK: - Enums
    
    enum RegisterStatus: String {
        case confirmed, declined
    }
    
    // MARK: - Propertis
    
    private var userStatus: RegisterStatus {
        let summ = self.summOfSumbols
        switch summ {
        case 1...14:
            return .declined
        default:
            return .confirmed
        }
    }
    private var summOfSumbols: Int {
        guard let password = self.password,
              let name = self.usernameText else { return 0 }
        return password.count + name.count
    }
    
    private var password: String?
    weak var delegate: SendyngDataProtocol?
    var usernameText: String?
    var action: ((RegisterStatus, String) -> ())?
    
    // MARK: - Outlets
    
    @IBOutlet weak var centralLable: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: - Life Cycle VC
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.centralLable.text = self.usernameText
        setupStatusUI()
    }
    
    // MARK: - Actions
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
        self.delegate?.sendData(message: self.userStatus.rawValue)
        
        NotificationCenter.default.post(
            name: .userDataWasUpdated,
            object: nil,
            userInfo: ["UserStatus" : self.userStatus.rawValue])
        
        self.action?(self.userStatus, self.usernameText ?? "unknow name")
    }
    
    // MARK: - Methods
    
    func setPassword(password: String) {
        self.password = password
        
        if let password = self.password {
            print("password: \(password)")
        }
    }
    
    private func setupStatusUI() {
        self.closeButton.layer.cornerRadius = 5
        self.closeButton.backgroundColor = .systemOrange
        self.closeButton.setTitle("Close", for: .normal)
        self.closeButton.setTitleColor(.white, for: .normal)
    }
}


