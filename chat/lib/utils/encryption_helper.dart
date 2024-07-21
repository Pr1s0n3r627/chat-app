import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionHelper {
  static final _key = encrypt.Key.fromLength(32); // Use a more secure key management approach in production
  static final _iv = encrypt.IV.fromLength(16);
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  static String encryptMessage(String message) {
    final encrypted = _encrypter.encrypt(message, iv: _iv);
    return encrypted.base64;
  }

  static String decryptMessage(String encryptedMessage) {
    final decrypted = _encrypter.decrypt64(encryptedMessage, iv: _iv);
    return decrypted;
  }
}
