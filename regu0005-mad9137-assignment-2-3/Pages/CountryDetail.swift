//
//  CountryDetail.swift
//  regu0005-mad9137-assignment-2-3
//
//  Created by Gustavo Reguerin on 2023-11-17.
//
import SwiftUI
import SVGKit
import MapKit

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D
    var capitalName: String

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = capitalName
        uiView.addAnnotation(annotation)
    }
}

public struct CountryDetail: View {
    @State var isFavorite: Bool = false
//    @ObservedObject var favoritesManagerModel: FavoritesManagerModel
    
    var country: PostCountry
    let countriesDataModel: CountriesDataModel
    let favoritesManagerModel: FavoritesManagerModel
    

    public var body: some View {
        
        ScrollView {
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                AsyncImage(url: URL(string: country.image ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            Image("world_default")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                        }
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 260)
                        .clipped()
                        .edgesIgnoringSafeArea(.all)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)

//                        Button(action: {
//                            isFavorite.toggle()
//                        }) {
//                            Image(systemName: isFavorite ? "heart.fill" : "heart")
//                                .foregroundColor(isFavorite ? .red : .gray)
//                                .font(.system(size: 30))
//                                .padding(.top, 190)
//                                .padding(.trailing, 10)
//                                .padding(.trailing)
//                        }
                
//                        Button(action: toggleFavorite) {
//                            Image(systemName: isFavorite ? "heart.fill" : "heart")
//                                .font(.system(size: 30))
//                                .foregroundColor(.red)
//                        }
//                        .padding()
//                        .onAppear {
//                            // Check if the country is already a favorite
//                            isFavorite = checkIfFavorite()
//                        }
                
                            Button(action: {
                                favoritesManagerModel.toggleFavorite(countryID: country.id)
                            }) {
                                Image(systemName: favoritesManagerModel.favorites[country.id, default: false] ? "heart.fill" : "heart")
                                    .foregroundColor(.red)
                                    .font(.system(size: 30))
                                    .padding(.top, 190)
                                    .padding(.trailing, 10)
                                    .padding(.trailing)
                            }
                
            }
            .frame(maxWidth: .infinity, maxHeight: 260)
            
            Text(country.name)
                    .font(.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 5)
            HStack {
                Text("Capital:")
                        .font(Font.system(size: 20))
                        .frame(maxWidth: 100, alignment: .leading)
                        .padding(.top,1)
                        .padding(.leading,30)
                        .foregroundColor(.gray)
                Text("\(country.capital)")
                        .font(Font.system(size: 20))
                        .frame(alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top,1)
                        .foregroundColor(.gray)
                Spacer()
            }
            HStack {
                Text("Population:")
                        .font(Font.system(size: 18))
                        .frame(maxWidth: 100, alignment: .leading)
                        .padding(.top,1)
                        .padding(.leading,30)
                        .foregroundColor(.gray)
                Text("\(country.population)")
                        .font(Font.system(size: 18))
                        .frame(alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top,1)
                        .foregroundColor(.gray)
                Spacer()
            }
            HStack {
                Text("Area:")
                        .font(Font.system(size: 18))
                        .frame(maxWidth: 100, alignment: .leading)
                        .padding(.top,1)
                        .padding(.leading,30)
                        .foregroundColor(.gray)
                Text("\(country.area) km2")
                        .font(Font.system(size: 18))
                        .frame(alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top,1)
                        .foregroundColor(.gray)
                Spacer()
            }
            HStack{
                Text(country.shortDescription ?? " ")
                    .padding(.top,8)
                    .padding(.horizontal)
            }
            VStack {
                Text("Languages")
                    .font(.title3)
                    .bold()
                    .padding(.top,10)
                    .padding(.leading, 22)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack(alignment: .top, spacing: 20) {
                    ForEach(country.languages, id: \.idLanguage) { language in
                        
                        NavigationLink(destination: TopCountriesLanguageView(
                            topCountries: countriesDataModel.topCountriesSpeakingLanguage(worldwide: language.idLanguage), languageName: language.language)) {
                            
                            HStack(spacing: 8) {
                                Text(language.language)
                                    .font(Font.custom("Inter", size: 16))
                                    .lineSpacing(24)
                                    .foregroundColor(Color(red: 0.10, green: 0.13, blue: 0.17))
                            }
                            .frame(width: 126, height: 38)
                            .background(Color(red: 0.89, green: 0.91, blue: 0.94))
                            .cornerRadius(6)
                            
                        }
                        
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                .frame(maxWidth: .infinity)
            }
            VStack {
                Text("Flag")
                    .font(.title3)
                    .bold()
                    .padding(.top,10)
                    .padding(.leading, 22)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // VALIDATION FLAG: SVG OR (PNG, JPEG, JPEG)
                if country.flag.lowercased().hasSuffix(".svg")
                {
                    // Display SVG using SVGImageView
                    SVGImageView(url: URL(string: country.flag) ?? URL(string: "https://tusmodelos.com/images/placeholder.jpg")!)
                        .frame(width: 220, height: 130)
                        .cornerRadius(10)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                else {
                    // Display other image formats using AsyncImage
                    AsyncImage(url: URL(string: country.flag) ?? URL(string: "https://tusmodelos.com/images/placeholder.jpg")!) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 220, height: 130)
                    .cornerRadius(10)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                // END VALIDATION FLAG: SVG OR (PNG, JPEG, JPEG)
                
            }
            VStack {
                Text("Capital Location")
                    .font(.title3)
                    .bold()
                    .padding(.top,10)
                    .padding(.leading, 22)
                    .frame(maxWidth: .infinity, alignment: .leading)    
                if let latitude = Double(country.latitude ?? ""), let longitude = Double(country.longitude ?? "") {
                        let capitalCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        MapView(coordinate: capitalCoordinate, capitalName: country.capital)
                        .frame(height: 200)
                        .shadow(color: .gray, radius: 5, x: 0, y: -5)
//                        .padding(.horizontal,30)
                        
                    } else {
                        Text("Map coordinates not available.")
                            .frame(height: 200)
//                            .padding(.horizontal,30)
                        
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
//        .navigationBarTitle("Country Detail", displayMode: .inline)
        
    }
    
//    private func toggleFavorite() {
//            if isFavorite {
//                removeFavorite()
//            } else {
//                addFavorite()
//            }
//            isFavorite.toggle()
//        }
//
//    private func checkIfFavorite() -> Bool {
//        // Implement logic to check if the country is already a favorite
//        // Example: UserDefaults.standard.bool(forKey: country.id)
//    }
//
//    private func addFavorite() {
//        // Implement logic to add the country to favorites
//        // Example: UserDefaults.standard.set(true, forKey: country.id)
//    }
//
//    private func removeFavorite() {
//        // Implement logic to remove the country from favorites
//        // Example: UserDefaults.standard.set(false, forKey: country.id)
//    }
}

//#Preview {
//    CountryDetail(country: <#PostCountry#>)
//}

struct CountryDetail_Previews: PreviewProvider {
    static var previews: some View {
        let exampleCountry = PostCountry(
            id: 1,
            name: "Country demo",
            image: nil,
            flag: "https://tusmodelos.com/images/placeholder.jpg",
            capital: "Capital demo",
            population: 123456,
            region: "EjemploRegión",
            area: 78910,
            latitude: nil,
            longitude: nil,
            urlMap: nil,
            idRegion: nil,
            languages: [Language(idLanguage: 1, language: "Language demo")]
        )
        CountryDetail(country: exampleCountry, countriesDataModel: CountriesDataModel(), favoritesManagerModel: FavoritesManagerModel())
    }
}
