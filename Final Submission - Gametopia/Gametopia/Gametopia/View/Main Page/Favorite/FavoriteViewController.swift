//
//  FavoriteViewController.swift
//  Gametopia
//
//  Created by Patricia Fiona on 22/09/22.
//

import SwiftUI
import RealmSwift
import SkeletonView

class FavoriteViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var noFavoriteImage: UIImageView!
    
    private let realm = try! Realm()
    
    private var totalFavoriteSkeleton = 20
    private var shouldAnimateFavorite = true
    private let gradient = SkeletonGradient(baseColor: UIColor.darkClouds)
    private let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let favorites = realm.objects(Favorites.self)
        if(favorites.count > 0){
            totalFavoriteSkeleton = favorites.count
            isNoFavorites(status: false)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.shouldAnimateFavorite=false
                self.favoriteTableView.reloadData()
            }
        }else{
            totalFavoriteSkeleton = 0
            isNoFavorites(status: true)
        }
        
        favoriteTableView.reloadData()
    }
    
    private func isNoFavorites(status: Bool){
        favoriteTableView.isHidden = status
        noFavoriteImage.isHidden = !status
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func initView(){
        favoriteTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalFavoriteSkeleton
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteResultCell", for: indexPath) as? FavoriteTableViewCell else{
          return UITableViewCell()
        }
        let gameId = realm.objects(Favorites.self).sorted(byKeyPath: "name", ascending: true)[indexPath.row]._id
        
        //get data from API
        let network = NetworkService()
        network.getGameDetails(id: Int(gameId)!){ [self] (result) in
            let data = result
            
            if(data != nil){
                isNoFavorites(status: false)
                cell.backgroundColor = cell.contentView.backgroundColor
                
                cell.name.text = data?.name
                cell.score.text = "| Review by: \(data?.reviewsCount ?? 0)"
                cell.rating.text = "\(String(format: "%.2f", data?.rating ?? 0.0))"
                if(data?.released !=  nil){
                    cell.gameDescription.text = "Release on \(dateFormat(dateTxt: (data?.released)!))"
                }else{
                    cell.gameDescription.text = "Unknown release date"
                }
                
                if let backgroundImage = data?.backgroundImage {
                    let url = URL(string: (backgroundImage))
                    cell.gameImage.kf.setImage(
                        with: url,
                        options: [
                            .scaleFactor(UIScreen.main.scale),
                            .transition(.fade(1)),
                            .cacheOriginalImage
                        ]
                    )
                }
                viewRounded(view: cell.gameImage, radius: 10)
                
                let gesture = GameTapGesture(target: self, action: #selector(self.goToDetailPage))
                cell.addGestureRecognizer(gesture)
                gesture.id = (data?.id)!
                
            }else{
                isNoFavorites(status: true)
            }
        }
        
        if shouldAnimateFavorite{
            cell.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .crossDissolve(0.25))
        }else{
            cell.hideSkeleton(transition: .crossDissolve(0.25))
        }
        
        return cell
    }
    
    @objc private func goToDetailPage(sender : GameTapGesture) {
        let view = DetailView(id: sender.id)
        navigationController?.pushViewController(UIHostingController(rootView: view), animated: true)
    }
}

