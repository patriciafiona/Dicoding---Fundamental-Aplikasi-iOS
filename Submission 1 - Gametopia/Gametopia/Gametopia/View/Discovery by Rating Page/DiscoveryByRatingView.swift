//
//  DiscoveryByRatingView.swift
//  Gametopia
//
//  Created by Patricia Fiona on 15/09/22.
//

import SwiftUI
import Kingfisher
import SkeletonUI

struct templateSkeleton: Identifiable {
    let id = UUID()
}

struct DiscoveryByRatingView: View {
    private static var uniqueKey: String {
        UUID().uuidString
    }
    
    private var placeholder: String? = "Sort Game by Rating"
    
    private var options: [GenreFilterDropdownOption]? = [
        GenreFilterDropdownOption(key: uniqueKey, value: "Best Rating"),
        GenreFilterDropdownOption(key: uniqueKey, value: "Worst Rating"),
    ]
    
    private var onOptionSelected: ((_ option: GenreFilterDropdownOption) -> Void)? = { option in
            print(option)
    }
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.barTintColor = .black
        
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .black
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        RootDiscoverList(placeholder: placeholder, options: options, onOptionSelected: onOptionSelected)
    }
}

struct RootDiscoverList: View{
    @Environment(\.presentationMode) var presentationMode
    
    @State private var shouldShowDropdown = false
    @State private var selectedOption: GenreFilterDropdownOption? = nil
    
    var placeholder: String?
    var options: [GenreFilterDropdownOption]?
    var onOptionSelected: ((_ option: GenreFilterDropdownOption) -> Void)?
    
    private let buttonHeight: CGFloat = 35
    
    @State private var games: [Result]?
    
    private let templateSkeletonView = [templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton(), templateSkeleton()]
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading) {
                    // Dropdown
                    Button(action: {
                        self.shouldShowDropdown.toggle()
                    }) {
                        HStack {
                            Text(selectedOption == nil ? placeholder : selectedOption!.value)
                                .font(.system(size: 14))
                                .foregroundColor(selectedOption == nil ? Color.white: Color.yellow)
                                .fontWeight(.bold)

                            Spacer()

                            Image(systemName: self.shouldShowDropdown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                                .resizable()
                                .frame(width: 9, height: 5)
                                .font(Font.system(size: 9, weight: .medium))
                                .foregroundColor(Color.yellow)
                        }
                    }
                    .padding(.horizontal)
                    .cornerRadius(5)
                    .frame(width: .infinity, height: self.buttonHeight)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.yellow, lineWidth: 3)
                    )
                    .overlay(
                        VStack {
                            if self.shouldShowDropdown {
                                Spacer(minLength: buttonHeight + 10)
                                Dropdown(options: self.options! , onOptionSelected: { option in
                                    shouldShowDropdown = false
                                    selectedOption = option
                                    
                                    games = nil
                                    let network = NetworkService()
                                    if let statusFilter = selectedOption?.value == options![0].value ? true: false{
                                        network.getAllDiscoveryGame(sortFromBest: statusFilter){ [] (result) in
                                            let res = result
                                            let listResults = res?.results
                                            
                                            if(listResults != nil){
                                                games = listResults
                                            }
                                        }
                                    }
                                    
                                    self.onOptionSelected?(option)
                                })
                            }
                        }, alignment: .topLeading
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.init(UIColor.midnightBlue))
                    )
                    .padding(.horizontal, 20)
                    //End of Dropdown
                    
                    if(games != nil){
                        LazyVStack{
                            ForEach((games)!, id: \.self.id){game in
                                NavigationLink {
                                    DetailView(id: game.id!)
                                } label: {
                                    GameItem(game: game)
                                }
                            }
                        }
                        .padding(.top, 10)
                        .zIndex(-1)
                    }else{
                        if #available(iOS 16.0, *) {
                            SkeletonList(with: templateSkeletonView, quantity: templateSkeletonView.count) { loading, user in
                                GameItem(game: nil)
                                    .skeleton(with: loading)
                                    .shape(type: .rectangle)
                                    .appearance(type: .solid(color: .yellow, background: .black))
                                    .listRowBackground(Color.black)
                            }
                            .frame(height: 800)
                            .scrollContentBackground(.hidden)
                            .zIndex(-1)
                        }else{
                            SkeletonList(with: templateSkeletonView, quantity: templateSkeletonView.count) { loading, user in
                                GameItem(game: nil)
                                    .skeleton(with: loading)
                                    .shape(type: .rectangle)
                                    .appearance(type: .solid(color: .yellow, background: .black))
                                    .listRowBackground(Color.black)
                            }
                            .frame(height: 800)
                            .background(.black)
                            .zIndex(-1)
                        }
                    }
                }
                .navigationBarTitle("Discovery Game")
                .padding(.bottom, 50)
                .padding(.horizontal, 10)
            }
            .padding(.bottom, 50)
            .background(Color.black)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
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
        .navigationBarBackButtonHidden(true)
        .phoneOnlyStackNavigationView()
        .statusBar(hidden: true)
    }
}

