//
//  APICall.swift
//  MovieAPP
//
//  Created by Hazem Hasan on 1/19/19.

//

import Foundation
import UIKit
protocol APIDelegate :class {
      func successAPI(target : MyServerAPI)
      func failureAPI(target : MyServerAPI)
}
class APICall {
    
    static let shared = APICall()
    weak var delegate : APIDelegate?
    var viewController : UIViewController!
    
    
    var movies : ML_MoviesList!
    var movieDetail : MD_MovieDetail!
    var movieVideos : MV_MovieVideos!
    
    //MARK: - Get Movies List
   
    func getMoviesList(page_number : Int){
        
        NetworkAdapter.request(target: .getMoviesList(page: page_number)  , viewController : viewController , success: { (response,target) in
         
            
            do{

                    self.movies = try response.mapObject(ML_MoviesList.self)
                    self.delegate?.successAPI(target: target)

            }catch{
                
                 self.delegate?.failureAPI(target: target)
                
            }
        }, error: { (error,target) in
            self.delegate?.failureAPI(target: target)
            
        }, failure: { (error,target) in
            // show Moya error
            self.delegate?.failureAPI(target: target)
            
        })
        
        
    }
    
    
    //MARK: - Get Movie Detail
    
    func getMovieDetial(movieID : Int){
        
        NetworkAdapter.request(target: .getMovieDetail(movieID: movieID)  , viewController : viewController , success: { (response,target) in
            
            
            do{
                
                self.movieDetail = try response.mapObject(MD_MovieDetail.self)
                self.delegate?.successAPI(target: target)
                
            }catch{
                
                self.delegate?.failureAPI(target: target)
                
            }
        }, error: { (error,target) in
            self.delegate?.failureAPI(target: target)
            
        }, failure: { (error,target) in
            // show Moya error
            self.delegate?.failureAPI(target: target)
            
        })
        
        
    }
 
    //MARK: - Get Movie Videos
    
    func getMovieVideos(movieID : Int){
        
        NetworkAdapter.request(target: .getMovieVideos(movieID: movieID)  , viewController : viewController , success: { (response,target) in
            
            
            do{
                
                self.movieVideos = try response.mapObject(MV_MovieVideos.self)
                self.delegate?.successAPI(target: target)
                
            }catch{
                
                self.delegate?.failureAPI(target: target)
                
            }
        }, error: { (error,target) in
            self.delegate?.failureAPI(target: target)
            
        }, failure: { (error,target) in
            // show Moya error
            self.delegate?.failureAPI(target: target)
            
        })
        
        
    }
    
}
