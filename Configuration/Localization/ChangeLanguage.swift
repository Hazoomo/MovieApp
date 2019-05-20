//
//  ChangeLanguage.swift
//  MovieAPP
//
//  Created by Hazem Hasan on 9/27/17.
//

import Foundation

let APPLE_LANGUAGE_KEY = "AppleLanguages"

class ChangeLanguage{
    
    //Get The Language Selected Now
    class func currentAppleLanguage() -> String{
        let userdef = UserDefaults.standard
        let langArray = userdef.object(forKey: APPLE_LANGUAGE_KEY) as! NSArray
        let current = langArray.firstObject as! String
        return current
    }
    
    
    //Change Language to another one
    class func setAppleLAnguageTo(lang: String) {
        let userdef = UserDefaults.standard
        userdef.set([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
}
