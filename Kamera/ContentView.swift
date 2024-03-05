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
    @State private var canDoOutput: Bool = true
    @StateObject private var model = frameHandler()
    
    var body: some View {
        ZStack{
            // - Passing frame to render
            // - Passing canDoOutput to determine whether to render or not
            frameView(image: model.frame, canDoOutput: model.canDoOutput)
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    // Button responsible for taking picture
                    var takePictureBtn = Button(action: {
                        // Save image to Document
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
                        .padding()
                    
                    // If camera is disabled, make button disabled too
                    canDoOutput ? takePictureBtn.disabled(false) : takePictureBtn.disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    
                    // Determine whether to enable the camera or not
                    var cameraEnableToggle = Toggle(isOn: $canDoOutput){
                        if canDoOutput {
                            Image(systemName: "camera.circle.fill")
                        }else{
                            Image(systemName: "camera.circle")
                        }
                    }
                    .font(.system(size: 30))
                    .toggleStyle(.button)
                    .clipShape(Circle())
                    .onChange(of: canDoOutput){ value in
                        model.updateCanDoOutputState(canDo: canDoOutput)
                    }
                    canDoOutput ? cameraEnableToggle.tint(.red) : cameraEnableToggle.tint(.green)
                }
                .frame(width: UIScreen.main.bounds.width)
                .background(.gray.opacity(0.5))
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .bottom)
        
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
