import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

abstract class ContactsService {
  Future<List<String>?> getContacts();
}

class ContactsServiceImpl implements ContactsService {
  final FlutterContacts contacts;
  //final PhoneNumberUtil phoneNumberUtil;

  //ContactsServiceImpl(this.contacts, this.phoneNumberUtil);
  ContactsServiceImpl(this.contacts);
  @override
  Future<List<String>?> getContacts() async {
    if (await FlutterContacts.requestPermission(readonly: true)) {
      List<String> phoneNumbers = [];
      List<Contact> contacts =
      await FlutterContacts.getContacts(withProperties: true);
      for (var contact in contacts) {
        if (contact.phones.isNotEmpty) {
          for (var phone in contact.phones) {
            try {
              /*PhoneNumber parsedPhoneNumber =
              await phoneNumberUtil.parse(phone.number, regionCode: 'HU');*/
              //phoneNumbers.add(parsedPhoneNumber.e164);
            } catch (e) {}
          }
        }
      }
      return phoneNumbers;
    } else {
      return null;
    }
  }
}