//
//  ContentView.swift
//  Kamera
//
//  Created by Lian Lin on 2024/3/4.
//

import SwiftUI
import ImageIO
import CoreServices

struct ContentView: View {
    @StateObject private var model = frameHandler()
    
    var body: some View {
        ZStack{
            frameView(image: model.frame)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Button(action: {
                    /*
                        Save image to Document
                     */
                    let photo = model.frame != nil ? model.frame : nil
                    if photo != nil{
                        print("Taking picture ... ")
                        let fileMngr = fileManager()
                        let imgDst = CGImageDestinationCreateWithURL(fileMngr.genFileUrl() as CFURL, kUTTypePNG, 1, nil)
                        CGImageDestinationAddImage(imgDst!, photo!, nil)
                        CGImageDestinationFinalize(imgDst!)
                    }
                }, label: {
                    Image(systemName: "camera.aperture")
                        .resizable()
                        .frame(width: 50, height: 50)
                })
                .zIndex(1)
            }
        }
    }
}

#Preview {
    ContentView()
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
