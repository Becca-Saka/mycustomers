import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_viewmodel.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';
import 'repository.dart';

@lazySingleton
class TransactionService with ReactiveServiceMixin {
  static const String _boxname = "transactionBox";

  RxValue<List<TransactionModel>> _transactions = RxValue<List<TransactionModel>>(initial: []);
  List<TransactionModel> get transactions => _transactions.value;
  List<String> formattedate = [];
  String date;
  var box = Hive.openBox<TransactionModel>(_boxname);

  TransactionModel _transaction;

  TransactionService(){
    listenToReactiveValues([_transactions]);
  }
  
  void getTransactions(int id) async{
    print(id);
    final bbox = await box;
    _transactions.value = [];
    for (var transaction in bbox.values.toList()) {
      if (transaction.cId == id){
        _transactions.value.add(transaction);
      }
    }
    _transactions.value.sort((a,b) => a.date.compareTo(b.date));
    formattedate = [];
    for(int i=0; i<transactions.length; i++) {
      if(transactions[i].cId == id){
        final dformat = new DateFormat('d MMM');
        if(dformat.format(DateTime.parse(transactions[i].date)).toString() != date) {
          date = dformat.format(DateTime.parse(transactions[i].date)).toString();
          formattedate.add(date);
        }
      }
    }
  }

  void addTransaction(TransactionModel transaction) async {
    final bbox = await box;
    await bbox.add(transaction);
    _transactions.value = [];
    for (var transactionb in bbox.values.toList()) {
      if (transactionb.cId == transaction.cId){
        _transactions.value.add(transactionb);
        print('here');
      }
    }
    _transactions.value.sort((a,b) => a.date.compareTo(b.date));
    formattedate = [];
    for(int i=0; i<transactions.length; i++) {
      if(transactions[i].cId == transaction.cId) {
        final dformat = new DateFormat('d MMM');
        if(dformat.format(DateTime.parse(transactions[i].date)).toString() != date) {
          date = dformat.format(DateTime.parse(transactions[i].date)).toString();
          formattedate.add(date);
        }
      }
    }
    print('done');
  }

}