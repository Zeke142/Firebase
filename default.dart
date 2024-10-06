import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';  // For authentication

// FirebaseDataConnect class handles Firestore data operations.
class FirebaseDataConnect {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Method to add data to a specified Firestore collection.
  Future<void> addData(String collection, Map<String, dynamic> data) async {
    try {
      await firestore.collection(collection).add(data);
      print("Data added successfully to $collection");
    } catch (e) {
      print("Failed to add data: $e");
    }
  }

  // Method to retrieve data from a specified Firestore collection.
  Future<QuerySnapshot> getData(String collection) async {
    try {
      QuerySnapshot snapshot = await firestore.collection(collection).get();
      return snapshot;
    } catch (e) {
      print("Failed to retrieve data: $e");
      rethrow;
    }
  }

  // Method to update data in Firestore by document ID.
  Future<void> updateData(String collection, String docId, Map<String, dynamic> newData) async {
    try {
      await firestore.collection(collection).doc(docId).update(newData);
      print("Data updated successfully in $collection/$docId");
    } catch (e) {
      print("Failed to update data: $e");
    }
  }

  // Method to delete data in Firestore by document ID.
  Future<void> deleteData(String collection, String docId) async {
    try {
      await firestore.collection(collection).doc(docId).delete();
      print("Data deleted successfully in $collection/$docId");
    } catch (e) {
      print("Failed to delete data: $e");
    }
  }
}

// ConnectorConfig class for managing API configuration settings.
class ConnectorConfig {
  String apiKey;
  String databaseURL;

  // Constructor for setting API key and database URL.
  ConnectorConfig({required this.apiKey, required this.databaseURL});

  // Method to configure the connector with the provided API key and database URL.
  void configure() {
    print("Connector configured with API Key: $apiKey and Database URL: $databaseURL");
  }
}

// DefaultConnector class to set up and use the ConnectorConfig.
class DefaultConnector {
  // Method to configure the connector using the ConnectorConfig class.
  void setupConnector() {
    ConnectorConfig config = ConnectorConfig(apiKey: "your-api-key", databaseURL: "your-database-url");
    config.configure();
  }
}

// Enum to define various SDK types.
enum CallerSDKType {
  type1,
  type2,
  type3
}

// Example usage of FirebaseDataConnect and CallerSDKType in the main application.
void main() async {
  FirebaseDataConnect dataConnect = FirebaseDataConnect();

  // Adding data to a Firestore collection.
  await dataConnect.addData("users", {"name": "John Doe", "age": 30});

  // Retrieving data from a Firestore collection.
  QuerySnapshot users = await dataConnect.getData("users");
  for (var doc in users.docs) {
    print(doc.data());
  }

  // Updating data in Firestore.
  await dataConnect.updateData("users", "documentId", {"age": 31});

  // Deleting data in Firestore.
  await dataConnect.deleteData("users", "documentId");

  // Setting the SDK type.
  CallerSDKType sdkType = CallerSDKType.type1;
  print("SDK Type set to: $sdkType");
}