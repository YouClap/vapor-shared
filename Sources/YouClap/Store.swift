import GoogleCloudPubSubKit
import Vapor

public final class Store: Service {
    public let databaseConnectable: MySQLDatabaseConnectable
    public let elasticSearchConnectable: ElasticSearchConnectable
    public let httpClientConnectable: HTTPClientConnectable
    public let messageQueueClient: PublisherClient

    public init(databaseConnectable: MySQLDatabaseConnectable,
                elasticSearchConnectable: ElasticSearchConnectable,
                httpClientConnectable: HTTPClientConnectable,
                messageQueueClient: PublisherClient) {
        self.databaseConnectable = databaseConnectable
        self.elasticSearchConnectable = elasticSearchConnectable
        self.httpClientConnectable = httpClientConnectable
        self.messageQueueClient = messageQueueClient
    }
}
