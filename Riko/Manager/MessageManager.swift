//
//  MessageManager.swift
//  Riko
//
//  Created by Yuki Yoshioka on 2017/03/04.
//  Copyright © 2017年 Yoshitaka Kazue. All rights reserved.
//

import Foundation

class MessageManager {
    
    static let sharedInstance : MessageManager = {
        let instance = MessageManager()
        return instance
    }()
    
    func setup() {
        FirebaseManager.sharedInstance.delegate = {(result) -> Void in
            guard let id = result.id, !RealmManager.sharedInstance.isExists(id: id) else {
                return
            }
            
            let message = Message()
            message.id = result.id
            message.body = result.body
            message.name = result.name
            message.date = result.date
            RealmManager.sharedInstance.add(message:message)
            
            NotificationCenter.default.post(name:NSNotification.Name(rawValue: "MessageRecieved"), object: message)
        }
    }
}
