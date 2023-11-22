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
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel

        var body: some View {
            VStack{
                Text("Regions")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 5)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(regionsDataModel.regions) { region in
                            NavigationLink(destination: CountriesByRegionView(countriesDataModel: countriesDataModel, regionsDataModel: regionsDataModel, favoritesManagerModel: favoritesManagerModel, idRegionRequired: region.id)) {
                                    Text(region.region)
                                        .padding()
                                        .frame(width: 140, height: 60)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .font(.subheadline)
                                }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.leading)
        }
}

#Preview {
    ContinentScrollView(favoritesManagerModel: FavoritesManagerModel())
}
