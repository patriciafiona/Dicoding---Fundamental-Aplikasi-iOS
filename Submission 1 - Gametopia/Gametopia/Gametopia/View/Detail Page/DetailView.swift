//
//  DetailView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 14/09/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct DetailView: View {
    @State private var id: Int
    @State private var game: DetailGameResponse?
    
    init(id: Int) {
        self.id = id
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.barTintColor = .black
    }
    
    var body: some View {
        RootContent(id: id, game: game)
    }
}

struct RootContent: View{
    @Environment(\.presentationMode) var presentationMode
    @State var id: Int
    @State var game: DetailGameResponse?
    
    var body: some View{
        NavigationView {
            ScrollView{
                VStack(alignment: .leading) {
                    ZStack{
                        GeometryReader { geometry in
                            KFImage.url(URL(string: (game?.backgroundImage) ?? ""))
                                .placeholder {
                                    Image("gametopia_icon")
                                        .resizable()
                                        .scaledToFit()
                                }
                                .cacheMemoryOnly()
                                .fade(duration: 0.25)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .edgesIgnoringSafeArea(.all)
                                .frame(maxWidth: geometry.size.width,
                                       maxHeight: geometry.size.height)
                                .mask(
                                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                                )
                                .overlay{
                                    HeaderOverlay(game: game)
                                        .skeleton(with: game == nil)
                                        .shape(type: .rectangle)
                                        .appearance(type: .solid(color: .yellow, background: .black))
                                }
                        }
                        
                    }
                    .frame(height: 450.0)
                    
                    Divider()
                    
                    VStack(alignment: .leading){
                        Text("Genres")
                            .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
                            .foregroundColor(.yellow)
                            .skeleton(with: game == nil)
                            .shape(type: .rectangle)
                            .appearance(type: .solid(color: .yellow, background: .black))
                        ScrollView{
                            HStack{
                                if(game?.genres! != nil){
                                    ForEach((game?.genres)!, id: \.self.id){genreData in
                                        Button(action: {}) {
                                            Text(genreData.name)
                                                .font(Font.custom("EvilEmpire", size: 14, relativeTo: .title))
                                                .fontWeight(.bold)
                                        }
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 15)
                                        .foregroundColor(.yellow)
                                        .background(Color.indigo)
                                        .cornerRadius(.infinity)
                                        .lineLimit(1)
                                    }
                                }
                            }
                        }
                        
                        Text("About")
                            .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
                            .foregroundColor(.yellow)
                            .skeleton(with: game == nil)
                            .shape(type: .rectangle)
                            .appearance(type: .solid(color: .yellow, background: .black))
                        
                        HTMLStringView(htmlContent: game?.description ?? "No description")
                            .frame(height: 350)
                            .skeleton(with: game == nil)
                            .shape(type: .rectangle)
                            .appearance(type: .solid(color: .yellow, background: .black))
                                            .multiline(lines: 20, scales: [1: 0.5])
                        Text("Platform")
                            .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
                            .foregroundColor(.yellow)
                            .skeleton(with: game == nil)
                            .shape(type: .rectangle)
                            .appearance(type: .solid(color: .yellow, background: .black))
                        
                        if(game?.platforms! != nil){
                            LazyVStack{
                                ForEach((game?.platforms)!, id: \.self.platform?.id){platformData in
                                    PlatformItem(platform: platformData.platform)
                                        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                }
                            }
                        }
                        
                        Text("Developer")
                            .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
                            .foregroundColor(.yellow)
                            .skeleton(with: game == nil)
                            .shape(type: .rectangle)
                            .appearance(type: .solid(color: .yellow, background: .black))
                    }
                    .padding(10)
                }
                .navigationBarTitle("Details")
            }
            .background(Color.black)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle")
                                .foregroundColor(.yellow)
                            Text("Go Back")
                                .foregroundColor(.yellow)
                        }
                    })
            //.edgesIgnoringSafeArea(.all)
        }
        .edgesIgnoringSafeArea(.all)
        .statusBar(hidden: true)
        .onAppear() {
            let network = NetworkService()
            network.getGameDetails(id: id){ [] (result) in
                let res = result
                if let gameDetail = res{
                    game = gameDetail
                }
            }
        }
    }
}

struct HeaderOverlay: View{
    var game: DetailGameResponse?
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                HStack{
                    Text(game?.name ?? "Unknown Name")
                        .font(Font.custom("EvilEmpire", size: 32, relativeTo: .title))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 5)
                    
                    Spacer()
                    
                    Label("", systemImage: "star.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(.yellow)
                    
                    Text("\(game?.rating ?? 0.0, specifier: "%.2f")")
                        .foregroundColor(.white)
                        .font(Font.custom("EvilEmpire", size: 22, relativeTo: .title))
                        .fontWeight(.bold)
                        .shadow(color: .black, radius: 5)
                }
                HStack{
                    VStack(alignment: .leading){
                        Text("Added to")
                            .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                            .font(.caption)
                        HStack{
                            Text("Wishlist")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .font(.title3)
                            
                            Text("\(game?.added ?? 0)")
                                .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                                .fontWeight(.bold)
                                .font(.title3)
                        }
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(.white, lineWidth: 3))
                }
            }
            .padding()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: 0)
    }
}

extension String {
    func markdownToAttributed() -> AttributedString {
        do {
            return try AttributedString(markdown: self) /// convert to AttributedString
        } catch {
            return AttributedString("Error parsing markdown: \(error)")
        }
    }
}
