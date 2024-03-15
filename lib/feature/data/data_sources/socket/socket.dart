import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../core/core.dart';

class Socket {
  WebSocketChannel? channel;
  StreamSubscription? _webSocketListener;
  bool _connectCheck = false;

  final StreamController<Either<Failure, dynamic>> controller = StreamController<Either<Failure, dynamic>>.broadcast();

  Stream<Either<Failure, dynamic>> getSocketStream() => controller.stream;

  bool getConnectCheck() => _connectCheck;

  Socket() : super() {
    // _connectSocket(apiParams: PingSendApi(ping: 1));
  }

  Future<void> _connectSocket({required SendApi apiParams}) async {
    try {
      channel = WebSocketChannel.connect(Uri.parse(v3webSocket));

      channel!.sink.add("${jsonEncode(apiParams.toJson())}$preposition1");
      // channel!.sink.add('{"protocol":"json","version":1}$preposition1');
      _webSocketListener = channel?.stream.listen(
        (message) {
          // var newMessageReplace1 = message.replaceAll(preposition1, "");
          // var newMessageReplace2 = newMessageReplace1.replaceAll(preposition2, "");
          // var newMessage = json.decode(newMessageReplace2);
          var newMessage = dataConverter(message);
          print('dddddddddddddddddd: ${newMessage}');
          if (newMessage != null && newMessage.containsKey("target") && newMessage.containsKey("arguments")) {
            _connectCheck = true;
            controller.sink.add(Right(newMessage));
          } else {
            controller.sink.add(const Left(ServerFailure("There is no msg_type")));
          }
        },
        onDone: () => _onDisconnectedWeb(),
        onError: (dynamic error) => _onDisconnectedWeb(),
      );
      // _webSocketListener = channel?.stream.map<Map<String, dynamic>?>((Object? result) => jsonDecode(result.toString())).listen(
      //   (Map<String, dynamic>? message) {
      //     print('message is : $message');
      //     // if (message != null && message.containsKey("msg_type")) {
      //     //   _connectCheck = true;
      //     //   controller.sink.add(Right(message));
      //     // } else {
      //     //   controller.sink.add(const Left(ServerFailure("There is no msg_type")));
      //     // }
      //   },
      //   onDone: _onDisconnectedWeb,
      //   onError: (dynamic error) => _onDisconnectedWeb(),
      //   // onError: (Object error) {
      //   //   print('the web socket connection is closed: $error.');
      //   //   _connectSocket(sendData: '{"ping": 1}');
      //   // },
      //   // onDone: () async {
      //   //   print('web socket is closed.');
      //   //   _connectSocket(sendData: '{"ping": 1}');
      //   // },
      // );
    } catch (ex) {
      log.d(
        "Web socket is error =► $ex",
      );
      _onDisconnectedWeb();
    }
  }

  dataConverter(dynamic message) {
    try {
      var newMessageReplace1 = message.replaceAll(preposition1, "");
      var newMessageReplace2 = newMessageReplace1.replaceAll(preposition2, "");
      return json.decode(newMessageReplace2);
    } catch (error) {
      return null;
    }
  }

  void _onDisconnectedWeb() {
    log.d(
      "Web socket is disconnected",
    );
    _webSocketListener?.cancel();
    _connectCheck = false;
    // controller.sink.add(const Left(ServerFailure("Web socket is disconnected")));
    // _connectSocket(sendData: '{"ping": 1}');
  }

  bool send({required SendApi apiParams}) {
    try {
      if (channel is WebSocketChannel && channel?.closeCode == null) {
        channel!.sink.add("${jsonEncode(apiParams.toJson())}$preposition1");
      } else {
        _connectSocket(apiParams: apiParams);
      }
      return true;
    } catch (error) {
      return false;
    }
  }
}
