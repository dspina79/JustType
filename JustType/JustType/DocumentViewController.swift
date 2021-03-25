//
//  DocumentViewController.swift
//  JustType
//
//  Created by Dave Spina on 3/23/21.
//

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var document: Document?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissDocumentViewController))
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.title = self.document?.fileURL.deletingPathExtension().lastPathComponent
                self.textView.text = self.document?.text ?? ""
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @objc func dismissDocumentViewController() {
        document?.text = textView.text
        document?.updateChangeCount(.done)
        
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
    
    @objc func shareTapped(sender: UIBarButtonItem) {
        guard let url = document?.fileURL else { return }
        let ac = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        ac.popoverPresentationController?.barButtonItem = sender
        present(ac, animated: true)
    }
}
