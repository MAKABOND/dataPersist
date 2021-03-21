//
//  AlertHelper.swift
//  HomeTask24_04.02.2020
//
//  Created by MAKABOND on 7.02.21.
//

import UIKit

class AlertHelper {
    
    // MARK: - Singelton
    
    static let shared = AlertHelper()
    
    // MARK: - Initialisators
    
    private init() { }
    
    // MARK: - Methods
    
    func show(for controller: UIViewController,
              title: String = "",
              message: String = "",
              rightBittonTitle: String = "",
              actionStyle: UIAlertAction.Style,
              rightBittonAction: (() -> Void)?) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: rightBittonTitle,
                                      style: actionStyle,
                                      handler: { (_) in
                                        rightBittonAction?()
                                      }))
        controller.present(alert, animated: true)
    }
}

// MARK: - Extention

extension AlertHelper: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
