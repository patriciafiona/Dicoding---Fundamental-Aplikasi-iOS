//
//  ViewController.swift
//  Gametopia
//
//  Created by Patricia Fiona on 11/09/22.
//

import UIKit
import SwiftyGif
import SwiftUI

class SearchViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var notFoundText: UILabel!
    @IBOutlet weak var notFoundImage: UIImageView!
    @IBOutlet weak var loadingGIF: UIImageView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchBarPlaceholder = "Search name of game here..."
    
    var searchResults: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        
        if #available(iOS 13.0, *) {
           searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: searchBarPlaceholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        } else {
           if let searchField = searchBar.value(forKey: "searchField") as? UITextField {
               searchField.attributedPlaceholder = NSAttributedString(string: searchBarPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
           }
        }
    }

    private func initView(){
        isLoadingNow(status: false)
        
        //prepare loading GIF
        do {
            let gif = try UIImage(gifName: "loading.gif")
            self.loadingGIF.setGifImage(gif, loopCount: -1)
        } catch {
            print("Error in loading GIF: \(error)")
        }
        
        //prepare searchbar
        searchBar.delegate = self
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = UIColor.white
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.darkClouds
            
            let backgroundView = textField.subviews.first
            if #available(iOS 11.0, *) {
                backgroundView?.backgroundColor = UIColor.white.withAlphaComponent(0.3)
                backgroundView?.subviews.forEach({ $0.removeFromSuperview() })
            }
            backgroundView?.layer.cornerRadius = 10.5
            backgroundView?.layer.masksToBounds = true
        }
        
        searchTableView.dataSource = self
    }
    
    private func isLoadingNow(status: Bool){
        loadingGIF.isHidden = !status
        searchTableView.isHidden = status
    }
    
    private func isNotFoundResults(status: Bool){
        notFoundImage.isHidden = !status
        notFoundText.isHidden = !status
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as? SearchTableViewCell else{
          return UITableViewCell()
        }
        let data = searchResults[indexPath.row]
        
        cell.backgroundColor = cell.contentView.backgroundColor
        
        cell.name.text = data.name
        cell.score.text = "| Score: \(data.score ?? "0")"
        cell.rating.text = "\(data.rating ?? 0.0)"
        if(data.released !=  nil){
            cell.gameDescription.text = "Release on \(dateFormat(dateTxt: data.released!))"
        }else{
            cell.gameDescription.text = "Unknown release date"
        }
        
        if let backgroundImage = data.backgroundImage {
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
        gesture.id = (data.id)!
        
        return cell
    }
    
    @objc private func goToDetailPage(sender : GameTapGesture) {
        let view = DetailView(id: sender.id)
        navigationController?.pushViewController(UIHostingController(rootView: view), animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isLoadingNow(status: true)
        
        let searchText = searchBar.text!
        let network = NetworkService()
        
        network.getSearchResults(keyword: searchText){ [self] (result) in
            let res = result
            let listData = res?.results
            
            if(listData != nil){
                searchResults = (res?.results!)!
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    if(self.searchResults.isEmpty){
                        self.isNotFoundResults(status: true)
                        self.isLoadingNow(status: false)
                    }else{
                        self.isLoadingNow(status: false)
                        self.isNotFoundResults(status: false)
                        self.searchTableView.reloadData()
                    }
                }
            }else{
                self.isNotFoundResults(status: true)
                self.isLoadingNow(status: false)
            }
        }
        
    }
}

