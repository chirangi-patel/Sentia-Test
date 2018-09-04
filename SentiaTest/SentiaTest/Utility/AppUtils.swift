import Foundation
import UIKit

var appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
var DeviceWidth = UIScreen.main.bounds.size.width

func isIphoneX() -> Bool{
    return UIScreen.main.bounds.size.height == 812.0
}

func roundLayer(layer : CALayer, radius : CGFloat){
    
    layer.cornerRadius = radius
}

func borderLayer(layer : CALayer, width : CGFloat, color : UIColor){
    
    layer.borderWidth = width
    layer.borderColor = color.cgColor
}

func addShadow(layer : CALayer, color : UIColor = UIColor.black, radius : CGFloat = 5.0){
    
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = 0.15
    layer.shadowRadius = radius
    layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
    layer.masksToBounds = false
}

func addShadowCell(layer : CALayer, color : UIColor = UIColor.black, radius : CGFloat = 2.0, opacity : CGFloat = 0.4, height: CGFloat = 2.0){
    
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = 0.4
    layer.shadowRadius = 2.0
    layer.shadowOffset = CGSize(width: 0.0, height: height)
    layer.masksToBounds = false
}

func addShadowAllSides(layer : CALayer, color : UIColor = UIColor.black, radius : CGFloat = 5.0){
    
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = 0.25
    layer.shadowRadius = radius
    layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
    layer.masksToBounds = false
}

//MARK:- Loading
func showLoader(inView view:UIView) {
    
    let viewProgress = UIView(frame: view.bounds)
    viewProgress.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    let indicator = UIActivityIndicatorView(frame: viewProgress.bounds)
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    viewProgress.addSubview(indicator)
    viewProgress.tag = -9999
    view.addSubview(viewProgress)
}

func hideLoader() {
    
    if let window = UIApplication.shared.delegate?.window {
        hideLoader(inView: window!)
    }
}

func hideLoader(inView view:UIView) {
    let viewProgress = view.viewWithTag(-9999)
    if (viewProgress != nil) {
        viewProgress?.removeFromSuperview()
    }
}

extension UIColor{
    
    static func AppColor() -> UIColor {
        return UIColor(red: 42.0/255.0, green: 72.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    }
    
    static func borderColor() -> UIColor {
        return UIColor(red: 198.0/255.0, green: 198.0/255.0, blue: 198.0/255.0, alpha: 1.0)
    }
    
    static func placeHolderColor() -> UIColor {
        return UIColor(red: 199.0/255.0, green: 199.0/255.0, blue: 205.0/255.0, alpha: 1.0)
    }
    static func appLightColor() -> UIColor {
        return UIColor(red: 247.0/255.0, green: 248.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    }
    
    static func appSelColor() -> UIColor {
        return UIColor(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0)
    }
}
