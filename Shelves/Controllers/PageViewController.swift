//
//  PageViewController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 06.03.2022.
//

import UIKit

class PageViewController: UIViewController {
    
    var page: Page?
    
    func setupPage() {
        let page = Page()
        view.addSubview(page)
        page.pin(to: view)
        self.page = page
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPage()
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
