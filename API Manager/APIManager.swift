//
//  APIManager.swift
//  MovieAPP
//
//  Created by Hazem Hasan on 1/7/18.

//


import Foundation
import Moya

//MARK: - Services
enum MyServerAPI {
    
 
    
    
    
    case getMoviesList(page: Int)
    case getMovieDetail(movieID : Int)
    case getMovieVideos(movieID : Int)
    
}


extension MyServerAPI: TargetType {
//MARK: - Headers
    var headers: [String : String]? {
        
        switch self {
            
        case .getMoviesList , .getMovieVideos , .getMovieDetail:
            return [:]
     

        }
    }
    
    
//MARK: - Base URL
    var baseURL: URL {
         return URL(string : "https://api.themoviedb.org/3/movie")!
    }

//MARK: - Path
    var path: String {
        switch self {
       
        case .getMoviesList:
            
            return "/popular"
    
        case .getMovieDetail(let movieID) :
            return "/\(movieID)"
            
        case .getMovieVideos(let movieID):
            return "/\(movieID)/videos"
        }
    }
    
//MARK: - Method
    var method: Moya.Method {
        switch self {
        
        case   .getMoviesList ,.getMovieVideos , .getMovieDetail :
            return .get
        
    
        }
    }
    
//MARK: - Paramters
    var parameters: [String: Any]? {
       return nil
    }
    
//MARK: - ParameterEncoding
    var parameterEncoding: ParameterEncoding {

        return URLEncoding.default
     
    }
    
    
//MARK: - SampleData
    var sampleData: Data {
        return Data()
    }
    
    
//MARK: - Task
    var task: Task {
        
        switch self {
            
        case .getMoviesList(let page  ) :
            var parameters = [String:Any]()
            
            parameters["page"] = page
            parameters["language"] = ChangeLanguage.currentAppleLanguage()
            parameters["api_key"] = ConfigurationApp.shared.movieAPIKey
            
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        
        
        //
            
        case .getMovieDetail(_) :
            
        var parameters = [String:Any]()
        
       
        parameters["language"] = ChangeLanguage.currentAppleLanguage()
        parameters["api_key"] = ConfigurationApp.shared.movieAPIKey
        
        
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
            
            
        //
        case .getMovieVideos(_) :
            
            var parameters = [String:Any]()
            
            
            parameters["language"] = ChangeLanguage.currentAppleLanguage()
            parameters["api_key"] = ConfigurationApp.shared.movieAPIKey
            
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
        
}
