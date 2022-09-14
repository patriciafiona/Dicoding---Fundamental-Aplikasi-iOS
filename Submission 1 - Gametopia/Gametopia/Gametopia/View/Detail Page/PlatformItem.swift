//
//  PlatformItem.swift
//  Gametopia
//
//  Created by Patricia Fiona on 14/09/22.
//

import SwiftUI
import Kingfisher

struct PlatformItem: View {
    var platform: PlatformDetails?
    
    var body: some View {
        HStack {
            KFImage.url(URL(string: (platform?.imageBackground) ?? ""))
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
            
            Divider()
            
            VStack{
                Text(platform?.name ?? "Unknown Platform")
                    .font(Font.custom("EvilEmpire", size: 24, relativeTo: .title))
                    .foregroundColor(.yellow)
            }

            Spacer()
        }
        .background(Color.black)
    }
}

struct PlatformItem_Previews: PreviewProvider {
    static var previews: some View {
        PlatformItem()
    }
}
