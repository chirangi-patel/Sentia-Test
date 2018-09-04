import Foundation
import ObjectMapper

class PropertyModel: Mappable {
    
    var id : String = ""
    var isPremium : Bool = true
    var area : String = ""
    var bathrooms : Int = 0
    var bedrooms : Int = 0
    var carspaces : Int = 0
    var desc : String = ""
    var owner : OwnerModel! = nil
    var auctionDate : String = ""
    var displayPrice : String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        id    <- map["Id"]
        isPremium    <- map["is_premium"]
        area    <- map["Area"]
        bathrooms    <- map["Bathrooms"]
        bedrooms    <- map["Bedrooms"]
        carspaces    <- map["Carspaces"]
        desc    <- map["Description"]
        owner    <- map["owner"]
        auctionDate    <- map["AuctionDate"]
        displayPrice    <- map["DisplayPrice"]
    }
}

class OwnerModel: Mappable {
    
    var name : String = ""
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        name    <- map["name"]
    }
}
