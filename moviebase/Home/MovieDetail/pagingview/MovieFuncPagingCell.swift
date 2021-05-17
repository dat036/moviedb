
import Parchment
import UIKit

class MovieFuncPagingCell: PagingCell {
    
    lazy var lbTitle: UILabel = {
        let lbTitle = UILabel(frame: .zero)
        lbTitle.font = UIFont.boldSystemFont(ofSize: 17)
        lbTitle.textColor = .white
        return lbTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let insets = UIEdgeInsets(top: 10, left: 15, bottom: 5, right: 0)
        
        lbTitle.frame = CGRect(
            x: 0,
            y: insets.top,
            width: contentView.bounds.width,
            height: contentView.bounds.height - insets.bottom
        )
        print(lbTitle.bounds.width)
        print("========")
        print(contentView.bounds.width)
        print("========")
    }
    
    fileprivate func configure() {
        lbTitle.textColor = UIColor.white
        lbTitle.textAlignment = .left
        addSubview(lbTitle)
    }
    
    fileprivate func updateSelectedState(selected: Bool) {
        if selected {
            lbTitle.textColor = .black
        } else {
            lbTitle.textColor = .lightGray
        }
    }
    
    override func setPagingItem(_ pagingItem: PagingItem, selected: Bool, options: PagingOptions) {
        let movieFuncItem = pagingItem as! PagingIndexItem
        lbTitle.text = movieFuncItem.title
        updateSelectedState(selected: selected)
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
    }
}

struct MovieFuncItem: PagingItem, Hashable {
    let title: String
    let index: Int

    init(title: String, index: Int) {
        self.title = title
        self.index = index
    }

    /// By default, isBefore is implemented when the PagingItem conforms
    /// to Comparable, but in this case we want a custom implementation
    /// where we also compare IconItem with PagingIndexItem. This
    /// ensures that we animate the page transition in the correct
    /// direction when selecting items.
    func isBefore(item: PagingItem) -> Bool {
        if let item = item as? PagingIndexItem {
            return index < item.index
        } else if let item = item as? Self {
            return index < item.index
        } else {
            return false
        }
    }
}
