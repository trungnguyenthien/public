//
//  ViewController.swift
//  MyApp
//
//  Created by Trung on 01/10/2022.
//

import UIKit

class MainViewController: UITableViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllMonster { monsters in
            MyApp.monsters = monsters
        }
        
        loadAllColorName { colorNames in
            MyApp.colorNames = colorNames
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        switch(section, row) {
        case (0, 0): present(UINavigationController(rootViewController: NavigationViewController()), animated: true)
        case (0, 1): break
        case (0, 2): break
        case (0, 3): break
        case (0, 4): break
        ////
        case (1, 0): break
        case (1, 1): break
        case (1, 2): break
        case (1, 3): break
        case (1, 4): break
        case (1, 5): break
        case (1, 6): break
        case (1, 7): break
        case (1, 8): break
        case (1, 9): break
        case (1, 10): break
            
        default: break
        }
    }
}
