//
//  CoverViewController.swift
//  Shelves
//
//  Created by Vsevolod Melnik on 14.03.2022.
//

import UIKit
import PDFKit
import RichEditorView

class CoverViewController: UIViewController {
    
    var pdfRenderer: RichEditorView?
    
    var notebook: Notebook?
    var cover: CoverView?
    let picker = UIColorPickerViewController()
    
    func setupRenderer() {
        let pdfRenderer = RichEditorView()
        pdfRenderer.backgroundColor = .black
        pdfRenderer.webView.backgroundColor = .black
        pdfRenderer.webView.isOpaque = false
        pdfRenderer.html = "";
        view.addSubview(pdfRenderer)
        pdfRenderer.pinLeft(to: view.leadingAnchor, 5)
        pdfRenderer.pinRight(to: view.trailingAnchor, 5)
        pdfRenderer.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, 5)
        pdfRenderer.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 5)
        pdfRenderer.alpha = 0
              
        self.pdfRenderer = pdfRenderer
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRenderer()
        
        picker.delegate = self
        view.backgroundColor = .black
        
        let cover = CoverView(frame: view.frame, notebook: notebook!, coverController: self)
        view.addSubview(cover)
        cover.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        cover.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        cover.pinLeft(to: view.leadingAnchor)
        cover.pinRight(to: view.trailingAnchor)
        cover.cover?.setupRouter(router: self)
        self.cover = cover
        // Do any additional setup after loading the view.
    }
    
    convenience init(notebook: Notebook) {
        self.init()
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

extension CoverViewController: CoverViewControllerProtocol {
    func saveAsPdf() {
        do {
            let pdf: PDFDocument = PDFDocument()
            var pagesDone: Int = 0
            for page in notebook!.pages {
                pdfRenderer!.html = page // TODO: check if it is really loaded.
                let renderedPage = pdfRenderer?.webView.exportAsPdfFromWebView()
                pdf.insert((PDFDocument(data: Data(renderedPage!))?.page(at: 0))!, at: pagesDone)
                pagesDone += 1
            }
            
            let data = pdf.dataRepresentation()!
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            let docDirectoryPath = paths[0]
            let pdfPath = docDirectoryPath.appendingPathComponent("\(notebook!.name).pdf")
            try data.write(to: pdfPath)
            
            let alert = UIAlertController(title: "Готово", message: "Файл экспортирован в PDF", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } catch {
            print("PDF creating error " + error.localizedDescription)
        }
    }
    
    func changeCoverColor() {
        picker.selectedColor = UIColor(cgColor: CGColor.colorFrom(hex: notebook!.bookColor ?? "#888888") ?? CGColor(gray: 0.8, alpha: 1))

        self.present(picker, animated: true, completion: nil)
    }
}

extension CoverViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        notebook?.bookColor = CGColor.hexFrom(color: viewController.selectedColor.cgColor)
        cover?.cover?.setColor(color: viewController.selectedColor.cgColor)
        if let notebook = notebook {
            NotebookController.saveNotebook(notebook: notebook)
        }
    }
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        notebook?.bookColor = CGColor.hexFrom(color: viewController.selectedColor.cgColor)
        cover?.cover?.setColor(color: viewController.selectedColor.cgColor)
        if let notebook = notebook {
            NotebookController.saveNotebook(notebook: notebook)
        }
    }
}

extension CoverViewController: ViewControllerRouter {
    func openNotebook(notebook: Notebook) {
        changeCoverColor()
    }
    
    func deleteNotebook(notebook: Notebook) {
        return
    }
    
    func renameNotebook(notebook: Notebook, newName: String) {
        do {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                in: .userDomainMask).first {
                let oldName = notebook.name
                notebook.name = newName
                try FileManager.default.moveItem(at: documentDirectory.appendingPathComponent(oldName + ".shelves"), to: documentDirectory.appendingPathComponent(newName + ".shelves"))
                // Rename images folder.
                let folderURL = documentDirectory.appendingPathComponent("\(oldName)")
                let folderExists = (try? folderURL.checkResourceIsReachable()) ?? false
                if !folderExists {
                    try FileManager.default.moveItem(at: folderURL, to: documentDirectory.appendingPathComponent("\(newName)"))
                }
            }
        } catch {
            print("Can't rename file \(notebook.name) to \(newName) \(error)")
        }
    }
    
    func moveNotebook(notebook: Notebook, shelf: Int) {
        return
    }
    
    
}
