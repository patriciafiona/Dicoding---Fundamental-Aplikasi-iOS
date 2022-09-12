//
//  HomeViewController.swift
//  Gametopia
//
//  Created by Patricia Fiona on 11/09/22.
//

import SwiftUI
import Kingfisher

class HomeViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource,
                            UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var sliderControll: UIPageControl!
    
    @IBOutlet weak var userProfilePicture: UIImageView!
    
    @IBOutlet weak var discoveryHorizontalScrollView: UIScrollView!
    @IBOutlet weak var discoveryBtn: UIButton!
    @IBOutlet weak var discoveryContainer: UIStackView!
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    var slides:[Slide] = []
    var timer =  Timer()
    var counter = 0
    
    var genres:[GenreResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderScrollView.delegate = self
        initView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupSlideScrollView(slides: slides)
    }
    
    private func initView(){
        imageCircle(imageView: userProfilePicture)
        
        //home banner
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        sliderControll.numberOfPages = slides.count
        sliderControll.currentPage = 0
        view.bringSubviewToFront(sliderControll)
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(slide), userInfo: nil, repeats: true)
        
        //set Genre Collection
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        
        genreCollectionView.register(UINib.init(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionViewCell")
        
        //load Data from API
        loadDiscoveryFromAPI()
        loadGenreFromAPI()
    }
    
    private func loadDiscoveryFromAPI(){
        let network = NetworkService()
        network.getDiscoveryGame(){ [self] (result) in
            let res = result
            let listDiscovery = res?.results
            
            if(listDiscovery != nil){
                for i in 0 ..< listDiscovery!.count {
                    //create viewItem
                    let viewItem:DiscoveryView = Bundle.main.loadNibNamed("DiscoveryView", owner: self, options: nil)?.first as! DiscoveryView
                    let data = res?.results?[i]
                    viewItem.title.text = data?.name
                    viewItem.rating.text = "\(data?.rating ?? 0.0)"
                    
                    if(data?.released != nil){
                        viewItem.releaseDate.text = "Released on \(dateFormat(dateTxt: (data?.released!)!))"
                    }else{
                        viewItem.releaseDate.text = "Unknown Release"
                    }
                    
                    if let backgroundImage = data?.backgroundImage{
                        let url = URL(string: (backgroundImage))
                        viewItem.posterImage.kf.setImage(
                            with: url,
                            placeholder: UIImage(named: "placeholder_image"),
                            options: [
                                .scaleFactor(UIScreen.main.scale),
                                .transition(.fade(1)),
                                .cacheOriginalImage
                            ]
                        )
                    }
    
                    viewItem.frame = CGRect(
                        x: view.frame.width * CGFloat(i),
                        y: 0,
                        width: view.frame.width,
                        height: view.frame.height)
                    
                    viewRounded(view: viewItem, radius: 15)
                    
                    self.discoveryContainer.addArrangedSubview(viewItem)
                }
            }
        }
    }
    
    private func loadGenreFromAPI(){
        let network = NetworkService()
        network.getListGenres(){ [self] (result) in
            let res = result
            let listGenre = res?.results
            
            if(listGenre != nil){
                genres = (res?.results!)!
                self.genreCollectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        cell.configure(with: genres[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (genreCollectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    @objc func slide(){
        if counter == 0{
            sliderScrollView.contentOffset = CGPoint(x:0, y:0)
            sliderControll.currentPage = 0
            counter += 1
        }else if counter <  slides.count{
            sliderScrollView.contentOffset = CGPoint(x:sliderScrollView.contentOffset.x + sliderScrollView.frame.width, y:0)
            sliderControll.currentPage = Int(counter)
            counter += 1
        }else{
            counter = 0
            sliderScrollView.contentOffset = CGPoint(x:0, y:0)
            sliderControll.currentPage = Int(counter)
            counter = 1
        }
    }
    
    private func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "home_banner_01")
        slide1.title.text = "Vampire: The Masquerade - Bloodlines 2"
        viewRounded(view: slide1, radius: 30)
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "home_banner_02")
        slide2.title.text = "Stray"
        viewRounded(view: slide2, radius: 30)
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "home_banner_03")
        slide3.title.text = "Forspoken"
        viewRounded(view: slide3, radius: 30)
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "home_banner_04")
        slide4.title.text = "Midnight Fight Express"
        viewRounded(view: slide4, radius: 30)
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "home_banner_05")
        slide5.title.text = "The Last of Us Part I"
        viewRounded(view: slide5, radius: 30)
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        sliderScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        sliderScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        sliderScrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(
                x: view.frame.width * CGFloat(i),
                y: 0,
                width: view.frame.width,
                height: view.frame.height)
            sliderScrollView.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        sliderControll.currentPage = Int(pageIndex)
    }

}
