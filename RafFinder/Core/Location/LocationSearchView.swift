import SwiftUI

struct LocationSearchView: View {
    @State private var startLocationText = ""
    @State private var destinationLocationText = ""
    @State private var userInput: String = ""
    
    var body: some View {
        VStack {
            // Header view
            HStack {
                VStack {
                    TextField("Enter food or restaurant name", text: $userInput)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(.blue)
                        .frame(height: 100)
                        .padding(.horizontal)
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                               
                                }) {
                                    Image(systemName: "mic.fill")
                                        .foregroundColor(.blue)
                                }
                                .padding(.trailing, 50)
                            }
                        )

                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            // List view
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(0..<20, id: \.self) { _ in
                        LocationSearchResult()
                    }
                }
            }
        }
        .background(.white)
        
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}


