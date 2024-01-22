//
//  ViewPlansViewController.swift
//  storekit_demo
//
//  Created by NexG on 17/01/24.
//

import UIKit
import VLStoreKit

class ViewPlansViewController: UIViewController {
    @IBOutlet weak var plansTableView: UITableView!
    @IBOutlet weak var emptyListLabel: UILabel!
    var vlPlans: [VLPlan] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the title for the navigation bar
        self.navigationItem.title = "Plans"

        // Register the custom cell for the table view
        plansTableView.register(UINib(nibName: "PlanTableViewCell", bundle: nil), forCellReuseIdentifier: "PlanTableViewCell")

        // Initial setup for visibility of UI elements
        plansTableView.isHidden = true
        emptyListLabel.isHidden = true

        // Show loading indicator and fetch plans
        handleActivityIndicatory(isHidden: false)
        handleTableView(isHidden: true)

        SubscriptionHandler.shared.delegate = self
        SubscriptionHandler.shared.fetchPlans()
    }

    // Show an empty message on the screen
    func handleEmptyMessage(msg: String) {
        DispatchQueue.main.async {
            self.emptyListLabel.text = msg
            self.emptyListLabel.isHidden = false
        }

        // Hide the table view when showing an empty message
        handleTableView(isHidden: true)
    }

    // Show or hide the activity indicator
    func handleActivityIndicatory(isHidden: Bool) {
        isHidden ? CommonMethods.shared.hideActivityIndicator() : CommonMethods.shared.showProgressIndicator()
    }

    // Show or hide the table view and reload its data
    func handleTableView(isHidden: Bool) {
        DispatchQueue.main.async {
            self.plansTableView.isHidden = isHidden
            self.plansTableView.reloadData()
        }
    }

    // Handle the restore purchase button action
    @IBAction func restorePurchase(_ sender: Any) {
        SubscriptionHandler.shared.restorePurchase()
    }
}

extension ViewPlansViewController: UITableViewDelegate, UITableViewDataSource {
    // Number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vlPlans.count
    }

    // Configure and return a cell for a given index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlanTableViewCell", for: indexPath) as? PlanTableViewCell else {
            return UITableViewCell()
        }

        let plan = self.vlPlans[indexPath.row]

        // Configure cell with plan details
        cell.planTitleTextLabel.text = plan.name ?? ""
        cell.priceLabel.text = "\(plan.planDetails?.recurringPaymentAmount ?? 0.0)"
        cell.plan = plan
        cell.delegate = self

        return cell
    }

    // Set the height for each row in the table view
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ViewPlansViewController: PlanBuyButtonDelegate {
    // Handle the buy button tap for a specific plan
    func buyButtonTapped(_ plan: VLPlan) {
        SubscriptionHandler.shared.processPayment(selectedPlan: plan)
    }
}

extension ViewPlansViewController: SubscriptionHandlerDelegate {
    // Process the fetched plans and update UI accordingly
    func processPlans(vlPlan: [VLPlan], isSuccess: Bool) {
        handleActivityIndicatory(isHidden: true)

        if isSuccess {
            // Update plans and show/hide UI elements based on availability
            self.vlPlans = vlPlan
            handleTableView(isHidden: false)

            if self.vlPlans.isEmpty {
                handleEmptyMessage(msg: "Currently No Plans Available.")
            }
        } else {
            handleEmptyMessage(msg: "Something Went Wrong, Please try later!!")
        }
    }
}
