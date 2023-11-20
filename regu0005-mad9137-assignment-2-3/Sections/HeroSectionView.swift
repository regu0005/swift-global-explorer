//
//  HeroSectionView.swift
//  CountryInformation
//
//  Created by Gustavo Reguerin on 2023-11-14.
//

import SwiftUI

struct HeroSectionView: View {
    @ObservedObject var countriesDataModel: CountriesDataModel
    
    var body: some View {
//        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Image("home_world_03")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .clipped()
                
                NavigationLink(destination: CountriesGeneralListView(countriesDataModel: countriesDataModel)) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 30))
                        .padding(16)
                        .foregroundColor(.white)
                }
                .padding(.top, 44)
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
//        }
    }
//        VStack(alignment: .leading, spacing: 10) {
////            Image("home_world_01")
////                    .resizable()
////                    .aspectRatio(contentMode: .fill)
////                    .edgesIgnoringSafeArea(.all)
//                    Image("home_world_03")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(height: 250)
//                        .clipped()
////                        .cornerRadius(10)
////                        .padding(.horizontal)
////                        .edgesIgnoringSafeArea(.all)
//
//                    Button(action: {
//                        
//                    }) {
//                        Image(systemName: "search")
//                            .font(.system(size: 30))
//                            .padding(.top, 190)
//                            .padding(.trailing, 10)
//                            .padding(.trailing)
//                    }
//            
//                    Text("Explore the World")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(.horizontal)
//
//                    Text("Discover information about countries, continents, and more.")
//                        .font(.body)
//                        .foregroundColor(.secondary)
//                        .padding(.horizontal)
//        }
//    }
}

#Preview {
    HeroSectionView(countriesDataModel: CountriesDataModel())
}
