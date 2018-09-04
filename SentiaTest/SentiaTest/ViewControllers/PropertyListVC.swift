import UIKit

protocol PropertySelectionDelegate: class {
    func propertySelected(_ newProperty: PropertyModel)
}

class PropertyCell : UITableViewCell{
    
    @IBOutlet weak var vwCont : UIView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblArea : UILabel!
    @IBOutlet weak var lblBathrooms : UILabel!
    @IBOutlet weak var lblBedrooms : UILabel!
    @IBOutlet weak var lblCarspaces : UILabel!
    @IBOutlet weak var lblDesc : UILabel!
    @IBOutlet weak var lblAucDate : UILabel!
    @IBOutlet weak var lblPrice : UILabel!
}

class PropertyListVC: UIViewController {

    //MARK:- Variables
    @IBOutlet weak var scrlVW : UIScrollView!
    @IBOutlet weak var btnStandard : UIButton!
    @IBOutlet weak var btnPremium : UIButton!
    @IBOutlet weak var cnstLeadSelSep : NSLayoutConstraint!
    @IBOutlet weak var tblStandard : UITableView!
    @IBOutlet weak var tblPremium : UITableView!
    @IBOutlet weak var cnstHeightButtons : NSLayoutConstraint!
    
    //MARK:- Variables
    var arrStandardProperties : [PropertyModel] = []
    var arrPremiumProperties : [PropertyModel] = []
    weak var delegate: PropertySelectionDelegate?
    var selProperty : PropertyModel! = nil
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUI(){

        if isIphoneX(){
            //Increase height of buttons for iPhone X
            cnstHeightButtons.constant = 75.0
        }
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        tblPremium.estimatedRowHeight = 122.0
        tblPremium.rowHeight = UITableViewAutomaticDimension
        
        tblStandard.estimatedRowHeight = 122.0
        tblStandard.rowHeight = UITableViewAutomaticDimension
        
        //Gestures for Scroll View to change Standard And Premium properties
        let gestureRecognizerRight : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handlwSwipe(gesture:)))
        gestureRecognizerRight.direction = .right
        gestureRecognizerRight.delegate = self
        self.scrlVW.addGestureRecognizer(gestureRecognizerRight)
        
        let gestureRecognizerLeft : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handlwSwipe(gesture:)))
        gestureRecognizerLeft.direction = .left
        gestureRecognizerLeft.delegate = self
        self.scrlVW.addGestureRecognizer(gestureRecognizerLeft)
        
        //Initially Standard View
        btnListTypeClicked(sender: btnStandard)
        
        getPropertyList()
    }
    
    func getPropertyList(){
        
        //Get Request to get Properties
        getPropertyList(params: nil) { (isSucceed) in
            
            if isSucceed{
                if self.arrStandardProperties.count > 0{
                    //First Property is selected by default
                    self.selProperty = self.arrStandardProperties[0]
                    self.delegate?.propertySelected(self.selProperty)
                }
                self.tblStandard.reloadData()
                self.tblPremium.reloadData()
            }
        }
    }
    
    //MARK:- IBActions
    @IBAction func btnListTypeClicked(sender : UIButton){

        if sender == btnStandard{
            scrlVW.setContentOffset(CGPoint(x: 0.0, y: 0.0), animated: true)
            changeFrameForSeparator(offset: 0)
            btnStandard.isSelected = true
            btnPremium.isSelected = false
        }else{
            scrlVW.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0.0), animated: true)
            changeFrameForSeparator(offset: self.view.frame.size.width / 2)
            btnStandard.isSelected = false
            btnPremium.isSelected = true
        }
    }
    
    func changeFrameForSeparator(offset : CGFloat){
        
        UIView.animate(withDuration: 0.3) {
            self.cnstLeadSelSep.constant = offset
            self.view.layoutIfNeeded()
        }
    }
}

extension PropertyListVC : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tblStandard{
            return arrStandardProperties.count
        }else{
            return arrPremiumProperties.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PropertyCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PropertyCell
        
        var details : PropertyModel! = nil
        if tableView == tblStandard{
            details = arrStandardProperties[indexPath.row]
        }else{
            details = arrPremiumProperties[indexPath.row]
        }
        if let proSel = self.selProperty,let detTemp = details, proSel.id == detTemp.id{
            cell.vwCont.backgroundColor = UIColor.appSelColor()
        }else{
            cell.vwCont.backgroundColor = UIColor.white
        }
        cell.lblName.text = details.owner.name
        cell.lblArea.text = details.area
        cell.lblBathrooms.text = "\(details.bathrooms) \(details.bathrooms == 1 ? "bathroom" : "bathrooms")"
        cell.lblBedrooms.text = "\(details.bedrooms) \(details.bedrooms == 1 ? "bedroom" : "bedrooms")"
        cell.lblCarspaces.text = "\(details.carspaces) \(details.carspaces == 1 ? "carspace" : "carspaces")"
        cell.lblDesc.text = details.desc
        cell.lblAucDate.text = details.auctionDate
        cell.lblPrice.text = details.displayPrice
        roundLayer(layer: cell.vwCont.layer, radius: 10.0)
        borderLayer(layer: cell.vwCont.layer, width: 1.0, color: UIColor.borderColor())
        addShadowCell(layer: cell.vwCont.layer, color: UIColor.gray, radius: 2.0, opacity: 0.1,height: 2.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Change Selected Property
        if tableView == tblStandard{
            self.selProperty = arrStandardProperties[indexPath.row]
            delegate?.propertySelected(self.selProperty)
        }else{
            self.selProperty = arrPremiumProperties[indexPath.row]
            delegate?.propertySelected(self.selProperty)
        }

        if let detailVC = delegate as? PropertyDetailVC, let detailNavigation = detailVC.navigationController {
            //Display Detail of Property
            splitViewController?.showDetailViewController(detailNavigation, sender: nil)
        }
        
        tblStandard.reloadData()
        tblPremium.reloadData()
    }
}

extension PropertyListVC : UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func handlwSwipe(gesture : UISwipeGestureRecognizer){
        
        //Change View when horizontal scrolls
        if gesture.direction == .right{
            
            if btnPremium.isSelected{
                btnListTypeClicked(sender: btnStandard)
            }
        }else if gesture.direction == .left{
            
            if btnStandard.isSelected{
                btnListTypeClicked(sender: btnPremium)
            }
        }
    }
    
}
