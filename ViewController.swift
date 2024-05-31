import UIKit
import CppQt
//import std

class ViewController: UIViewController {

    override func loadView() {
        view = UIView()
        view.backgroundColor = .systemBackground

        let button = UIButton(primaryAction: .init(title: "Show Qt app") { _ in
            let executablePath = (Bundle.main.executablePath! as NSString).fileSystemRepresentation
            let dateStr = DateFormatter.localizedString(from: .init(), dateStyle: .full, timeStyle: .full)
            QtHelper.showWidget(executablePath, .init(dateStr))
        })
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
