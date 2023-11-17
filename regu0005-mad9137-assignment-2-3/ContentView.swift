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

    func makeUIView(context: Context) -> SVGKFastImageView {
        let svgImageView = SVGKFastImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
        return svgImageView
    }

    func updateUIView(_ uiView: SVGKFastImageView, context: Context) {
        // Load the image from URL
        DispatchQueue.global().async {
            if let svgImage = SVGKImage(contentsOf: self.url) {
                DispatchQueue.main.async {
                    uiView.image = svgImage
                }
            }
        }
    }
}

struct ContentView: View {
    @StateObject var countriesDataModel = CountriesDataModel()
    
    var body: some View {
                
        NavigationView {
            VStack {
                ScrollView {
                    HeroSectionView()
                    ContinentScrollView()
                    PopulatedCountriesView(countriesDataModel: countriesDataModel)
                    CountriesListView(countriesDataModel: countriesDataModel)
                    FlagsCollectionView()
                    Spacer()
                }
            }
            .navigationBarTitle("Countries Info", displayMode: .inline)
            .navigationBarItems(trailing: BottomBarMenu())
            .onAppear {
                // Testing data
                //print(countriesDataModel.countries)
            }
        }
    }
}

#Preview {
    ContentView()
}
