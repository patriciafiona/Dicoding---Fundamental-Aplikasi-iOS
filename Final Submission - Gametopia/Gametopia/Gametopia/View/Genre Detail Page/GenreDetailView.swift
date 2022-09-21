//
//  GenreDetailView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 15/09/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct GenreDetailView: View {
    @State private var genre:GenreResult
    
    init(genreData: GenreResult) {
        self.genre = genreData
        
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.barTintColor = .black
    }
    
    var body: some View {
        RootGenreContent(genre: genre)
    }
}

struct RootGenreContent: View{
    @Environment(\.presentationMode) var presentationMode
    @State var genre:GenreResult
    @State private var genreDetail: GenreDetailResponse?
    
    var body: some View{
        NavigationView {
            ScrollView{
                VStack(alignment: .leading) {
                    ZStack{
                        GeometryReader { geometry in
                            KFImage.url(URL(string: (genre.imageBackground!) ))
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
                                    HeaderGenreOverlay(name: genre.name, gamesCount: genre.gamesCount)
                                        .skeleton(with: genreDetail == nil)
                                        .shape(type: .rectangle)
                                        .appearance(type: .solid(color: .yellow, background: .black))
                                }
                        }
                        
                    }
                    .frame(height: 450.0)
                    
                    Text("About")
                        .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
                        .foregroundColor(.yellow)
                        .skeleton(with: genreDetail == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                    
                    HTMLStringView(htmlContent: genreDetail?.description ?? "No description")
                        .frame(minHeight: 200, maxHeight: 400)
                        .padding(.bottom, 20)
                        .skeleton(with: genreDetail == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                        .multiline(lines: 20, scales: [1: 0.5])
                    
                    Text("Popular Games")
                        .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
                        .foregroundColor(.yellow)
                        .skeleton(with: genreDetail == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                    
                    if(genre.games != nil){
                        LazyVStack(alignment: .leading){
                            ForEach((genre.games)!, id: \.self.id){game in
                                NavigationLink {
                                    DetailView(id: game.id!)
                                } label: {
                                    Text(game.name)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16))
                                        .underline()
                                        .padding(.bottom, 10)
                                }
                                
                            }
                        }
                        .skeleton(with: genreDetail == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                    }
                }
                .padding(10)
                .navigationBarTitle("Genre Details")
                .padding(.bottom, 50)
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
        }
        .phoneOnlyStackNavigationView()
        .statusBar(hidden: true)
        .onAppear() {
            let network = NetworkService()
            if let genreId = (genre.id) {
                network.getGenreDetails(id: genreId){ [] (result) in
                    let res = result
                    if let details = res{
                        self.genreDetail = details
                    }
                }
            }
        }
    }
}

struct HeaderGenreOverlay: View{
    var name: String?
    var gamesCount: Int?
    
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
                Text(name ?? "Unknown Name")
                    .font(Font.custom("EvilEmpire", size: 32, relativeTo: .title))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5)
                
                Text("Total games: \(gamesCount ?? 0)")
                    .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                    .font(.caption)
            }
            .padding()
        }
    }
}

struct GenreDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let tempJSONData = "{\"id\":4,\"name\":\"Action\",\"slug\":\"action\",\"games_count\":161516,\"image_background\":\"https://media.rawg.io/media/games/7cf/7cfc9220b401b7a300e409e539c9afd5.jpg\",\"description\":\"<p>Theactiongameisagenrethatincludesfights,puzzles,andstrategiesemphasizingcoordinationandreaction.Itincludesalargevarietyofsub-genreslikefighting,beat'emups,shooters,survivals,mazes,andplatforms;sometimesevenmultiplayeronlinebattlesandreal-timestrategies.Usually,theplayerperformsastheprotagonistwithitsuniqueabilities;somegamesaddpower-upsalongtheway.Thecharacteraimstocompletelevels,collectitems,avoidobstacles,andbattleagainstantagonists.It'snecessarytoavoidsevereinjuriesduringfights;ifthehealthbargoeslow,theplayerloses.Somegameshaveanunbeatablenumberofenemies,andtheonlygoalistomaximizescoreandsurviveforaslongaspossible.Theremightbeabossenemywhoappearsatthelastlevel;hehasuniqueabilitiesandalongerhealthbar.Pongisoneofthefirstactiongames,releasedin1972;thelatestincludeBattlefield,Assasin'sCreed,FortniteandDarkSouls.</p>\"}"
        
        GenreDetailView(genreData: GenreResult(JSONString: tempJSONData)!)
    }
}
