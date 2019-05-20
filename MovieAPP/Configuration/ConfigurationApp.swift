//
//  ConfigurationApp.swift
//  MovieAPP
//
//  Created by Hazem Hasan on 5/14/19.
//  Copyright © 2019 24i. All rights reserved.
//

import UIKit
import BRYXBanner
class ConfigurationApp {
    
    //Static
    static let shared = ConfigurationApp()
    
    //Constant
     let movieAPIKey = "0a4d134aa039e5d80e348ffd34f6cd7c"
     let languageAPI = "en"
     let imagePath = "http://image.tmdb.org/t/p/w342"
    
    
   

    // MARK: - Internet availability banner
    func noInternetBanner(){
        
        let banner = Banner(title:  NSLocalizedString("Warrning", comment: "Warrning"), subtitle:NSLocalizedString("No network connection", comment:"No network connection"), backgroundColor: UIColor.red)
        banner.dismissesOnTap = true
        banner.show(duration: 3)
        
    }
    
    func internetFoundBanner(){
        
        let banner = Banner(title:  NSLocalizedString("Internet Connection", comment:"Internet Connection"), subtitle:NSLocalizedString("Internt connection found", comment: "Internt connection found"), backgroundColor: UIColor(hex: "4BB543"))
        
        banner.dismissesOnTap = true
        banner.show(duration: 3)
        
    }
    
    
    //MARK: - Error with Call Service
    func errorAlertAPI(){
        SweetAlert().showAlert("", subTitle: NSLocalizedString("Something error happens, please try again", comment: "Something error happens , please try again") , style: AlertStyle.warning)
    }
    
    //MARK : - no Trailer Alert
    func noTrailerAlert(){
        SweetAlert().showAlert("", subTitle: NSLocalizedString("There is not trailer for this movie", comment: "There is not trailer for this movie") , style: AlertStyle.warning)
    }
    
}
