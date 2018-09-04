//
//  PropertyDetailVC.swift
//  SentiaTest
//
//  Copyright © 2018 Chirangi Dudhat. All rights reserved.
//

import UIKit

class PropertyDetailVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var tvId : UITextView!
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad, animated: false)
        self.title = "Property Details"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PropertyDetailVC: PropertySelectionDelegate {
    
    func propertySelected(_ newProperty: PropertyModel) {
        //Set id of selected property
        tvId.text = newProperty.id
    }
}
