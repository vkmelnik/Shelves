//
//  PageViewController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 06.03.2022.
//

import UIKit

class PageController: UIViewController {
    
    var page: Page?
    public var pageIndex: Int = 0
    private var notebook: Notebook = Notebook()
    
    func setupPage() {
        let page = Page()
        page.setHtml(html: notebook.pages[pageIndex])
        view.addSubview(page)
        page.pin(to: view)
        self.page = page
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        notebook.pages[pageIndex] = page?.editor?.html ?? ""
        do {
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(notebook)
            let json = String(data: jsonData, encoding: .utf8)

            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first {
                let pathWithFilename = documentDirectory.appendingPathComponent(notebook.name + ".shelves")
                try json!.write(to: pathWithFilename,
                                    atomically: true,
                                    encoding: .utf8)
            }
        } catch {
            print("Unable to save notebook.")
        }
    }
    
    convenience init(pageIndex: Int, notebook: Notebook) {
        self.init()
        self.pageIndex = pageIndex
        self.notebook = notebook
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
