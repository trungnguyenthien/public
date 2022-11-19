//
//  NavigationViewController.swift
//  MyApp
//
//  Created by Trung on 28/10/2022.
//

import UIKit

class NavigationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func didTapTestPushButton(_ sender: Any) {
        let vc = SampleViewController(colorName: randomColorName(), delegate: self)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NavigationViewController: SampleViewDelegate {
    func sampleViewController(_ sender: SampleViewController, didTapButton: UIButton) {
        let vc = SampleViewController(colorName: randomColorName(), delegate: self)
        sender.navigationController?.pushViewController(vc, animated: true)
    }
}
