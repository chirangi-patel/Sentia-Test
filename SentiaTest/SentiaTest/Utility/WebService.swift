//
//  WebService.swift

import UIKit
import Alamofire

class WebService: SessionDelegate {

    class func GET(withURL url:String, Parameters params:[String:AnyObject]?,completionHander:@escaping ((_ response: [String:Any]?, _ error:NSError?) -> ()))  {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (responseData) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            let stringResponse = String.init(data: responseData.data!, encoding: String.Encoding.utf8)
            print("stringResponse :  %@",stringResponse ?? AnyObject.self)
            
            switch responseData.result {
                
            case .success(let response):
                if let res = response as? [String:Any] {
                    completionHander(res, nil)
                }else{
                    completionHander(nil, nil)
                }
                break
                
            case .failure(let responseError as NSError):
                completionHander(nil, responseError)
                break
                
            default :
                completionHander(nil, nil)
                break
            }
        }
    }
}

