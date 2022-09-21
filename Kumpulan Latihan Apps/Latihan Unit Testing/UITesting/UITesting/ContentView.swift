//
//  ContentView.swift
//  UITesting
//
//  Created by Patricia Fiona on 21/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAlert = false
    
    var body: some View {
        Button (action:
            {self.showingAlert = true}
        ) {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
        }.alert(
            isPresented: $showingAlert){
                Alert(
                    title: Text("Apa kabar?"),
                    dismissButton: .default(
                        Text("Luar biasa!")
                   )
                )
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
