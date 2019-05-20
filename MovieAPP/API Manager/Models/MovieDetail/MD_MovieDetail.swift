//
//	MD_MovieDetail.swift


import Foundation 
import ObjectMapper


class MD_MovieDetail : NSObject, NSCoding, Mappable{

	var adult : Bool?
	var backdropPath : String?
	
	var budget : Int?
	var genres : [MD_Genre]?
	var homepage : String?
	var id : Int?
	var imdbId : String?
	var originalLanguage : String?
	var originalTitle : String?
	var overview : String?
	var popularity : Float?
	var posterPath : String?
	var productionCompanies : [MD_ProductionCompany]?
	var productionCountries : [MD_ProductionCountry]?
	var releaseDate : String?
	var revenue : Int?
	var runtime : Int?
	var spokenLanguages : [MD_SpokenLanguage]?
	var status : String?
	var tagline : String?
	var title : String?
	var video : Bool?
	var voteAverage : Int?
	var voteCount : Int?


	class func newInstance(map: Map) -> Mappable?{
		return MD_MovieDetail()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		adult <- map["adult"]
		backdropPath <- map["backdrop_path"]
	
		budget <- map["budget"]
		genres <- map["genres"]
		homepage <- map["homepage"]
		id <- map["id"]
		imdbId <- map["imdb_id"]
		originalLanguage <- map["original_language"]
		originalTitle <- map["original_title"]
		overview <- map["overview"]
		popularity <- map["popularity"]
		posterPath <- map["poster_path"]
		productionCompanies <- map["production_companies"]
		productionCountries <- map["production_countries"]
		releaseDate <- map["release_date"]
		revenue <- map["revenue"]
		runtime <- map["runtime"]
		spokenLanguages <- map["spoken_languages"]
		status <- map["status"]
		tagline <- map["tagline"]
		title <- map["title"]
		video <- map["video"]
		voteAverage <- map["vote_average"]
		voteCount <- map["vote_count"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         adult = aDecoder.decodeObject(forKey: "adult") as? Bool
         backdropPath = aDecoder.decodeObject(forKey: "backdrop_path") as? String
        
         budget = aDecoder.decodeObject(forKey: "budget") as? Int
         genres = aDecoder.decodeObject(forKey: "genres") as? [MD_Genre]
         homepage = aDecoder.decodeObject(forKey: "homepage") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         imdbId = aDecoder.decodeObject(forKey: "imdb_id") as? String
         originalLanguage = aDecoder.decodeObject(forKey: "original_language") as? String
         originalTitle = aDecoder.decodeObject(forKey: "original_title") as? String
         overview = aDecoder.decodeObject(forKey: "overview") as? String
         popularity = aDecoder.decodeObject(forKey: "popularity") as? Float
         posterPath = aDecoder.decodeObject(forKey: "poster_path") as? String
         productionCompanies = aDecoder.decodeObject(forKey: "production_companies") as? [MD_ProductionCompany]
         productionCountries = aDecoder.decodeObject(forKey: "production_countries") as? [MD_ProductionCountry]
         releaseDate = aDecoder.decodeObject(forKey: "release_date") as? String
         revenue = aDecoder.decodeObject(forKey: "revenue") as? Int
         runtime = aDecoder.decodeObject(forKey: "runtime") as? Int
         spokenLanguages = aDecoder.decodeObject(forKey: "spoken_languages") as? [MD_SpokenLanguage]
         status = aDecoder.decodeObject(forKey: "status") as? String
         tagline = aDecoder.decodeObject(forKey: "tagline") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String
         video = aDecoder.decodeObject(forKey: "video") as? Bool
         voteAverage = aDecoder.decodeObject(forKey: "vote_average") as? Int
         voteCount = aDecoder.decodeObject(forKey: "vote_count") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if adult != nil{
			aCoder.encode(adult, forKey: "adult")
		}
		if backdropPath != nil{
			aCoder.encode(backdropPath, forKey: "backdrop_path")
		}
		
		if budget != nil{
			aCoder.encode(budget, forKey: "budget")
		}
		if genres != nil{
			aCoder.encode(genres, forKey: "genres")
		}
		if homepage != nil{
			aCoder.encode(homepage, forKey: "homepage")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if imdbId != nil{
			aCoder.encode(imdbId, forKey: "imdb_id")
		}
		if originalLanguage != nil{
			aCoder.encode(originalLanguage, forKey: "original_language")
		}
		if originalTitle != nil{
			aCoder.encode(originalTitle, forKey: "original_title")
		}
		if overview != nil{
			aCoder.encode(overview, forKey: "overview")
		}
		if popularity != nil{
			aCoder.encode(popularity, forKey: "popularity")
		}
		if posterPath != nil{
			aCoder.encode(posterPath, forKey: "poster_path")
		}
		if productionCompanies != nil{
			aCoder.encode(productionCompanies, forKey: "production_companies")
		}
		if productionCountries != nil{
			aCoder.encode(productionCountries, forKey: "production_countries")
		}
		if releaseDate != nil{
			aCoder.encode(releaseDate, forKey: "release_date")
		}
		if revenue != nil{
			aCoder.encode(revenue, forKey: "revenue")
		}
		if runtime != nil{
			aCoder.encode(runtime, forKey: "runtime")
		}
		if spokenLanguages != nil{
			aCoder.encode(spokenLanguages, forKey: "spoken_languages")
		}
		if status != nil{
			aCoder.encode(status, forKey: "status")
		}
		if tagline != nil{
			aCoder.encode(tagline, forKey: "tagline")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if video != nil{
			aCoder.encode(video, forKey: "video")
		}
		if voteAverage != nil{
			aCoder.encode(voteAverage, forKey: "vote_average")
		}
		if voteCount != nil{
			aCoder.encode(voteCount, forKey: "vote_count")
		}

	}

}
