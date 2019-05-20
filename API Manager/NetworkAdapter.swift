//
//  NetworkAdapter.swift
//  MovieAPP
//
//  Created by Hazem Hasan on 1/7/18.


import Moya

struct NetworkAdapter {
    static let provider = MoyaProvider<MyServerAPI>()
    
    static func request(target: MyServerAPI , viewController : UIViewController? ,success  successCallback: @escaping (Response , MyServerAPI) -> Void, error errorCallback: @escaping (Response , MyServerAPI ) -> Void, failure failureCallback: @escaping (MoyaError , MyServerAPI ) -> Void) {
        
        
       
        provider.request(target) { (result) in
            
            switch result {
                
            case .success(let response ):
              
                    // Success Code
                    if  response.statusCode >= 200 && response.statusCode <= 300 {
                        
                         successCallback(response ,target)
                        
                        do {
                            
                            print(try response.mapJSON())
                            
                            
                        }catch{
                            
                        }
                    }
                   
                    //Failure Code
                    else {
        
                        errorCallback(response , target)
                       
                    }
                    
                
            case .failure(let error ):
                failureCallback(error ,target)
               
            }
            
        }
        
    
    }
}
