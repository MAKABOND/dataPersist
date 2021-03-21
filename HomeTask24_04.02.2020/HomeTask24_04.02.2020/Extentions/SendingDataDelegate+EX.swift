//
//  SendingDataDelegate+EX.swift
//  HomeTask24_04.02.2020
//
//  Created by MAKABOND on 7.02.21.
//

import Foundation

extension AuthViewController: SendyngDataProtocol {
    func sendData(message: String) {
        switch message {
        case "confirmed":
            self.view.backgroundColor = .systemGreen
        default:
            self.view.backgroundColor = .red
        }
    }
}
