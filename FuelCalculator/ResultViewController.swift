//  Created by Roman Cebula on 28/02/2019.
//  Copyright © 2019 Roman Cebula. All rights reserved.

import UIKit

class ResultViewController: UIViewController {
    
    var data: String?

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = data
    }
    
    @IBAction func goBackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
