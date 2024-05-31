import UIKit

public func addQtWindowToNativeWindow(qtWindowPtr: UnsafeRawPointer) {
    guard let rootView = UIApplication.shared.keyWindow?.rootViewController?.view else {
        fatalError("root VC view not found!")
    }

//    let qtView = unsafeBitCast(qtWindowPtr, to: UIView.self)
    let qtView = Unmanaged<UIView>.fromOpaque(qtWindowPtr).takeUnretainedValue()
    qtView.frame = rootView.bounds
    rootView.addSubview(qtView)
}
