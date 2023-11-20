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
    @StateObject var regionsDataModel = RegionsDataModel()
    
    var body: some View {

        NavigationView {
            VStack {
                ScrollView {
                    HeroSectionView(countriesDataModel: countriesDataModel)
                    ContinentScrollView(countriesDataModel: countriesDataModel, regionsDataModel: regionsDataModel)
                    PopulatedCountriesView(countriesDataModel: countriesDataModel)
                    LargestCountriesView(countriesDataModel: countriesDataModel)
                    FlagsCollectionView()
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
//            .padding(.horizontal, 30)
            .navigationBarTitle("Countries Home", displayMode: .inline)
//            .navigationBarItems(trailing: BottomBarMenu())
            .navigationBarHidden(true)
//                        .overlay(
//                            VStack {
//                                Spacer()
//                                HStack {
//                                    Spacer()
//                                    BottomBarMenu()
//                                }
//                                .padding()
//                            }
////                            .background(systemMaterialDark)
//                        )
                        .onAppear {
                            // Testing data
                            //print(countriesDataModel.countries)
                        }
            } // End NavigationView
    }
}

#Preview {
    ContentView()
}
