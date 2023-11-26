//
//  HeroSectionView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//

import SwiftUI

// Share: Photo Identifiable
struct Photo: Identifiable {
    var id = UUID()
    var img: Image
    var caption: String
    var subject: String
    var description: String
}


extension Photo: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.img)
    }
}
// End Share: Photo Identifiable

struct HeroSectionView: View {
    @ObservedObject var countriesDataModel: CountriesDataModel
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    
    @State private var photo = Photo(img: Image("home_world_03"), caption: "World Countries App", subject: "World Countries App", description: "Discover information about countries, continents, and more.")
    
    var networkMonitor: NetworkMonitor
    
    var body: some View {
        
            ZStack(alignment: .topTrailing) {
                Image("home_world_03")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                
                ShareLink(
                    Text("Share"),
                    item: photo,
                    subject: Text(photo.subject),
                    message: Text(photo.description),
                    preview: SharePreview(Text(photo.caption), image: photo.img)
                )
                .font(.system(size: 16))
                .padding(.trailing, 20)
                .padding(.top, 214)
                .padding(.horizontal,14)
                .foregroundColor(.white)
                
                NavigationLink(destination: FavoritesView(favoritesManagerModel: favoritesManagerModel, countriesDataModel: countriesDataModel, networkMonitor: networkMonitor)) {
                    Image(systemName: "heart")
                        .font(.system(size: 30))
                        .padding(.horizontal, 70)
                        .foregroundColor(.white)
                }
                .padding(.top, 54)
                .padding(.horizontal,28)
                NavigationLink(destination: CountriesGeneralListView(countriesDataModel: countriesDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor)) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 30))
                        .padding(.trailing, 20)
                        .foregroundColor(.white)
                }
                .padding(.top, 54)
                .padding(.horizontal,20)
                
                
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Explore the World")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.top,15)
                
                Text("Discover information about countries, continents, and more.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
            }
    }
}

#Preview {
    HeroSectionView(countriesDataModel: CountriesDataModel(), favoritesManagerModel: FavoritesManagerModel(), networkMonitor: NetworkMonitor())
}
