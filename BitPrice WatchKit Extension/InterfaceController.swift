//
//  InterfaceController.swift
//  BitPrice WatchKit Extension
//
//  Created by muhammad Awais on 11/24/19.
//  Copyright © 2019 muhammad Awais. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var priceLabel: WKInterfaceLabel!
    @IBOutlet weak var updatingLabel: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        print("testing")
        getPrice()
    }

    func getPrice() {
        let url = URL(string: "https://api.coindesk.com/v1/bpi/currentprice.json")!
        
        URLSession.shared.dataTask(with: url) { (data:Data?, respone:URLResponse?, error:Error?) in
            if error == nil {
                print("it worked")
                
                if data != nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                        
                        guard let bpi = json["bpi"] as? [String:Any], let USD = bpi["USD"] as? [String:Any], let rateFloat = USD["rate_float"] as? Float else {
                            return
                        }
                        print(rateFloat)
                        self.priceLabel.setText("\(rateFloat)")
                        
                    } catch {
                        
                    }
                }
            }
            else
            {
                print("it's broken")
            }
        }.resume()
    }
}
