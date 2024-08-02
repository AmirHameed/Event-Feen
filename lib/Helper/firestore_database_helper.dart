import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_music_app/data/venue_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/band_model.dart';
import '../data/login_response.dart';

List<BandModel> dummyBands = [
  BandModel.initial(
      name: 'Coke Studio',
      description: 'This song is about love between a romantic couple',
      image: '',
      geoPoint: GeoPoint(0.0,0.0),
      location: '',
      profileId: '@amir4567',
      genre: ['Rock', 'Soft', 'Traditional'],
      googleLink: 'https:google/cokestudio.com',
      facebookLink: 'https:facebook/cokestudio.com'),
  BandModel.initial(
      name: 'Coke Studio',
      profileId: '@amir4567',
      description: 'This song is about love between a romantic couple',
      image: '',
      geoPoint: GeoPoint(0.0,0.0),
      location: '',
      genre: ['Rock', 'Soft', 'Traditional'],
      googleLink: 'https:google/cokestudio.com',
      facebookLink: 'https:facebook/cokestudio.com')
];
List<BandModel> dummyVenues = [
  BandModel.initial(
      name: 'Walt Disney Concert Hall',
      geoPoint: GeoPoint(0.0,0.0),
      location: '',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
      image: '',
      profileId: '@amir4567',
      genre: ['Rock', 'Soft', 'Traditional'],
      googleLink: 'https:google/cokestudio.com',
      facebookLink: 'https:facebook/cokestudio.com')
];

class FirestoreDatabaseHelper {
  static const String _USERS = 'users';
  static const String _BANDS = 'bands';
  static const String _VENUES = 'venues';

  final String _userId = FirebaseAuth.instance.currentUser?.uid ?? 'guest'; // Use current user ID or guest ID

  static const _timeoutDuration = Duration(seconds: 15);

  static FirestoreDatabaseHelper? _instance;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirestoreDatabaseHelper._() {
    _firebaseFirestore.settings = const Settings(persistenceEnabled: false);
  }

  static FirestoreDatabaseHelper instance() {
    _instance ??= FirestoreDatabaseHelper._();
    return _instance!;
  }

  CollectionReference<Map<String, dynamic>> get _usersReference => _firebaseFirestore.collection(_USERS);

  Future<void> insertUser(LoginResponse user) =>
      _usersReference.doc(user.uuId).set(user.toJson()).timeout(_timeoutDuration);

  Future<LoginResponse?> getUser(String uuId) async {
    try {
      final documentReference = await _usersReference.doc(uuId).get(const GetOptions(source: Source.server));
      final data = documentReference.data();
      if (data == null) return null;
      return LoginResponse.fromJson(data);
    } catch (_) {
      return null;
    }
  }

  Future<void> updateUser(dynamic object) => _updateUser(object as LoginResponse);

  Future<void> _updateUser(LoginResponse user) async {
    _usersReference.doc(user.uuId).update(user.toJson()).timeout(_timeoutDuration);
  }

  Future<void> updateFcmToken(String id, fcmToken) =>
      _firebaseFirestore.collection(_USERS).doc(id).update({'fcmToken': fcmToken}).timeout(_timeoutDuration);

  Future<List<BandModel>?> getBands() async {
    final documentReferences = await _firebaseFirestore
        .collection(_BANDS)
        .get(const GetOptions(source: Source.server))
        .timeout(_timeoutDuration);
    return documentReferences.docs.map((doc) => BandModel.fromJson(doc.data(), doc.id)).toList();
  }

  Future<List<Venue>?> getVenues() async {
    final documentReferences = await _firebaseFirestore
        .collection(_VENUES)
        .get(const GetOptions(source: Source.server))
        .timeout(_timeoutDuration);
    print('ducmentrefresen===>$documentReferences');
    return documentReferences.docs.map((doc) => Venue.fromMap(doc.data(), doc.id)).toList();
  }

  Future<void> insertBands() async {
    for (var band in dummyBands) {
      await _firebaseFirestore.collection(_BANDS).add(band.toJson());
    }
  }

  Future<void> insertVenues(Venue venue) async {
    await _firebaseFirestore.collection(_VENUES).add(venue.toJson());
  }

  ///chating
  final CollectionReference _messagesCollection = FirebaseFirestore.instance.collection('messages');
  final CollectionReference _chatThreadsCollection = FirebaseFirestore.instance.collection('chatThreads');

// Future<void> sendMessage(String content, String senderId, String recipientId, String? stadiumId) async {
//   final messageId = _messagesCollection.doc().id;
//   String chatThreadId;
//   if (stadiumId != null) {
//     chatThreadId = stadiumId;
//     await _getStadiumChatThread(stadiumId, [senderId, recipientId]);
//   } else {
//     final existingThread = await _getChatThread(senderId, recipientId);
//     print('exiting chat ===>${existingThread?.id}');
//     final participantIds = [senderId, recipientId]..sort();
//     chatThreadId = existingThread?.id ?? await _createChatThread(participantIds);
//   }
//
//   print('chat ---->$chatThreadId');
//
//   await _messagesCollection.doc(messageId).set({
//     'id': messageId,
//     'content': content,
//     'senderId': senderId,
//     'timestamp': DateTime.now(),
//     'chatThreadId': chatThreadId,
//   });
// }

