//
//  ContinentScrollView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//

import SwiftUI

struct ContinentScrollView: View {
    @ObservedObject var countriesDataModel = CountriesDataModel()
    @ObservedObject var regionsDataModel = RegionsDataModel()
    
//    let continents = ["Africa", "Asia", "Europe", "North America", "Oceania", "South America"]

        var body: some View {
            Text("Regions")
                    .font(.title3)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(regionsDataModel.regions) { region in
                        NavigationLink(destination: CountriesByRegionView(countriesDataModel: countriesDataModel, idRegionRequired: region.id)) {
                            Text(region.region)
                                            .padding()
                                            .frame(width: 100, height: 50)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .cornerRadius(10)
                                    }
                        
                    }
                }
                .padding(.horizontal)
            }
        }
}


#Preview {
    ContinentScrollView()
}
