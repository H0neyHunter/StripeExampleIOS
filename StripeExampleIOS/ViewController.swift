//
//  ViewController.swift
//  StripeExampleIOS
//
//  Created by Ümit Örs on 12.12.2023.
//

import UIKit
import Stripe


class ViewController: UIViewController, STPAuthenticationContext {
    func authenticationPresentingViewController() -> UIViewController {
        return self
    }
    
    @IBOutlet weak var cardNumberField: UITextField!
    @IBOutlet weak var expiryDateField: UITextField!
    @IBOutlet weak var cvcField: UITextField!
    
    
    //Client Secret key /order/checkout dan gelen client_secret key'i
    //Bu key satın alındı o yüzden kullanılamaz. Yeni sepete ekliceksin
    //Sonra checkout dan key i alıp buraya yapıştırcaksın.
    private var paymentIntentClientSecret: String = "pi_3OMTHgC......"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    @IBAction func payBtn(_ sender: Any) {
        /*
         guard let cardNumber = cardNumberField.text,
         let expiryDate = expiryDateField.text,
         let cvc = cvcField.text else { return }
         
         
         let expiryDateComponents = expiryDate.split(separator: "/")
         let expMonth = UInt(expiryDateComponents[0]) ?? 0
         let expYear = UInt(expiryDateComponents[1]) ?? 0
         */
        
        let cardParams = STPCardParams()
        cardParams.name = "Ümit Ö"
        cardParams.number = "4242424242424242"
        cardParams.expMonth = 12
        cardParams.expYear = 24
        cardParams.cvc = "827"

        let paymentMethodParams = STPPaymentMethodParams(card: STPPaymentMethodCardParams.init(cardSourceParams: cardParams), billingDetails: nil, metadata: nil)

        let paymentIntentParams = STPPaymentIntentParams(clientSecret: paymentIntentClientSecret)
        paymentIntentParams.paymentMethodParams = paymentMethodParams

        STPPaymentHandler.shared().confirmPayment(paymentIntentParams, with: self) { status, paymentIntent, error in
            switch status {
            case .succeeded:
                print("success")
            case .failed:
                print("failed")
            case .canceled:
                print("cancaled")
            @unknown default:
                print("unknown")
            }
        }
        
    }
    


}
