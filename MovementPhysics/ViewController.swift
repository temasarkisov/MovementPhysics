import UIKit
 
class ViewController: UIViewController {
    private let squareView: UIView = UIView()
 
    private var animator: UIDynamicAnimator?
    private var snapBehavior: UISnapBehavior?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTapGesture()
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnimator()
    }
}
 
extension ViewController {
    private func setupUI() {
        view.backgroundColor = .white
        setupSquare()
    }
 
    private func setupSquare() {
        squareView.backgroundColor = .systemBlue
        squareView.layer.cornerRadius = 10
        squareView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(squareView)
 
        NSLayoutConstraint.activate([
            squareView.widthAnchor.constraint(equalToConstant: 100),
            squareView.heightAnchor.constraint(equalToConstant: 100),
            squareView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            squareView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
 
extension ViewController {
    private func setupAnimator() {
        let animator = UIDynamicAnimator(referenceView: view)
        
        let collisionBehavior = UICollisionBehavior(items: [squareView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        let snapBehavior = UISnapBehavior(
            item: squareView,
            snapTo: squareView.center
        )
        
        animator.addBehavior(collisionBehavior)
        animator.addBehavior(snapBehavior)
 
        self.animator = animator
        self.snapBehavior = snapBehavior
    }
}
 
extension ViewController {
    private func setupTapGesture() {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapView)
        )
        view.addGestureRecognizer(gesture)
    }
 
    @objc private func didTapView(sender: UITapGestureRecognizer) {
        let point = sender.location(in: view)
        snapBehavior?.snapPoint = point
    }
}
