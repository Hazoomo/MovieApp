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
    
     let imagePath = "http://image.tmdb.org/t/p/w342"
    
    //Var
    var paths :[Any] = []
   
    
    func initAppDelegate(){
        
        //For the first launch
        guard UserDefaults.standard.bool(forKey: "launchedBefore") else {
           
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            
            //Make default Language of App
            
            ChangeLanguage.setAppleLAnguageTo(lang: "en")
            
            
            //Create Support Directory to store some non sensitive files if needed
            let appSupportDir  = NSSearchPathForDirectoriesInDomains( FileManager.SearchPathDirectory.applicationSupportDirectory , FileManager.SearchPathDomainMask.userDomainMask , true).last! as String
            
            if !FileManager.default.fileExists(atPath: appSupportDir , isDirectory: nil){
                var success: Bool
                do {
                    try FileManager.default.createDirectory(at: URL(fileURLWithPath: appSupportDir), withIntermediateDirectories: true, attributes: nil)
                    success = true
                } catch let error as NSError {
                    success = false
                    print("Error  \(error)");
                }
                
                if(success)
                {
                    
                    var url = URL(fileURLWithPath: appSupportDir)
                    
                    do {
                        var resourceValues = URLResourceValues()
                        resourceValues.isExcludedFromBackup = true
                        try url.setResourceValues(resourceValues)
                        
                    } catch let error as NSError {
                        
                        print("Error excluding \(url.lastPathComponent) from backup \(error)");
                    }
                }
            }
            
            
            
            let paths1 = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            let basePaths1 = (paths1.count > 0) ? paths.first  : nil
            
            if let base = basePaths1{
                self.addSkipBackupAttributeToItem(atPath: base as! String)
            }
            
            return
        }
       
    }
    
    
    //Skip iCloud Backup Files Funtion
    func addSkipBackupAttributeToItem(atPath path: String)  {
        
        var url = URL(fileURLWithPath: path)
        
        assert(FileManager.default.fileExists(atPath: path), "File \(path) does not exist")
        
        
        do {
            var resourceValues = URLResourceValues()
            resourceValues.isExcludedFromBackup = true
            try url.setResourceValues(resourceValues)
            
        } catch let error as NSError {
            
            print("Error excluding \(url.lastPathComponent) from backup \(error)");
        }
        
        
    }
    

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