struct Dropdown: View {
    var options: [GenreFilterDropdownOption]
    var onOptionSelected: ((_ option: GenreFilterDropdownOption) -> Void)?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.options, id: \.self) { option in
                    DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
                        .zIndex(1)
                }
            }
        }
        .frame(height: 60)
        .padding(.vertical, 5)
        .background(Color.init(UIColor.midnightBlue))
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.yellow, lineWidth: 3)
                .zIndex(1)
        )
        .zIndex(1)
    }
}

struct DropdownRow: View {
    var option: GenreFilterDropdownOption
    var onOptionSelected: ((_ option: GenreFilterDropdownOption) -> Void)?

    var body: some View {
        Button(action: {
            if let onOptionSelected = self.onOptionSelected {
                onOptionSelected(self.option)
            }
        }) {
            HStack {
                Text(self.option.value)
                    .font(.system(size: 14))
                    .foregroundColor(Color.white)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
}

struct GameItem: View{
    @State var game: Result?
    
    var body: some View {
        HStack{
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
                .frame(width: 80, height: 80)
                .clipped()
                .skeleton(with: game == nil)
                .shape(type: .rectangle)
                .appearance(type: .solid(color: .yellow, background: .black))
            
            VStack(alignment: .leading){
                Text(game?.name)
                    .lineLimit(1)
                    .font(Font.custom("EvilEmpire", size: 18, relativeTo: .title))
                    .foregroundColor(.yellow)
                    .skeleton(with: game == nil)
                    .shape(type: .rectangle)
                    .appearance(type: .solid(color: .yellow, background: .black))
                    .skeleton(with: game == nil)
                    .shape(type: .rectangle)
                    .appearance(type: .solid(color: .yellow, background: .black))
                
                if let releaseDate = game?.released {
                    Text("Release on \(dateFormat(dateTxt:releaseDate))")
                        .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                        .font(.system(size: 12))
                        .skeleton(with: game == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                }else{
                    Text("Unknown release date")
                        .foregroundColor(Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255))
                        .font(.system(size: 12))
                        .skeleton(with: game == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                }
                
                HStack{
                    Label("", systemImage: "star.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))
                        .skeleton(with: game == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                    
                    Text("\(game?.rating ?? 0.0, specifier: "%.2f")")
                        .foregroundColor(.white)
                        .font(Font.custom("EvilEmpire", size: 14, relativeTo: .title))
                        .fontWeight(.bold)
                        .skeleton(with: game == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                    
                    Text("| Total Review: \(game?.reviewsCount ?? 0)")
                        .foregroundColor(.white)
                        .font(Font.custom("EvilEmpire", size: 14, relativeTo: .title))
                        .skeleton(with: game == nil)
                        .shape(type: .rectangle)
                        .appearance(type: .solid(color: .yellow, background: .black))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
        }
    }
}

struct DiscoveryByRatingView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryByRatingView()
    }
}
