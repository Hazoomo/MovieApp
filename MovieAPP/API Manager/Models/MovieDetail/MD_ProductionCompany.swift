//
//	MD_ProductionCompany.swift


import Foundation 
import ObjectMapper


class MD_ProductionCompany : NSObject, NSCoding, Mappable{

	var id : Int?
	var logoPath : String?
	var name : String?
	var originCountry : String?


	class func newInstance(map: Map) -> Mappable?{
		return MD_ProductionCompany()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["id"]
		logoPath <- map["logo_path"]
		name <- map["name"]
		originCountry <- map["origin_country"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         logoPath = aDecoder.decodeObject(forKey: "logo_path") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         originCountry = aDecoder.decodeObject(forKey: "origin_country") as? String

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
		if logoPath != nil{
			aCoder.encode(logoPath, forKey: "logo_path")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if originCountry != nil{
			aCoder.encode(originCountry, forKey: "origin_country")
		}

	}

}
