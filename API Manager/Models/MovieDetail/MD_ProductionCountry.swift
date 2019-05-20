//
//	MD_ProductionCountry.swift


import Foundation 
import ObjectMapper


class MD_ProductionCountry : NSObject, NSCoding, Mappable{

	var iso31661 : String?
	var name : String?


	class func newInstance(map: Map) -> Mappable?{
		return MD_ProductionCountry()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		iso31661 <- map["iso_3166_1"]
		name <- map["name"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         iso31661 = aDecoder.decodeObject(forKey: "iso_3166_1") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if iso31661 != nil{
			aCoder.encode(iso31661, forKey: "iso_3166_1")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}

	}

}
