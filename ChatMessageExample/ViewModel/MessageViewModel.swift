//
//  MessageViewModel.swift
//  ChatMessageExample
//
//  Created by cano on 2023/01/09.
//

import SwiftUI

class MessageViewModel : ObservableObject {
    
    @Published var messages : [Message] = []
    
    // sample data...
    
    init() {
        
        let strings = ["Hii","Hello !!!!","What's Up, What Are You Doing ???","Nothing Just Simply Enjoying Quarintine Holidays..You???","Same :))","Ohhhhh","What About Your Country ???","Very Very Bad...","Ok Be Safe","Bye....","Ok...."]
        
        //simple logic for two side messages
        
        for i in 0 ..< strings.count {
            messages.append(Message(id: Date(), message: strings[i], myMsg: i % 2 == 0 ? true : false, profilePic: i % 2 == 0 ? "p1" : "p2"))
        }
    }
    
    func writeMessage(id: Date,msg: String,photo: Data?,myMsg: Bool,profilePic: String) {
        
        messages.append(Message(id: id, message: msg, myMsg: myMsg, profilePic: profilePic, photo: photo))
    }
}


