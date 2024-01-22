//
//  PlanTableViewCell.swift
//  storekit_demo
//
//  Created by NexG on 17/01/24.
//

import UIKit
import VLStoreKit

class PlanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton?
    @IBOutlet weak var planTitleTextLabel: UILabel!
    var plan: VLPlan?
    weak var delegate : PlanBuyButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.buyButton?.addTarget(self, action: #selector(subscribeButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func subscribeButtonTapped(_ sender: UIButton){
        if let vlPlan = plan,
           let delegate = delegate {
            self.delegate?.buyButtonTapped(vlPlan)
        }
    }
}


protocol PlanBuyButtonDelegate: AnyObject {
    func buyButtonTapped(_ plan: VLPlan)
}

