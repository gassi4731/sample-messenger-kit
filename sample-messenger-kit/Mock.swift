import MessageKit
import UIKit
import InputBarAccessoryView

struct User: SenderType {
    var senderId: String
    let displayName: String
}

enum userType {
    case me
    case you

    var data: SenderType {
        switch self {
        case .me:
            return User(senderId: "001", displayName: "Me")
        case .you:
            return User(senderId: "002", displayName: "You")
        }
    }
}

struct MockMessage: MessageType {

    var messageId: String
    var sender: SenderType
    var sentDate: Date
    var kind: MessageKind

    private init(kind: MessageKind, sender: SenderType, messageId: String, date: Date) {
        self.kind = kind
        self.sender = sender
        self.messageId = messageId
        self.sentDate = date
    }

    init(text: String, sender: SenderType, messageId: String, date: Date) {
        self.init(kind: .text(text), sender: sender, messageId: messageId, date: date)
    }

    init(attributedText: NSAttributedString, sender: SenderType, messageId: String, date: Date) {
        self.init(kind: .attributedText(attributedText), sender: sender, messageId: messageId, date: date)
    }

    // サンプル用に適当なメッセージ
    static func getMessages() -> [MockMessage] {
        return [
            createMessage(text: "おはよう", user: .me),
            createMessage(text: "wwwwww", user: .me),
            createMessage(text: "おはようございます", user: .you),
            createMessage(text: "wwww", user: .me),
            createMessage(text: "草", user: .you),
        ]
    }

    static func createMessage(text: String, user: userType) -> MockMessage {
        let attributedText = NSAttributedString(
            string: text,
            attributes: [.font: UIFont.systemFont(ofSize: 15), .foregroundColor: UIColor.black]
        )
        return MockMessage(attributedText: attributedText, sender: user.data, messageId: UUID().uuidString, date: Date())
    }
}
