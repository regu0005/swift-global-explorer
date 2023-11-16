//
//  ContentView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
                
        NavigationView {
            VStack {
                ScrollView {
                    HeroSectionView()
                    ContinentScrollView()
                            PopulatedCountriesView()
                    CountriesListView()
                    //PopulatedCountriesView(country: exampleCountry)
                    FlagsCollectionView()
                    Spacer()
                }
            }
            .navigationBarTitle("Countries Info", displayMode: .inline)
            .navigationBarItems(trailing: BottomBarMenu())
        }
    }
}

#Preview {
    ContentView()
}