  Future<void> _getStadiumChatThread(String stadiumId, List<String> participantIds) async {
    final threads = await _chatThreadsCollection.where('id', isEqualTo: stadiumId).get();
    if (threads.docs.isEmpty) {
      await _chatThreadsCollection.doc(stadiumId).set({'id': stadiumId, 'participantIds': participantIds});
    }
  }

// Get messages for a chat thread (group or one-to-one)
  Stream<QuerySnapshot> getMessages(String chatThreadId) {
    return _messagesCollection
        .where('chatThreadId', isEqualTo: chatThreadId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getLastMessage(String chatThreadId) {
    return _messagesCollection
        .where('chatThreadId', isEqualTo: chatThreadId)
        .orderBy('timestamp', descending: true)
        .limitToLast(1)
        .snapshots();
  }

// Future<ChatThread?> _getChatThread(String userId1, String userId2) async {
//   final participantIds = [userId1, userId2]..sort(); // Sort the participant IDs
//
//   final threads = await _chatThreadsCollection
//       .where('participantIds', isEqualTo: participantIds)
//       .get();
//   if (threads.docs.isEmpty) return null;
//   return ChatThread.fromMap(threads.docs.first.data() as Map<String, dynamic>);
// }

  Stream<QuerySnapshot> getChatThreadsStream(String userId) {
    final personalThreads = _chatThreadsCollection.where('participantIds', arrayContains: userId).snapshots();
    return personalThreads; // Combine streams if needed for group chats
  }

  Future<String> _createChatThread(List<String> participantIds) async {
    final threadId = _chatThreadsCollection.doc().id;
    await _chatThreadsCollection.doc(threadId).set({'id': threadId, 'participantIds': participantIds});
    return threadId;
  }

// Future<String> initiateChat(String senderId, String recipientId) async {
//   final existingThread = await _getChatThread(senderId, recipientId);
//   if (existingThread != null) {
//     return existingThread.id; // Use existing chat thread ID
//   }
//   final chatThreadId = _chatThreadsCollection.doc().id;
//   final participantIds = [senderId, recipientId]..sort();
//
//   await _chatThreadsCollection.doc(chatThreadId).set({
//     'id': chatThreadId,
//     'participantIds': participantIds
//   });
//   return chatThreadId;
// }

  /// ==========================================================================///
  ///==================================== Cart items ===============================///

  CollectionReference get _cartCollection => _firebaseFirestore
      .collection(_USERS) // Change to 'users' collection if needed
      .doc(_userId) // Add user ID subcollection
      .collection('cart'); // 'cart' subcollection within user document

// Future<void> addProductToCart(Product product) async {
//   final existingProduct = await _cartCollection
//       .where('productId', isEqualTo: product.id)
//       .get()
//       .then((querySnapshot) => querySnapshot.docs.isEmpty ? null : querySnapshot.docs.first);
//
//   if (existingProduct != null) {
//     await _cartCollection.doc(existingProduct.id).update({'quantity': existingProduct['quantity'] + 1});
//   } else {
//     await _cartCollection.add({'productId': product.id, 'quantity': 1});
//   }
// }

  Future<int> getCartCount() async {
    final snapshot = await _cartCollection.get();
    if (snapshot.docs.isEmpty) {
      return 0;
    }
    final totalQuantity = snapshot.docs.fold(0, (total, doc) => total + doc['quantity'] as int);
    return totalQuantity;
  }

// Future<List<Product>> getCartItems() async {
//   final snapshot = await _cartCollection.get();
//   final productIds = snapshot.docs.map((doc) => doc['productId']).toList();
//   print('productsIds====>$productIds');
//   final products = await getProductsList(productIds);
//   return products;
// }
  Future<Map> getCartItemsWithQuantities() async {
    try {
      final snapshot = await _cartCollection.get();
      if (snapshot.docs.isEmpty) {
        return {}; // Return empty map if no cart items exist
      }

      final cartItems = {};
      for (var doc in snapshot.docs) {
        final productId = doc['productId'];
        final quantity = doc['quantity'];
        cartItems[productId] = quantity;
      }
      return cartItems;
    } catch (e) {
      print('Error fetching cart items: $e');
      return {};
    }
  }

// Future<List<Product>> getProductsList(List<dynamic> productIds) async {
//   final products = await Future.wait(productIds.map((id) => getProduct(id)).toList());
//   print('products======>$products');
//   return products.whereType<Product>().toList(); // Filter out non-Product types (handle potential errors)
// }
// Future<List<NotificationModel>> getNotification() async {
//   final snapshot = await _firebaseFirestore
//       .collection('notifications')
//       .where('receiverId', isEqualTo: _userId)
//       .orderBy('timestamp', descending: true) // Order by latest first
//       .get();
//   final notification = snapshot.docs.map((doc) => NotificationModel.fromMap(doc.data())).toList();
//   return notification;
// }

// Future<BandModel?> getBand(String id) async {
//   final docSnapshot = await _firebaseFirestore.collection(_PRODUCTS).doc(id).get();
//   if (docSnapshot.exists) {
//     final data = docSnapshot.data()!;
//     return Product.fromJson(data, docSnapshot.id);
//   } else {
//     return null; // Handle product not found gracefully
//   }
// }

  Future<void> clearCart() async {
    final snapshot = await _cartCollection.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
