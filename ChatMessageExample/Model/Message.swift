//
//  Message.swift
//  ChatMessageExample
//
//  Created by cano on 2023/01/09.
//

import SwiftUI

struct Message : Identifiable, Equatable{
    var id : Date
    var message : String
    var myMsg : Bool
    var profilePic : String
    var photo: Data?
}
