//
//  ContentView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//

import SwiftUI
import SVGKit

// The follow struct is used with every View that call an svg image
struct SVGImageView: UIViewRepresentable {
    var url: URL
    var networkMonitor: NetworkMonitor

    func makeUIView(context: Context) -> SVGKFastImageView {
        let svgImageView = SVGKFastImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        return svgImageView
    }

    func updateUIView(_ uiView: SVGKFastImageView, context: Context) {
        // Load the image from URL
        DispatchQueue.global().async {
            print("Attempting to load SVG from URL: \(self.url)")
            
            if networkMonitor.isConnected {
                if let svgImage = SVGKImage(contentsOf: self.url) {
                    DispatchQueue.main.async {
                        uiView.image = svgImage
                    }
                }
            }
//            else {
//                print("Network not connected, skipping SVG load")
//            }
        }
    }
}

struct ContentView: View {
    @StateObject var countriesDataModel = CountriesDataModel()
    @StateObject var regionsDataModel = RegionsDataModel()
    @StateObject var favoritesManagerModel = FavoritesManagerModel()
    
    @EnvironmentObject var networkMonitor: NetworkMonitor

    
    var body: some View {
        
        NavigationView {
            if(countriesDataModel.isLoading) {
                ProgressView("Loading...")
                    .font(.headline)
                    .bold()
            }
            else {
                VStack {
                    ScrollView {
                        HeroSectionView(countriesDataModel: countriesDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor)
                        ContinentScrollView(countriesDataModel: countriesDataModel, regionsDataModel: regionsDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor)
                        PopulatedCountriesView(countriesDataModel: countriesDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor)
                        LargestCountriesView(countriesDataModel: countriesDataModel, favoritesManagerModel: favoritesManagerModel, networkMonitor: networkMonitor)
                        // FlagsCollectionView()
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitle("Countries Home", displayMode: .inline)
                .navigationBarHidden(true)
            }
            
        } // End NavigationView
    }
}

#Preview {
    ContentView()
}
