import SwiftUI
import MapKit



struct ContentView: View {
    @StateObject private var viewModel = AnotherViewModel()
    @State var name = "Pizza Place"
    @State var latitude: Double = 50.0
    @State var longitude: Double = 50.0
    @State var locationArray = [
        Place(name: "Pizza", coordinate: CLLocationCoordinate2D(latitude: 50.0, longitude: 50.0), phoneNumber: "\(1234567890)", address: "")
    ]
    @State var showPizza = false
    @State var searchPlace = "Pizza"
    @State var anotherSearch = ""
    var body: some View {
        NavigationStack{
            
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true, annotationItems: locationArray) { shop in
                MapAnnotation(coordinate: shop.coordinate) { 
                    if showPizza == true {
                        NavigationLink {
                            ShopView(name: shop.name, address: shop.address, phoneNumber: shop.phoneNumber)
                        } label: {
                            VStack {  
                                ZStack {
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(.black)  
                                    Text(shop.name)
                                        .foregroundStyle(.white)
                                }
                                .offset(y: 9)
                                Image(systemName: "mappin")
                                    .resizable()
                                    .frame(width: 20, height: 50)
                                    .colorMultiply(.red)
                                
                            }
                        }
                    }
                    else {
                        
                    }
                }
            }
            .ignoresSafeArea()
            .accentColor(.pink)
            
            .safeAreaInset(edge: .bottom) {    
                HStack{
                    Spacer()
                    VStack {
                        Text("Look For an Item")
                        TextField("Look For Places With An Item", text: $searchPlace)                            
                            .textFieldStyle(.roundedBorder)
                            .foregroundColor(.white)
                    }
                    .offset(y: 5)

                    Spacer()
                    Button(action: {
                        locationArray = []
                        anotherSearch = searchPlace
                        fetchPlaces(location: MapDetails.startingLocation)
                        showPizza.toggle()
                    }, label: {
                        Text("Find This Item Near You")
                    })
                    .offset(y: 5)
                    .foregroundColor(.teal)
                    Spacer()
                    .foregroundColor(.teal)
                    
                }
                .padding(.bottom)
                .background(.black)
            }
            .onAppear(perform: {
                viewModel.checkIfLocationIsEnabled()
            })
            
            
        }
    }
    private func fetchPlaces(location: CLLocationCoordinate2D) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "\(anotherSearch)"
        searchRequest.region = viewModel.region
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else { return }
            for mapItem in response.mapItems {
                // latitude = mapItem.placemark.coordinate.latitude
                // longitude = mapItem.placemark.coordinate.longitude
                locationArray.append(Place(name: mapItem.name ?? "Pizza Place", coordinate: mapItem.placemark.coordinate, phoneNumber: mapItem.phoneNumber ?? "\(1234567890)", address: mapItem.placemark.title ?? "Unknown")) 
            }
        } 
        
        
    }
}
