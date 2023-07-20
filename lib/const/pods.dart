import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../backend/auth_repo/firebase_logper_auth.dart';
import '../backend/data_manager/logper_firestore_cache.dart';
import '../backend/data_manager/logper_hive_cache.dart';
import '../backend/hub_center.dart';
import '../backend/storage_repo/firebase_storage.dart';
import '../models/viewmodels/logper_vm.dart';
import 'identity.dart';

final firebaseAuthPod = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangePod = StreamProvider.autoDispose<User?>(
    (ref) => ref.watch(firebaseAuthPod).userChanges());

final firebaseRepoPods =
    Provider<FirebaseRepo>((ref) => FirebaseRepo(ref.read));

final firestoreLogperPod = Provider<CollectionReference<Map<String, dynamic>>>(
    (ref) =>
        FirebaseFirestore.instance.collection(Identity.firestoreLogperKey));

final googleSignPod = Provider<GoogleSignIn>((ref) => GoogleSignIn());

final fireMessagePod =
    Provider<FirebaseMessaging>((ref) => FirebaseMessaging.instance);

final fireStoragePod =
    Provider<FirebaseStorage>((ref) => FirebaseStorage.instance);

final fireStorageRepoPod =
    Provider<FireStorageRepo>((ref) => FireStorageRepo(ref.read));

final logperPods = StateNotifierProvider<LogperVM, LogperAuthState>(
    (ref) => LogperVM(LogperAuthState.needAuth, ref.read));

final logperCachePods =
    Provider<LogperHiveCache>((ref) => LogperHiveCache(Identity.hiveLogperKey));

final logperFirestorePod =
    Provider<LogperFirestoreCache>((ref) => LogperFirestoreCache(ref.read));

final hubPod = Provider<Hub>((ref) => Hub(ref.read));
