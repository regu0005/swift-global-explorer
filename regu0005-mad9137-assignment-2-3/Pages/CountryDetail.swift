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
    @State private var isMapFullscreen = false
    @State private var isMainImageLoaded = false
    @State private var imageOpacity = 0.0
    @ObservedObject var favoritesManagerModel: FavoritesManagerModel

    
    var country: PostCountry
    let countriesDataModel: CountriesDataModel
//    let favoritesManagerModel: FavoritesManagerModel
    

    public var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    
                    if(!isMainImageLoaded) {
                        ProgressView("...")
                            .font(.headline)
                            .bold()
                    }
                    
                    AsyncImage(url: URL(string: country.image ?? "")) { phase in
                        
                        switch phase {
                        case .empty:
//                            ProgressView("...")
//                                .font(.headline)
//                                .bold()
                            Image("world_default")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .opacity(imageOpacity)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 0.5)) {
                                        imageOpacity = 1.0
                                        isMainImageLoaded = true
                                    }
                                }
                        case .failure:
                            Image("world_default")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                            
                        @unknown default:
                            //<#fatalError()#>
                            Image("world_default")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 260)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            
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
                            
                            NavigationLink(destination: TopCountriesLanguageView(favoritesManagerModel: favoritesManagerModel,
                                                                                 topCountries: countriesDataModel.topCountriesSpeakingLanguage(worldwide: language.idLanguage), countriesDataModel: countriesDataModel, languageName: language.language)) {
                                
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
                            ZStack(alignment: .topTrailing) {
                                let markerName = country.name + " - " + country.capital
//                                MapView(coordinate: capitalCoordinate, capitalName: country.capital)
                                MapView(coordinate: capitalCoordinate, capitalName: markerName)
                                .frame(height: isMapFullscreen ? UIScreen.main.bounds.height : 200)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                .id("mapView")
                                
                                Button(action: {
                                    //withAnimation {
                                        isMapFullscreen.toggle()
                                        if isMapFullscreen {
                                            scrollViewProxy.scrollTo("mapView", anchor: .top)
                                        }
                                    //}
                                }) {
                                    Image(systemName: isMapFullscreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                                        .padding()
                                        .background(Color.white.opacity(0.7))
                                        .clipShape(Circle())
                                }
                                .padding(.trailing, 20)
                                .padding(.top, 20)
                            } // End ZStack
                            
                        } else {
                            Text("Map coordinates not available.")
                                .frame(height: 200)
                            
                        }
                }
                .edgesIgnoringSafeArea(isMapFullscreen ? .all : .init())
                
                VStack {
                    Text("Gallery")
                        .font(.title3)
                        .bold()
                        .padding(.top,10)
                        .padding(.leading, 22)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("...")
                }
            }
        }
    }
}

//#Preview {
//    CountryDetail(country: <#PostCountry#>)
//}

//struct CountryDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        let exampleCountry = PostCountry(
//            id: 1,
//            name: "Country demo",
//            image: nil,
//            flag: "https://tusmodelos.com/images/placeholder.jpg",
//            capital: "Capital demo",
//            population: 123456,
//            region: "EjemploRegión",
//            area: 78910,
//            latitude: nil,
//            longitude: nil,
//            urlMap: nil,
//            idRegion: nil,
//            languages: [Language(idLanguage: 1, language: "Language demo")]
//        )
//        CountryDetail(country: exampleCountry, countriesDataModel: CountriesDataModel(), favoritesManagerModel: FavoritesManagerModel())
//    }
//}
