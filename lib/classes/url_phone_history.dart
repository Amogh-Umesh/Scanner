import 'package:flutter/material.dart';
import 'package:scanner_app/pages/loading.dart';
import 'package:scanner_app/regex/regex.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

class UrlPhoneHistory extends StatefulWidget {
  const UrlPhoneHistory({Key? key, required this.obj,}) : super(key: key);
  final dynamic obj;
  @override
  _UrlPhoneHistoryState createState() => _UrlPhoneHistoryState();
}

class _UrlPhoneHistoryState extends State<UrlPhoneHistory> {
  @override
  Widget build(BuildContext context) {
    if(widget.obj.runtimeType == PhoneNumber){
      return Phone(phonenumber: widget.obj.phoneNumber);
    }else if(widget.obj.runtimeType == UrlLink){
      return UrlHistory(url: widget.obj.url);
    }else{
      return Container();
    }
  }
}



class UrlHistory extends StatefulWidget {
  const UrlHistory({Key? key, required this.url,}) : super(key: key);
  final String url;
  @override
  _UrlHistoryState createState() => _UrlHistoryState();
}
_launchURLApp(String linkurl) async {
  if (await canLaunch(linkurl)) {
    await launch(linkurl, enableJavaScript: true);
  } else {
    throw 'Could not launch url';
  }
}
class _UrlHistoryState extends State<UrlHistory> {

  @override
  Widget build(BuildContext context) {
    String displayUrl = '';
    if(widget.url.length > 30){
      displayUrl = widget.url.substring(0,30) + '...';
    }else{
      displayUrl = widget.url;
    }
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      elevation: 20,
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: SizedBox(
          height: 125,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                color: Colors.grey[400],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 1),
                  child: Center(
                    child: Text(
                        displayUrl,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        )

                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed:(){_launchURLApp(widget.url);}, child: Row(

                    children: const [
                      Text(
                        'Open',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.arrow_drop_up),
                    ],
                  )),
                  ElevatedButton(onPressed: (){Clipboard.setData(ClipboardData(text: widget.url));}, child: Row(
                    children: const [
                      Text(
                        'Copy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.content_copy_rounded),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Phone extends StatefulWidget {
  const Phone({Key? key, required this.phonenumber,}) : super(key: key);
  final String phonenumber;
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      elevation: 20,
      color: Colors.grey[850],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: SizedBox(
          height: 125,
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                color: Colors.grey[400],
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 1),
                  child: Center(
                    child: Text(
                        widget.phonenumber,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                        )

                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed:(){_launchURLApp('tel:' + widget.phonenumber);saveHistory(PhoneNumber(widget.phonenumber));},
                    child: const Icon(Icons.call),
                  ),
                  ElevatedButton(onPressed:(){_launchURLApp('sms:' + widget.phonenumber);saveHistory(PhoneNumber(widget.phonenumber));},
                    child: const Icon(Icons.message_outlined),
                  ),
                  ElevatedButton(onPressed: (){Clipboard.setData(ClipboardData(text: widget.phonenumber));saveHistory(PhoneNumber(widget.phonenumber));}, child: Row(
                    children: const [
                      Text(
                        'Copy',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Icon(Icons.content_copy_rounded),
                    ],
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

