//
//  ContentView.swift
//  Kamera
//
//  Created by Lian Lin on 2024/3/4.
//

import SwiftUI
import ImageIO
import CoreServices

let fileMngr = fileManager()
<<<<<<< HEAD
var topTwoImages: Array<URL> = fileMngr.getTwoRecentImages()
=======
let sdbxPath = fileMngr.getSdbxDirPath()
var latestCGImage: CGImage?
>>>>>>> ,,`

struct ContentView: View {
    @State private var canDoOutput: Bool = true
    @State private var zoomTimes: CGFloat = 1.0
    @StateObject private var model = frameHandler()
//    @State var showImageViewer: Bool = true
    
    var body: some View {
        ZStack{
            // - Passing frame to render
            // - Passing canDoOutput to determine whether to render or not
            frameView(image: model.frame, canDoOutput: model.canDoOutput)
                .ignoresSafeArea()
            
            /*
                Top bar
             */
            VStack{
                HStack{
                    Text(" ")
                }
                .padding(.top, 40)
                .frame(width: UIScreen.main.bounds.width)
                .background(.black.opacity(0.9))
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .top)
            
            /*
                Bottom bar
             */
            VStack{
                /** Zoom bar  */
                HStack{
                    Spacer()
                    // x1
                    Button(action: {
                        zoomTimes = 1.0
                    }, label: {
                        Text("x1")
                    })
                    Spacer()
                    // x1.5
                    Button(action: {
                        zoomTimes = 1.5
                    }, label: {
                        Text("x1.5")
                    })
                    Spacer()
                    // x2
                    Button(action: {
                        zoomTimes = 2.0
                    }, label: {
                        Text("x2")
                    })
                    Spacer()
                }
                .fontWeight(.bold)
                .font(.system(.title3,design: .rounded))
                .foregroundColor(.white)

                /** Capture and toggle output  */
                HStack{
<<<<<<< HEAD
                    // Preview Frame
                    // Update the top two images everytime when the view update
                    let _ = {
                        topTwoImages = fileMngr.getTwoRecentImages()
                        print("Set top two")
                    }()
                    
                    
=======
                    // Preview picture
//                    VStack{
//                        Text("preview")
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .overlay(ImageViewer(image: latestCGImage!, viewerShown: self.$showImageViewer))
>>>>>>> ,,`
                    
                    // Button responsible for taking picture
                    var takePictureBtn = Button(action: {
                        // Save image to Document
                        let photo = model.frame != nil ? model.frame : nil
                        latestCGImage = photo
                        if photo != nil{
                            print("Taking picture ... ")
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
                    canDoOutput ? takePictureBtn.disabled(false) : takePictureBtn.disabled(true)
                    
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
                .padding(.top, 20)
                .frame(width: UIScreen.main.bounds.width)
                .background(.black.opacity(0.9))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        
        }
    }
}

//#Preview {
//    ContentView()
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
