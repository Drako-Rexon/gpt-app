import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gemini_app/providers/gemini_provider.dart';
import 'package:gemini_app/models/chat_model.dart';
import 'package:gemini_app/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> _messages = [];
  bool isLoading = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    getChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        shadowColor: Colors.blue,
        elevation: 4,
        // backgroundColor: Colors.blue,
        title: const Text('Gemini Pro'),
        actions: [
          IconButton(
            onPressed: deleteChat,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Stack(
        children: [
          _messages.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(80),
                    child: SvgPicture.asset(
                      Constant.geminiLogo,
                      width: double.infinity,
                    ),
                  ),
                )
              : Container(),
          SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: _messages[index].isUser ? 30 : 10,
                        right: _messages[index].isUser ? 10 : 30,
                        top: 10,
                        bottom: 10,
                      ),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.only(
                          topRight: _messages[index].isUser
                              ? const Radius.circular(0)
                              : const Radius.circular(14),
                          topLeft: _messages[index].isUser
                              ? const Radius.circular(14)
                              : const Radius.circular(0),
                          bottomLeft: const Radius.circular(14),
                          bottomRight: const Radius.circular(14),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue[100]!,
                            blurRadius: 6,
                            spreadRadius: 2.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    await Clipboard.setData(ClipboardData(
                                        text: _messages[index].text));
                                  },
                                  icon: const Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () async {
                                    await Clipboard.setData(ClipboardData(
                                            text: _messages[index].text))
                                        .then((_) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Copied to your clipboard !')));
                                    });
                                  },
                                  icon: const Icon(Icons.copy)),
                              Text(
                                "${_messages[index].time.hour}:${_messages[index].time.minute}",
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                          SelectableText(_messages[index].text),
                        ],
                      ),
                    );
                  },
                ),
                isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Lottie.asset('assets/animation/loading-1.json'))
                    : Container(),
                const SizedBox(height: 70)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 11,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _controller,
                      decoration: const InputDecoration(
                          hintText: "Enter your prompt",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          contentPadding: EdgeInsets.all(8)),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      splashColor: Colors.blue[100],
                      onPressed: sentMessage,
                      icon: const Icon(Icons.send),
                      highlightColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getChat() {
    setState(() {
      _messages =
          Provider.of<GeminiProProvider>(context, listen: false).messages;
      isLoading = false;
    });
  }

  void sentMessage() async {
    if (_controller.text.isEmpty) return;

    _messages.add(
        ChatModel(text: _controller.text, time: DateTime.now(), isUser: true));
    String text = _controller.text;
    _controller.clear();

    getChat();

    setState(() {
      isLoading = true;
    });
    await Provider.of<GeminiProProvider>(context, listen: false)
        .sentMessage(context, text, DateTime.now());
    getChat();
  }

  void deleteChat() {
    Provider.of<GeminiProProvider>(context, listen: false).deleteChat();
    getChat();
  }
}
