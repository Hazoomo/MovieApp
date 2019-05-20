//
//	MV_MovieVideos.swift


import Foundation 
import ObjectMapper


class MV_MovieVideos : NSObject, NSCoding, Mappable{

	var id : Int?
	var results : [MV_Result]?


	class func newInstance(map: Map) -> Mappable?{
		return MV_MovieVideos()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["id"]
		results <- map["results"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         results = aDecoder.decodeObject(forKey: "results") as? [MV_Result]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if results != nil{
			aCoder.encode(results, forKey: "results")
		}

	}

}
