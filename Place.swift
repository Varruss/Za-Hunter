import SwiftUI
import MapKit

struct Place: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var phoneNumber: String
    var address: String

}
