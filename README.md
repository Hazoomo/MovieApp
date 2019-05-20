# MovieApp

Movie App is a test iOS application for 24/i Company.

- App compatible in iOS 10.0+

- App compatible both iPad & iPhone with two orientation Portrait & Landscape

- App contains one unit test for Movies Popular Service , we test if the service return response if we make the page attribute (Pagination) of the service positive and negative

Application Foldes is :

#### 1- Configuration Folder:
  - ConfigurationApp class : 
  contains the movie database api key and image path of it ,  Alert of Internet connection (Success & False) , 
  Alert for error response from "api.themoviedb.org" and Alert if there is not trailer to show.
  - ExtensionClass : has extension for UIColor.
  - SweetAlert : attractive alertview used in the app.
  
#### 2- APIManager Folder : 
I used Alamofire & Moya for API Calling
  - APIManager.swift : here we put all the services with paths and parameters and their methods
  - NetworkAdapter.swift : MoyaProvider my services and request the api , Response with callback if success of failure.
  - APICall.swift: this class has all the services that calling from the user with protocol to know if the response from NetworkAdapter.swift is success or failure 
  - ReachabilityManager.swift : To Monitor the interent connection
  - Response+ObjectMapper.swift : To Mapple my response from services and put them inside Models Folder (MoviesList for popular movies service - MoviesDetail for movie detail service - MovieVideos for movie videos service )
  
#### 3- ViewController Folder :
we have two ViewController MovieCatalog  , MovieDetail 
  - MovieCatalog Folder :
    - MoviesListVC : is a view controller of movie catalog
    - MovieCell Folder : is a customized cell for movie catalog tableview
  - MovieDetail Folder:
    - MovieDetailVC : is a view controller of detail
    - LandscapeDetailView Folder: is customized view for  the top section changed (backdrop image + Title movie + show trailer button) in Detail page in Landscape .
    - PortraitDetailView Folder : is customized view for  the top section changed (backdrop image + Title movie + show trailer button) in Detail page in Portrait .
    

