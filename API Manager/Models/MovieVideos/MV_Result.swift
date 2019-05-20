//
//	MV_Result.swift


import Foundation 
import ObjectMapper


class MV_Result : NSObject, NSCoding, Mappable{

	var id : String?
	var iso31661 : String?
	var iso6391 : String?
	var key : String?
	var name : String?
	var site : String?
	var size : Int?
	var type : String?


	class func newInstance(map: Map) -> Mappable?{
		return MV_Result()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["id"]
		iso31661 <- map["iso_3166_1"]
		iso6391 <- map["iso_639_1"]
		key <- map["key"]
		name <- map["name"]
		site <- map["site"]
		size <- map["size"]
		type <- map["type"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? String
         iso31661 = aDecoder.decodeObject(forKey: "iso_3166_1") as? String
         iso6391 = aDecoder.decodeObject(forKey: "iso_639_1") as? String
         key = aDecoder.decodeObject(forKey: "key") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         site = aDecoder.decodeObject(forKey: "site") as? String
         size = aDecoder.decodeObject(forKey: "size") as? Int
         type = aDecoder.decodeObject(forKey: "type") as? String

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
		if iso31661 != nil{
			aCoder.encode(iso31661, forKey: "iso_3166_1")
		}
		if iso6391 != nil{
			aCoder.encode(iso6391, forKey: "iso_639_1")
		}
		if key != nil{
			aCoder.encode(key, forKey: "key")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if site != nil{
			aCoder.encode(site, forKey: "site")
		}
		if size != nil{
			aCoder.encode(size, forKey: "size")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}
