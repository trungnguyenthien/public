//
//  SampleViewController.swift
//  MyApp
//
//  Created by Trung on 28/10/2022.
//

import UIKit

protocol SampleViewDelegate {
    func sampleViewController(_ sender: SampleViewController, didTapButton: UIButton)
}

class SampleViewController: UIViewController {
    private let myColor: UIColor
    @IBOutlet weak var myTitleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    private let myTitle: String
    private let delegate: SampleViewDelegate?
    init(colorName: ColorName, delegate: SampleViewDelegate? = nil) {
        
        self.myColor = colorName.color
        self.myTitle = colorName.name
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = myColor
        if(myColor.isLight == true) {
            myTitleLabel.textColor = .black
            navigationController?.navigationBar.tintColor = .black
        } else {
            myTitleLabel.textColor = .white
            navigationController?.navigationBar.tintColor = .white
        }
       
        myTitleLabel.text = myTitle
        button.isVisible = delegate != nil
        
    }

    @IBAction func didTapButton(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        delegate?.sampleViewController(self, didTapButton: button)
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
