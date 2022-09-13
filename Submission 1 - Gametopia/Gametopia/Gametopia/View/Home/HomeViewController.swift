//
//  HomeViewController.swift
//  Gametopia
//
//  Created by Patricia Fiona on 11/09/22.
//

import SwiftUI
import Kingfisher
import SkeletonView

class HomeViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource,
                            UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var sliderScrollView: UIScrollView!
    @IBOutlet weak var sliderControll: UIPageControl!
    
    @IBOutlet weak var userProfilePicture: UIImageView!
    
    @IBOutlet weak var discoveryHorizontalScrollView: UIScrollView!
    @IBOutlet weak var discoveryBtn: UIButton!
    @IBOutlet weak var discoveryContainer: UIStackView!
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    @IBOutlet weak var developerTableView: UITableView!
    
    var slides:[Slide] = []
    var timer =  Timer()
    var counter = 0
    
    var genres:[GenreResult] = []
    var developers:[DeveloperResult] = []
    
    var totalDeveloperSkeleton = 10
    var totalGenreSkeleton = 20
    var totalDiscoverySkeleton = 10
    var shouldAnimateDeveloper = true
    var shouldAnimateGenre = true
    var shouldAnimateDiscovery = true
    
    let gradient = SkeletonGradient(baseColor: UIColor.darkClouds)
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupSlideScrollView(slides: slides)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        setHomeBanner(){ [self] (result) in
            sliderScrollView.isHidden = result
            sliderControll.isHidden = result
        }
    }
    
    private func initView(){
        imageCircle(imageView: userProfilePicture)
        
        sliderScrollView.delegate = self
        
        //create empty view in discovery for skeleton
        for _ in 0...totalDiscoverySkeleton{
            let viewItem:DiscoveryView = Bundle.main.loadNibNamed("DiscoveryView", owner: self, options: nil)?.first as! DiscoveryView
            
            viewItem.container.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
            
            self.discoveryContainer.addArrangedSubview(viewItem)
        }
        
        //home banner
        setHomeBanner(){ [self] (result) in
            sliderScrollView.isHidden = result
            sliderControll.isHidden = result
        }
        
        //set Genre Collection
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        
        genreCollectionView.register(UINib.init(nibName: "GenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionViewCell")
        
        //set developer table view
        developerTableView.dataSource = self
        developerTableView.register(
          UINib(nibName: "DeveloperTableViewCell", bundle: nil),
          forCellReuseIdentifier: "developerTableViewCell"
        )
        
        //load Data from API
        loadDiscoveryFromAPI()
        loadGenreFromAPI()
        loadDeveloperFromAPI()
    }
    
    private func setHomeBanner(completion: @escaping (Bool) -> Void){
        let queue = DispatchQueue(label: "com.patriciafiona.gametopia")
        queue.sync {
            sliderScrollView.isHidden = true
            sliderControll.isHidden = true
            
            sliderScrollView.subviews.forEach({ $0.removeFromSuperview() })
            
            slides = createSlides()
            setupSlideScrollView(slides: slides)
            
            resetSliderTimer()
            
            sliderControll.numberOfPages = slides.count
            sliderControll.currentPage = 0
            counter = 0 //for timer
            view.bringSubviewToFront(sliderControll)
            
            completion(false)
        }
        
    }
    
    private func resetSliderTimer(){
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(slide), userInfo: nil, repeats: true)
    }
    
    private func loadDiscoveryFromAPI(){
        let network = NetworkService()
        network.getDiscoveryGame(){ [self] (result) in
            let res = result
            let listDiscovery = res?.results
            
            if(listDiscovery != nil){
                discoveryContainer.subviews.forEach({ $0.removeFromSuperview() })
                
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
                totalGenreSkeleton = genres.count
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.shouldAnimateGenre=false
                    self.genreCollectionView.reloadData()
                }
            }else{
                self.genreCollectionView.reloadData()
            }
        }
    }
    
    private func loadDeveloperFromAPI(){
        let network = NetworkService()
        network.getListDevelopers(){ [self] (result) in
            let res = result
            let listDeveloper = res?.results
            
            if(listDeveloper != nil){
                developers = (res?.results!)!
                totalDeveloperSkeleton = developers.count
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.shouldAnimateDeveloper=false
                    self.developerTableView.reloadData()
                }
            }else{
                self.developerTableView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalGenreSkeleton
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionViewCell", for: indexPath) as! GenreCollectionViewCell
        if genres.count > 0 {
            cell.configure(with: genres[indexPath.row])
        }
        
        if shouldAnimateGenre{
            cell.darkTransparent.isHidden = true
            cell.imageViewSkeletonTemp.isHidden = false
            cell.cellContainer.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        }else{
            cell.darkTransparent.isHidden = false
            cell.imageViewSkeletonTemp.isHidden = true
            cell.cellContainer.hideSkeleton()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (genreCollectionView.frame.size.width - space) / 2.0
        
        return CGSize(width: size, height: 200)
    }
    
    @objc func slide(){
        if counter == 0{
            sliderScrollView.contentOffset = CGPoint(x:0, y:0)
            sliderControll.currentPage = 0
            counter += 1
        }else if counter <  slides.count{
            sliderScrollView.contentOffset = CGPoint(x:sliderScrollView.contentOffset.x + view.frame.width, y:0)
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

extension HomeViewController: UITableViewDataSource {

  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return totalDeveloperSkeleton
  }

  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "developerTableViewCell", for: indexPath) as? DeveloperTableViewCell else{
        return UITableViewCell()
      }
          
      cell.backgroundColor = cell.contentView.backgroundColor
      
      if (developers.count > 0){
          let dev = developers[indexPath.row]
          
          cell.name.text = dev.name
          textShadow(label: cell.name)
        
          if let backgroundImage = dev.imageBackground{
              let url = URL(string: (backgroundImage))
              cell.imageBackground.kf.setImage(
                  with: url,
                  placeholder: UIImage(named: "placeholder_image"),
                  options: [
                      .scaleFactor(UIScreen.main.scale),
                      .transition(.fade(1)),
                      .cacheOriginalImage
                  ]
              )
          }
          
          let listItemGame = [cell.gameItemBtn01, cell.gameItemBtn02, cell.gameItemBtn03]
          let listAddedText = [cell.gameItemAdded01, cell.gameItemAdded02, cell.gameItemAdded03]
          
          for i in 0 ..< listItemGame.count{
              listItemGame[i]!.contentHorizontalAlignment = .left
              listItemGame[i]!.setTitle(dev.games?[i].name, for: .normal)
              
              listAddedText[i]!.text = "\(dev.games?[i].added ?? 0)"
          }
      }
      
      if shouldAnimateDeveloper{
          cell.darkTransparent.isHidden = true
          cell.name.layer.shadowOpacity = 0
          cell.container.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
      }else{
          cell.darkTransparent.isHidden = false
          cell.name.layer.shadowOpacity = 1
          cell.container.hideSkeleton()
      }
      
      return cell
  }
}

extension HomeViewController: SkeletonTableViewDataSource{
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "developerTableViewCell"
    }
}
