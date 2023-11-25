//
//  SharingExamples.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-24.
//

import SwiftUI


// Share: Photo Identifiable
//struct Photo: Identifiable {
//    var id = UUID()
//    var uiImage: UIImage
//    var caption: String
//    var description: String
//
//    var imageData: Data? {
//        uiImage.jpegData(compressionQuality: 1.0)
//    }
//}

struct PhotoE: Identifiable {
    var id = UUID()
    var img: Image
    var caption: String
    var subject: String
    var description: String
}


//struct Photo: Identifiable {
//    var id = UUID()
//    var uiImage: UIImage //Image
//    var caption: String
//    var description: String
//}

extension PhotoE: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.img)
    }
}

//struct ShareableImage: Transferable {
//    let imageData: Data
//
//    static var transferRepresentation: some TransferRepresentation {
//        ProxyRepresentation(exporting: \.imageData)
//    }
//}

struct SharingExamples: View {
    
    @State private var photo = PhotoE(img: Image("home_world_03"), caption: "World Countries App", subject: "World Countries App", description: "Discover information about countries, continents, and more.")
    
//    @State private var photo = PhotoE(uiImage: UIImage(named: "home_world_03") ?? UIImage(), caption: "World Countries App", description: "Discover information about countries, continents, and more.")
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        
        // Share
//                        let photo = Image("home_world_03")
        
        
//                        ShareLink(item: PhotoE, subject: photo.caption, message: photo.description, preview: SharePreview(photo.caption, image: photo.image))
        
//                        ShareLink(item: PhotoE, preview: SharePreview(photo.caption, image: photo.image))
        
        ShareLink(
            item: photo,
            subject: Text(photo.caption),
            message: Text(photo.description),
            preview: SharePreview(Text(photo.caption), image: photo.img)
        )

        
        
//                        ShareLink(item: photo, subject: photo.caption, preview: SharePreview(photo.caption, image: Image(uiImage: photo.uiImage)), message: photo.description)

//                        if let imageData = photo.imageData {
//                            let shareableImage = ShareableImage(imageData: imageData)
//                            ShareLink(
//                                item: shareableImage,
//                                subject: Text(photo.caption),
//                                message: Text(photo.description),
//                                preview: SharePreview(Text(photo.caption), image: Image(uiImage: photo.uiImage))
//                            )
//                        }

        
//                        ShareLink(item: photo, preview: SharePreview("Big Ben", image: photo))
//
//
//                        ShareLink(item: URL(string: "https://google.com")!)
//                        ShareLink("MAD Website", item: "This is MAD WEBSITE")
//
//                        ShareLink(Text("\(Image(systemName: "graduationcap"))"), item: "String"
//                        )
//
//                        ShareLink("Item with subject and message", item: "Assignment due on Dex 15, 11:59 PM", subject: Text("Assignment due on Dex 15, 11:59 PM"), message: Text("This is a firendly reminder to submit your assignment on time"))
//                        Spacer()
    }
}

#Preview {
    SharingExamples()
}
