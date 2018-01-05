//
//  UserAlert
//  OnTheMap
//
//  Created by Frank Giarratani on 2018/01/05.
//  Copyright © 2018 Frank Giarratani. All rights reserved.
//

import Foundation
import UIKit

class UserAlert {

    class func popUpAlert(view: UIViewController, message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        performUIUpdatesOnMain {
            view.present(alert, animated: true, completion: nil)
        }
    }
    
}
