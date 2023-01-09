//
//  ContentView.swift
//  ChatMessageExample
//
//  Created by cano on 2023/01/09.
//

import SwiftUI

struct ContentView: View {
    
    @State var message = ""
    @State var imagePicker = false
    @State var imgData : Data = Data(count: 0)
    
    
    @StateObject var messageViewModel = MessageViewModel()
    
    var body: some View {
        
        VStack {
            
            ZStack {
                 
                HStack {
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    })
                    
                    Spacer()
                    
                    Button(action: {}, label: {
                        
                        Image(systemName: "gear")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    })
                }
                
                VStack(spacing: 5){
                    
                    Text("Catherine")
                        .fontWeight(.bold)
        
                    Text("Active")
                        .font(.caption)
                }
                .foregroundColor(.white)
            }
            .padding(.all)
            
            VStack{
                
                // Displaying Message....
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    
                    ScrollViewReader { reader in
                        
                        VStack(spacing: 20){
                            
                            ForEach(messageViewModel.messages){msg in
                                
                                // Chat Bubbles...
                                
                                ChatBubble(msg: msg)
                            }
                            // when ever a new data is inserted scroll to bottom...
                            
                            .onChange(of: messageViewModel.messages) { (value) in
                                
                                // scrolling only user message...
                                
                                if value.last!.myMsg{
                                    reader.scrollTo(value.last?.id)
                                }
                            }
                        }
                        .padding([.horizontal,.bottom])
                        .padding(.top, 25)
                    }
                })
                
                HStack(spacing: 15){
                    
                    HStack(spacing: 15){
                        
                        TextField("Message", text: self.$message)
                        
                        Button(action: {
                            
                            // toogling image picker...
                            
                            imagePicker.toggle()
                            
                        }, label: {
                            
                            Image(systemName: "paperclip.circle.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.gray)
                        })
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.black.opacity(0.06))
                    .clipShape(Capsule())
                    
                    // Send Button...
                    
                    if message != ""{
                        
                        Button(action: {
                            
                            // appeding message...
                            // adding animation...
                            
                            //withAnimation(.easeOut){
                                messageViewModel.messages.append(Message(id: Date(), message: message, myMsg: true, profilePic: "p1", photo: nil))
                            //}
                            
                            message = ""
                            
                        }, label: {
                            
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: 22))
                                .foregroundColor(Color("Color"))
                                // rotating the image...
                                .rotationEffect(.init(degrees: 45))
                                // adjusting padding shape...
                                .padding(.vertical,12)
                                .padding(.leading,12)
                                .padding(.trailing,17)
                                .background(Color.black.opacity(0.07))
                                .clipShape(Circle())
                        })
                    }
                }
                .padding(.horizontal)
                .animation(.easeOut, value: false)
            }
            .padding(.bottom, (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.safeAreaInsets.bottom)
            .background(Color.white.clipShape(RoundedShape()))
            
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color("Color").edgesIgnoringSafeArea(.top))
        // Full Screen Image Picker...
        .fullScreenCover(isPresented: self.$imagePicker, onDismiss: {
            
            // when ever image picker closes...
            // verifying if image is selected or cancelled...
            
            if self.imgData.count != 0 {
                messageViewModel.writeMessage(id: Date(), msg: "", photo: self.imgData, myMsg: true, profilePic: "p1")
            }
            
        }) {
            
            ImagePicker(imagePicker: self.$imagePicker, imgData: self.$imgData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
