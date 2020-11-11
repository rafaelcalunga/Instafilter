//
//  ContentView.swift
//  Instafilter
//
//  Created by Rafael Calunga on 2020-11-05.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .onAppear(perform: loadImage)
        .sheet(isPresented: $showingImagePicker, onDismiss: loadNewImage) {
            ImagePicker(image: $inputImage)
        }
    }
    
    func loadNewImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func loadImage() {
        //image = Image("quebec")
        
        guard let inputImage = UIImage(named: "quebec") else { return }
        let beginImage = CIImage(image: inputImage)
        
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1
        //currentFilter.scale = 50 pixellate()
        //currentFilter.radius = 200 //crystallize()
        guard let outputImage = currentFilter.outputImage else { return }
        
        let context = CIContext()
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiimg = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiimg)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
