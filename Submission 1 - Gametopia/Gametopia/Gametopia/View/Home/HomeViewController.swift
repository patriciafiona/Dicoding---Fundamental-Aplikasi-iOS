//
//  HomeViewController.swift
//  Gametopia
//
//  Created by Patricia Fiona on 11/09/22.
//

import SwiftUI

class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var sliderContainer: UIScrollView!
    @IBOutlet weak var sliderControll: UIPageControl!
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var discoveryContainer: UIStackView!
    
    var slides:[Slide] = []
    var timer =  Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderContainer.delegate = self
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
    }
    
    @objc func slide(){
        if counter == 0{
            sliderContainer.contentOffset = CGPoint(x:0, y:0)
            sliderControll.currentPage = 0
            counter += 1
        }else if counter <  slides.count{
            sliderContainer.contentOffset = CGPoint(x:sliderContainer.contentOffset.x + sliderContainer.frame.width, y:0)
            sliderControll.currentPage = Int(counter)
            counter += 1
        }else{
            counter = 0
            sliderContainer.contentOffset = CGPoint(x:0, y:0)
            sliderControll.currentPage = Int(counter)
            counter = 1
        }
    }
    
    private func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "home_banner_01")
        slide1.title.text = "Vampire: The Masquerade - Bloodlines 2"
        viewRounded(view: slide1)
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "home_banner_02")
        slide2.title.text = "Stray"
        viewRounded(view: slide2)
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "home_banner_03")
        slide3.title.text = "Forspoken"
        viewRounded(view: slide3)
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "home_banner_04")
        slide4.title.text = "Midnight Fight Express"
        viewRounded(view: slide4)
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "home_banner_05")
        slide5.title.text = "The Last of Us Part I"
        viewRounded(view: slide5)
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        sliderContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        sliderContainer.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        sliderContainer.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(
                x: view.frame.width * CGFloat(i),
                y: 0,
                width: view.frame.width,
                height: view.frame.height)
            sliderContainer.addSubview(slides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        sliderControll.currentPage = Int(pageIndex)
    }

}
