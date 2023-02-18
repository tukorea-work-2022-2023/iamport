import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider<Connect>(
      create: (_) => new Connect(),
      child: MaterialApp(
        home: MyApp(),
      ),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Connect _connect = Provider.of<Connect>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Container(),
                !_connect.isCheck
                    ? ElevatedButton(
                        child: Text("Net WorkERR"),
                        onPressed: () => _connect.fetch(),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 10.0),
                            padding: EdgeInsets.all(10.0),
                            itemCount: _connect.result.length,
                            itemBuilder: (BuildContext context, int index) =>
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Payment(
                                                data: _connect.result[index])));
                                  },
                                  child: Container(
                                    color: Colors.grey,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(_connect.result[index]['title']),
                                          Text(_connect.result[index]['ea']),
                                          Text(_connect.result[index]['price']),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Payment extends StatelessWidget {
  dynamic data;

  Payment({@required this.data}) : assert(data != null);

  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: new AppBar(
        title: new Text('아임포트 결제'),
      ),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  'https://cdn.pixabay.com/photo/2020/04/01/22/14/lover-4992877__480.png'),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      /*  가맹점 식별코드 */
      userCode: '',
      /*  결제 데이터 */
      data: PaymentData.fromJson({
        'pg': 'kakaopay', // PG사
        'payMethod': 'card', // 결제수단
        'name': '아임포트 결제데이터 분석', // 주문명
        'merchantUid': 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        'amount': int.parse(data['price'].toString()), // 결제금액
        'buyerName': '홍길동', // 구매자 이름
        'buyerTel': '01012345678', // 구매자 연락처
        'buyerEmail': 'example@naver.com', // 구매자 이메일
        'buyerAddr': '서울시 강남구 신사동 661-16', // 구매자 주소
        'buyerPostcode': '06018', // 구매자 우편번호
        'appScheme': 'example', // 앱 URL scheme
        'display': {
          'cardQuota': [2, 3] //결제창 UI 내 할부개월수 제한
        }
      }),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
//        print(result);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyApp()),
            (Route<dynamic> route) => false);
      },
    );
  }
}

class Connect with ChangeNotifier {
  List _result;
  bool _isCheck = false;

  bool get isCheck => _isCheck;
  set isCheck(bool newCheck) => throw "ERR ISCHECK";

  List get result => _result;
  set result(List newResult) => throw "ERRRSETTER";

  Future<void> fetch() async {
    try {
      const String url = "http://localhost:3000/items";
      final dynamic _res = await http.get(Uri.parse(url));
      _result = json.decode(_res.body);
      _isCheck = !_isCheck;
    } catch (e) {
      _isCheck = false;
    }
    notifyListeners();
  }

  Connect() {
    this.fetch();
  }
}
