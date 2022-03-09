//
//  PageViewController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 06.03.2022.
//

import UIKit

class PageViewController: UIViewController {
    
    var page: Page?
    public var pageIndex: Int = 0
    private var html: String = "<style>body {background-color: black; color: white; }h1 {background-color: black; color: white; }p {background-color: black; color: white; }</style><body><h1>Заголовок</h1><p> Текст</p></body>"
    
    func setupPage() {
        let page = Page()
        page.setHtml(html: html)
        view.addSubview(page)
        page.pin(to: view)
        self.page = page
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPage()
    }
    
    convenience init(pageIndex: Int, html: String) {
        self.init()
        self.pageIndex = pageIndex
        self.html = html
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
