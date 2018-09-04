
import Foundation
import ObjectMapper

extension PropertyListVC{
    
    func getPropertyList(params : [String:AnyObject]!, withCompletion completion:@escaping (Bool) -> Void) {
        
        showLoader(inView: self.view)
        
        WebService.GET(withURL: PROPERTY_LIST_URL, Parameters: params, completionHander: { (response,error) in
            
            hideLoader(inView: self.view)
            
            if (response != nil) {
                
                if let data = response?["data"] as? [String:Any] {

                    if let listing = data["listings"] as? [[String:Any]] {
                        
                        let arrTemp : [PropertyModel] = Mapper().mapArray(JSONArray: listing)
                        self.arrPremiumProperties = arrTemp.filter({ (property) -> Bool in
                            return property.isPremium
                        })
                        self.arrStandardProperties = arrTemp.filter({ (property) -> Bool in
                            return !property.isPremium
                        })
                        print(self.arrPremiumProperties.count)
                        print(self.arrStandardProperties.count)
                        completion(true)
                    }else{
                        completion(false)
                    }
                }else{
                    completion(false)
                }
            } else {
                completion(false)
            }
        })
    }
}
