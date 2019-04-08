import 'dart:async';

class Validators {
  final validateCardHolderName = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardHolderName, sink) {
    RegExp('[a-zA-Z]').hasMatch(cardHolderName)
        ? sink.add(cardHolderName)
        : sink.addError('Enter valid name');
  });

  final validateCardNumber = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardNumber, sink) {
    //1st Regular Expression to Validate Credit Card Number
    RegExp(r'^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\d{3})\d{11})$')
            //2nd Regular Expression to remove white spaces
            .hasMatch(cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), ''))
        ? sink.add(cardNumber)
        : sink.addError('Enter a valid card number');
  });

  final validateCardMonth = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardMonth, sink) {
    if (cardMonth.isNotEmpty &&
        int.parse(cardMonth) > 0 &&
        int.parse(cardMonth) < 13) {
      sink.add(cardMonth);
    } else {
      sink.addError('Invalid month');
    }
  });

  final validateCardYear = StreamTransformer<String, String>.fromHandlers(
      handleData: (cardYear, sink) {
    if (cardYear.isNotEmpty &&
        int.parse(cardYear) > 2000 &&
        int.parse(cardYear) < 2028) {
      sink.add(cardYear);
    } else {
      sink.addError('Invalid year');
    }
  });

  final validateCardVerificationValue =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (cardCvv, sink) {
    if (cardCvv.length > 2) {
      sink.add(cardCvv);
    } else {
      sink.addError('Invalid cvv');
    }
  });
}
