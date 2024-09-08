import 'package:dio/dio.dart';
import 'package:expense_tracker/local_storage/local_storage.dart';

class Transaction {
  final int id;
  final String type;
  final String note;
  final double amount;
  final String date;

  Transaction(
    this.id,
    this.type,
    this.note,
    this.amount,
    this.date,
  );

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['transaction_id'],
        type = json['type'],
        note = json['note'],
        amount = json['amount'].toDouble(),
        date = json['updated_at'].substring(0, 10);

  static Future<List<Transaction>> getAllTransaction() async {
    List<Transaction> listTransaction = [];
    try {
      var response = await Dio().get(
        "http://10.0.2.2:8000/api/transaction",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.token}",
          },
        ),
      );

      List<dynamic> data = response.data['data'];

      for (var x in data) {
        listTransaction.add(Transaction.fromJson(x));
      }

      return listTransaction;
    } catch (e) {
      // if (e is DioException) {
      //   print(e);
      // }

      return listTransaction;
    }
  }

  static Future<List<Transaction>> getTransactionByDate(
      String from, String to) async {
    List<Transaction> listTransaction = [];
    try {
      var response = await Dio().get(
        "http://10.0.2.2:8000/api/date/transaction",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.token}",
          },
        ),
        data: {
          "from": from,
          "to": to,
        },
      );

      List<dynamic> data = response.data['data'];

      for (var x in data) {
        listTransaction.add(Transaction.fromJson(x));
      }

      return listTransaction;
    } on DioException catch (e) {
      // if (e is DioException) {
      //   print(e);
      // }
      print(e);
      return listTransaction;
    }
  }

  static Future<bool> createTransaction(
      num amount, String note, String type) async {
    try {
      await Dio().post(
        "http://10.0.2.2:8000/api/transaction",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.token}",
          },
        ),
        data: {
          "note": note,
          "amount": amount,
          "type": type,
        },
      );

      return true;
    } on DioException catch (e) {
      // if (e is DioException) {
      //   print(e);
      // }
      print(e.response);
      return false;
    }
  }
}

class WeeklyTransaction {
  final String daysName;
  final int day;
  final double total;

  WeeklyTransaction(this.daysName, this.day, this.total);

  WeeklyTransaction.fromJson(Map<String, dynamic> json)
      : daysName = json['daysname'],
        day = json['day'],
        total = double.parse(json['total']);

  static Future<List<WeeklyTransaction>> getWeeklyTransaction() async {
    List<WeeklyTransaction> weeklyTransaction = [];
    try {
      var response = await Dio().get(
        "http://10.0.2.2:8000/api/weekly/transaction",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${LocalStorage.token}",
          },
        ),
      );

      List<dynamic> data = response.data['data'];

      for (var x in data) {
        weeklyTransaction.add(WeeklyTransaction.fromJson(x));
      }

      return weeklyTransaction;
    } catch (e) {
      // if (e is DioException) {
      //   print(e);
      // }

      return weeklyTransaction;
    }
  }
}

// var listTransaction1 = [
//   Transaction("Makanan", "Ayam Geprek", 15000, "15 August 2024"),
//   Transaction("Other", "Mobil", 15000, "16 August 2024"),
//   Transaction("Pakaian", "Baju", 100000, "17 August 2024"),
// ];
