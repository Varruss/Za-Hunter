import SwiftUI

struct ShopView: View {
    @State var name = String()
    @State var address = String()
    @State var phoneNumber = String()
    var body: some View {
        VStack {
          Text(name)  
                .font(.largeTitle)
                .fontWeight(.bold)
            Divider()

            Text("Address:") 
                .font(.title)
            Text("\n\(address)\n")
                .font(.headline)

            Text("Phone Number:") 
                .font(.title)
            Text("\n\(phoneNumber)\n")
                .font(.headline)

        }
        .multilineTextAlignment(.center)
        .foregroundStyle(.white)
    }
}
