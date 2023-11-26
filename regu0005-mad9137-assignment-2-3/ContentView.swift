//
//  ContentView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//
//  Project - Additional Resources
//
//  Figma design:
//  https://www.figma.com/file/gZBCImnavOn29LMJpUtiuH/Countries-App?type=design&node-id=1%3A601&mode=dev
//
//  Admin System:
//  https://countries.tusmodelos.com
//  Test user:   test007
//  Password:    test007

import SwiftUI

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
