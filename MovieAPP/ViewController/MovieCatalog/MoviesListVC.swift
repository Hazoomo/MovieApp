//
//  MoviesListVC.swift
//  MovieAPP
//
//  Created by Hazem Hasan on 5/14/19.
//  Copyright © 2019 24i. All rights reserved.
//

import UIKit
import SDWebImage
import Reachability
import SVProgressHUD
class MoviesListVC: UIViewController , APIDelegate , NetworkStatusListener , UITableViewDelegate , UITableViewDataSource  , UISearchBarDelegate{

    
    //MARK: - UI
    
    @IBOutlet weak var topTableView: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBarBottom: NSLayoutConstraint!
    
    //MARK: - Var
    var keyboardHeight : CGFloat = 0
    var moviesClass : ML_MoviesList? = nil
    var moviesArray :[ML_Result] = []
    var filteredMoviesArray : [ML_Result] = []
    var page = 1
    var firstCheckInternet = true
    var pulledNow = false
    var searching = false
    var indexPathSelected = -1
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
        
        //Init TableView
        initTableView()
        
        //Call Movie Popular Service
        callMoviesService()
        
        //Init UISearchBar
       // initSearchBar()
        
        //Observer to know when keyboard show
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        //Observer to know when keyboard hide
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        
        
      
    
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //Listener to connection status
        ReachabilityManager.shared.addListener(listener: self )
        //Configure This ViewController To Call Movies List Service
        APICall.shared.delegate = self
        APICall.shared.viewController = self
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //cancel listener to connection status from this viewcontroller
        ReachabilityManager.shared.removeListener(listener: self )
        
    }
   
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.layoutIfNeeded()
        initSearchBar()
     
    }
    //MARK: - Keyboard Notification
    @objc func keyboardWillShow(_ notification: Notification) {
        
        //Get Keyboard height to change the bottom contraint of searbBar
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
           
            var  bottomPadding : CGFloat = 0
            
            //GetSafeArea bottom
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                
                bottomPadding = (window?.safeAreaInsets.bottom)!
            }
             self.keyboardHeight = keyboardRectangle.height - bottomPadding
             self.searchBarBottom.constant =  keyboardHeight 
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        
       self.keyboardHeight = 0
        self.searchBarBottom.constant = 0
    }
    //MARK: - Init SearchBar
    func initSearchBar(){
     
        
        let offset = UIOffset(horizontal: (self.searchBar.frame.size.width / 2 )  - 60 , vertical: 0)
        searchBar.setPositionAdjustment(offset, for: .search)
 
    }
    //MARK: - Init TableView
    func initTableView(){
        
        
       

        //Hide Activity Indicator
         hideActivityIndicator()
        
        //Register Cell
        self.tableView.register(UINib.init(nibName: "MoviesCell", bundle: Bundle.main), forCellReuseIdentifier: "movieCell")
        
        //Remove empty cells in footer of tableview
        self.tableView.tableFooterView = UIView()
    }

    //MARK: - Call Services
    func callMoviesService(){
  
       
            DispatchQueue.main.async {
                self.callAPI()
            }
        
    }
    func callAPI(){
        if !searching{//If there is not any filtered now request new data
            
            if ReachabilityManager.shared.isAvailable(){ // Check Internet Connection
                
                if !self.pulledNow { // Check if API not calling now to avoid twice call
                
                    self.pulledNow = true
                
                    if page != 1 {
                        /* For the first time there is not pagination
                         enable activity indicator after the first page */
                    
                        showActivityIndicator()
                        
                    }
                    else {
                        
                        SVProgressHUD.show()
                        
                    }
                
                    
                    if let totalPages = self.moviesClass?.totalPages{ /* check if there are not more pages */
                    
                        if page <= totalPages{
                            APICall.shared.getMoviesList(page_number: self.page)
                            
                        }
                    }else{
                         APICall.shared.getMoviesList(page_number: self.page)
                    }
                
                    
                }
            }else{
                ConfigurationApp.shared.noInternetBanner()
            }
        }
    }
    
    
    //MARK: - ActiviyIndicator Functions
    
    func hideActivityIndicator(){
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.searchBarBottom.constant = 0 + keyboardHeight
    }
    func showActivityIndicator(){
        self.searchBarBottom.constant = 30 + keyboardHeight
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
    }
    
    
    
    // MARK: - TableViewDelegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            let cell : MoviesCell = Bundle.main.loadNibNamed("MoviesCell", owner: self, options: nil)?.first as! MoviesCell
        
        
            // Fill Data into cells
        
        if searching { //Data from Filter
            let movieDic = filteredMoviesArray[indexPath.row]
            
            if let movieImage = movieDic.posterPath {
                
                cell.movieImage.sd_setImage(with: URL(string : (ConfigurationApp.shared.imagePath + movieImage)), placeholderImage: UIImage(named: "poster_default") , completed:  nil)
                
            }
            
            if let title = movieDic.title {
                cell.movieTitle.text = title
            }
            
            return cell
            
        }else{
            
            let movieDic = moviesArray[indexPath.row]
            
            if let movieImage = movieDic.posterPath {
                
                cell.movieImage.sd_setImage(with: URL(string : (ConfigurationApp.shared.imagePath + movieImage)), placeholderImage: UIImage(named: "poster_default") , completed:  nil)
                
            }
            
            if let title = movieDic.title {
                cell.movieTitle.text = title
            }
            
            return cell
        }
        
        
       
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Go To Movie Detail
        self.indexPathSelected = indexPath.row
        self.performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if searching{
            return self.filteredMoviesArray.count
        }
        return self.moviesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 272
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Check if we reach to the bottom of tableview to call next page
        let lastElement = moviesArray.count - 1
        if indexPath.row == lastElement {
            callAPI()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        
       return 0.1
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor  = UIColor.clear
        return view
        
    }
   
    
    //MARK: - UISearchBar Delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            //Find searched text inside the main array of movies and pur the result in filtered Array
            self.filteredMoviesArray = self.moviesArray.filter({ (item : ML_Result) -> Bool in
                if (item.title?.lowercased().contains(searchText.lowercased()))!{
                    return true
                }else{
                    return false
                }
            
            })
        
        
            //Searching process is now
            searching = true
            self.tableView.reloadData()
            
            //ScrollTableView to Top if there is result
            if filteredMoviesArray.count != 0 {
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
            }
            
        }else{
            //Disable Searching
            searching = false
            self.tableView.reloadData()
        }
    }
    
  
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            self.searchBar.resignFirstResponder()
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
                
                if self.moviesClass == nil { // If there is no data call service again
                    callAPI()
                }
            }
            
            
            self.firstCheckInternet = false
            
        }
    }
    
    //MARK: - APIDelegate
    func successAPI(target: MyServerAPI) {
        switch target {
        case .getMoviesList:
            
           
            //Finish Service with store new data in moviesArray
           
            let last  = (self.moviesArray.count)
            self.moviesClass = APICall.shared.movies
            self.moviesArray = self.moviesArray +  (self.moviesClass?.results!)!
            self.tableView.reloadData()
            
           
            //Pagination
            
            if page != 1 {
                
                
                 hideActivityIndicator()
                
                
                 //Scroll TableView to last item last item after pagination
                let indexPath = IndexPath(row: last, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                
                if page == 2 {
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        let indexPath = IndexPath(row: 0, section: 0)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                    }
                }
                
            }else{
                
                SVProgressHUD.dismiss()
                
            }
            
            self.pulledNow = false
            self.page = self.page + 1
            
        default :
          
            break
        }
    }
    
    func failureAPI(target: MyServerAPI) {
        switch target {
        case  .getMoviesList:
            
            //Finish Service with error
            if page != 1 {
                
                hideActivityIndicator()
            }else{
                
                SVProgressHUD.dismiss()
                
            }
            
            self.pulledNow = false
    
            ConfigurationApp.shared.errorAlertAPI()
        default :
            
            break
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier ==  "showDetail" {
            let controller = segue.destination as! DetailVC
            if searching {
                controller.movieID = self.filteredMoviesArray[indexPathSelected].id!
            }else{
                 controller.movieID = self.moviesArray[indexPathSelected].id!
            }
        }
        
    }


}
