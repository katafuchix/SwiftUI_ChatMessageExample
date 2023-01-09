//
//  View+Extened.swift
//  ChatMessageExample
//
//  Created by cano on 2023/01/09.
//

import SwiftUI

struct RoundedShape : Shape {

    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}

struct BubbleArrow : Shape {

    var myMsg : Bool
    
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: myMsg ?  [.topLeft,.bottomLeft,.bottomRight] : [.topRight,.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}

struct ChatBubble : View {

    var msg : Message
    
    var body: some View{
        
        // Automatic scroll To Bottom...
        // First Assigning Id To Each Row...
        
        HStack(alignment: .top,spacing: 10){
            
            if msg.myMsg{
                
                // pushing msg to left...
                // minimum space ...
                // Modifying for Image...
                
                Spacer(minLength: 25)
                

                if msg.photo == nil{
                    
                    Text(msg.message)
                        .padding(.all)
                        .background(Color.black.opacity(0.06))
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                }
                else {
                    
                    Image(uiImage: UIImage(data: msg.photo!)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 150, height: 150)
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                }
                
                // profile Image...
                
                Image(msg.profilePic)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            }
            
            else {
                
                // pushing msg to right...
                // profile Image...
                
                Image(msg.profilePic)
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                
                if msg.photo == nil{
                    
                    Text(msg.message)
                        .foregroundColor(.white)
                        .padding(.all)
                        .background(Color("Color"))
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                }
                else {
                    
                    Image(uiImage: UIImage(data: msg.photo!)!)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width - 150, height: 150)
                        .clipShape(BubbleArrow(myMsg: msg.myMsg))
                }
                
                
                Spacer(minLength: 25)
            }
        }
        .id(msg.id)
    }
}
