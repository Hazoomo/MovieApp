//
//  DetailVC.swift
//  MovieAPP
//
//  Created by Hazem Hasan on 5/19/19.
//  Copyright © 2019 24i. All rights reserved.
//

import UIKit
import SDWebImage
import Reachability
import SVProgressHUD
import XCDYouTubeKit
import AVKit
class DetailVC: UIViewController , APIDelegate , NetworkStatusListener , LandscapeViewDelegate , PortrailViewDelegate{

    
    //MARK: - UI
    
    
    @IBOutlet weak var bottomOfLandscape: NSLayoutConstraint!
    @IBOutlet weak var bottomOfPortrait: NSLayoutConstraint!
    @IBOutlet weak var portraitView: PortraitDetailView!
    
    @IBOutlet weak var landscapeView: LandscapeDetailView!
    @IBOutlet weak var overViewText: UITextView!
    @IBOutlet weak var genresValue: UILabel!
    
    @IBOutlet weak var dateValue: UILabel!
    
    //MARK: - Var
    
    var movieDetail : MD_MovieDetail? = nil
    var firstCheckInternet = true
    var movieID : Int!
    var movieVideos : MV_MovieVideos? = nil
    //MARK: - ViewController Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //compatible with iOS 10
        if #available(iOS 11.0, *) {
            
            
        }else{
            print("iOS 10")
            self.navigationController?.navigationBar.isTranslucent = false
            self.edgesForExtendedLayout = []
        }
        
        
        self.landscapeView.delegate = self
        self.portraitView.delegate = self
        
        //Get Details API
        callService(serviceInt: 0)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //Listener to connection status
        ReachabilityManager.shared.addListener(listener: self )
        
        //Configure This ViewController To Call Movies Detail Service
        APICall.shared.delegate = self
        APICall.shared.viewController = self
        
        //Check Orientation
        self.orientationProcess()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //cancel listener to connection status from this viewcontroller
        ReachabilityManager.shared.removeListener(listener: self )
        
    }
    
    
    
    //MARK: - Orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
     
        self.orientationProcess()
       
    }
    
    
    
    func orientationProcess(){
        
        
        if UIDevice.current.userInterfaceIdiom == .pad { //Check if iPad use the design of Landscape
            DispatchQueue.main.async {
                self.landscapeView.isHidden = false
                self.portraitView.isHidden = true
                self.bottomOfPortrait.isActive = false
                self.bottomOfLandscape.isActive = true
            }
        }else{
            if UIDevice.current.orientation.isLandscape {
            
                DispatchQueue.main.async {
                    self.landscapeView.isHidden = false
                    self.portraitView.isHidden = true
                    self.bottomOfPortrait.isActive = false
                    self.bottomOfLandscape.isActive = true
                }
            
            } else {
                
                DispatchQueue.main.async {
                    self.landscapeView.isHidden = true
                    self.portraitView.isHidden = false
                    self.bottomOfPortrait.isActive = true
                    self.bottomOfLandscape.isActive = false
                }
            }
        }
    }
    
    //MARK: - Put Data
    func reloadDetail(){
       
        //Set backdrop Image
        if let movieBackdrop = self.movieDetail?.backdropPath {
            self.portraitView.movieImage.sd_setImage(with: URL(string : (ConfigurationApp.shared.imagePath + movieBackdrop)), placeholderImage: UIImage(named: "backdrop_default") , completed:  nil)
            
             self.landscapeView.movieImage.sd_setImage(with: URL(string : (ConfigurationApp.shared.imagePath + movieBackdrop)), placeholderImage: UIImage(named: "backdrop_default") , completed:  nil)
        }
        
        //SetTile
        if let title = self.movieDetail?.title {
            self.portraitView.movieTitle.text  = title
            self.landscapeView.movieTitle.text  = title
        }
        
        
        //Set Genres
        if let genresArray = self.movieDetail?.genres {
            
            var str = ""
            
            for x in genresArray {
                str = str  + x.name!
                
                if x != genresArray.last {
                    str = str + ", "
                }
            }
            
            self.genresValue.text = str
        }
        
        
        //Set Date
        
        if let date = self.movieDetail?.releaseDate {
            self.dateValue.text = date
        }
        
        
        //Set Overview
        if let overView = self.movieDetail?.overview {
            self.overViewText.text = overView
        }
        
        
        
    }

    //MARK: - Call Services
    func callService(serviceInt : Int){
      
        DispatchQueue.main.async {
        
                self.callAPI(serviceInt: serviceInt)
        
        }
        
    }
   
    func callAPI(serviceInt : Int){
       
            
            if ReachabilityManager.shared.isAvailable(){ // Check Internet Connection
                
                    SVProgressHUD.show()
                
                switch serviceInt {
                case 0:
                         APICall.shared.getMovieDetial(movieID: self.movieID)
                case 1:
                         APICall.shared.getMovieVideos(movieID: self.movieID)
                default:break
                }
               
                    
                
            }else{
                ConfigurationApp.shared.noInternetBanner()
            }
        
    }
    
    //MARK: - Reachability
    func networkStatusDidChange(status: Reachability.Connection) {
        
        switch status {
            
        case .none: // There is not a connection
            ConfigurationApp.shared.noInternetBanner()
            
        case .wifi , .cellular : // connection founded
            
            
            if(!self.firstCheckInternet){
                /* Check if Interent connection return after the cutting  */
                ConfigurationApp.shared.internetFoundBanner()
                
                if self.movieDetail == nil { // If there is no data call service again
                    //Get Movie Detail
                    callAPI(serviceInt: 0)
                }
            }
            
            
            self.firstCheckInternet = false
            
        }
    }
        
    //MARK: - WatchTrailer
    func watchTrailerFromLandscape() {
        //Get Movie Videos
        self.callService(serviceInt: 1)
    }
    func watchTrailerFromPortrait() {
        //Get Movie Videos
        self.callService(serviceInt: 1)
    }
    
    func openYoutube(videoKey : String){
        let videoPlayerViewController : XCDYouTubeVideoPlayerViewController = XCDYouTubeVideoPlayerViewController(videoIdentifier: videoKey)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(moviePlayerPlaybackDidFinish),
            name:  NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: videoPlayerViewController.moviePlayer
        )
      
        
        self.present(videoPlayerViewController, animated: true) {
            videoPlayerViewController.moviePlayer.play()
        }
     
       
    }
    
    
    @objc func moviePlayerPlaybackDidFinish(_ notification: Notification) {
    
        NotificationCenter.default.removeObserver(self, name:  NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: notification.object)
       
    }
 

    //MARK: - APIDelegate
    func successAPI(target: MyServerAPI) {
        SVProgressHUD.dismiss()
        switch target {
        case .getMovieDetail:
            self.movieDetail = APICall.shared.movieDetail
            self.reloadDetail()
        
        case .getMovieVideos:
            self.movieVideos = APICall.shared.movieVideos
           
            if let results = self.movieVideos?.results {
                if results.count != 0 {
                    self.openYoutube(videoKey: results[0].key!)
                }else{
                    ConfigurationApp.shared.noTrailerAlert()
                }
               
            }
        default :
            break
        }
    }
    
    func failureAPI(target: MyServerAPI) {
        
        SVProgressHUD.dismiss()
        ConfigurationApp.shared.errorAlertAPI()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
