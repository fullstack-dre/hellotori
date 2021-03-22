part of 'widgets.dart';

class IntentDialog extends StatefulWidget {

  final List<ActivityIntent>? intents;

  const IntentDialog({Key? key, this.intents}) : super(key: key);

  @override
  _IntentDialogState createState() => _IntentDialogState();
}

class _IntentDialogState extends State<IntentDialog> {

  bool isDefault = true;
  List<bool> isAnswerPage = [false, false];

  ActivityIntent targetIntent = ActivityIntent(
    title: "",
    multipleChoices: [],
    answer: "",
    isActive: true,
    description: "",
    id: ""
  );
  TextEditingController controller = TextEditingController();

  String alphanumGenerator(int index){
    return index == 0
      ? "A"
      : index == 1
        ? "B"
        : index == 2
          ? "C"
          : index == 3
            ? "D"
            : "";
  }

  bool answerReviewer(String answer){
    return answer == targetIntent.answer
      ? true
      : false;
  }

  @override
  Widget build(BuildContext context) {

    final onboardingViewModel = context.read(onboardingViewModelProvider);
    List activityIntentRaw = jsonDecode(onboardingViewModel.firestoreLiveKey);
    List<ActivityIntent> activityIntents = [];
    activityIntentRaw.forEach((element) {
      activityIntents.add(
        ActivityIntent(
          id: element["id"],
          title: element["title"],
          description: element["description"],
          multipleChoices: element["multipleChoices"], 
          answer: element["answer"], 
          isActive: element["isActive"]
        )
      );
    });

    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: MQuery.width(0.03, context)
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      elevation: 0.5,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MQuery.height(0.6, context),
          maxHeight: MQuery.height(0.8, context),
          minWidth: MQuery.width(0.7, context),
          maxWidth: MQuery.width(0.7, context)
        ),
        child: isDefault
        ? Padding(
            padding: EdgeInsets.all(MQuery.height(0.03, context)),
            child: FadeInUp(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: (){
                        Get.back();
                      },
                      icon: Icon(HelloTori.cross, size: 20)
                    )
                  ),
                  SizedBox(height: MQuery.height(0.02, context)),
                  Icon(HelloTori.horn, size: 56, color: Palette.blueAccent),
                  SizedBox(height: MQuery.height(0.015, context)),
                  Font.out(
                    title: "Notifikasi Acara",
                    fontSize: MQuery.height(0.04, context).toInt(),
                    color: Palette.blueAccent,
                    family: "EinaSemibold"
                  ),
                  SizedBox(height: MQuery.height(0.04, context)),
                  Container(
                    height: MQuery.height(0.45, context),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: widget.intents!.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding: EdgeInsets.only(bottom: MQuery.height(0.02, context)),
                          child: ListTile(  
                            onTap: (){
                              setState(() {
                                isDefault = false;
                                targetIntent = widget.intents![index];
                              });
                            },  
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: MQuery.height(0.005, context),
                              horizontal: MQuery.height(0.02, context)
                            ),
                            title: Font.out(
                              textAlign: TextAlign.start,
                              family: "EinaRegular",
                              title: widget.intents![index].title,
                              fontSize: MQuery.height(0.02, context).toInt()
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_rounded),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        : targetIntent.multipleChoices[0] == "null"       
          ? Padding(
              padding: EdgeInsets.all(MQuery.height(0.03, context)),
              child: FadeInUp(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: (){
                            setState(() {
                              isDefault = true;
                            });
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded, size: 24)
                        )
                      ),
                      SizedBox(height: MQuery.height(0.02, context)),
                      Font.out(
                        title: targetIntent.title,
                        fontSize: MQuery.height(0.04, context).toInt(),
                        color: Palette.blueAccent,
                        family: "EinaSemibold"
                      ),
                      SizedBox(height: MQuery.height(0.015, context)),
                      Linkify(
                        text: targetIntent.description ?? "",
                        style: Font.style(fontSize: MQuery.height(0.025, context).toInt() ),
                      ),
                      SizedBox(height: MQuery.height(0.04, context)),
                      Column(
                        children: [
                          Container(
                            height: MQuery.height(0.1, context),
                            child: TextField(
                              controller: controller,
                              style: Font.style(
                                fontSize: MQuery.height(0.02, context).toInt()
                              ),
                              decoration: new InputDecoration(
                                focusedBorder: new OutlineInputBorder(
                                  borderSide: BorderSide(color: Palette.blueAccent),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle: new TextStyle(color: Colors.grey[800]),
                                hintText: "Ketik jawabanmu disini...",
                                fillColor: Colors.white70
                              ),
                            ),
                          ),
                          SizedBox(height: MQuery.height(0.03, context)),
                          Container(
                            height: MQuery.height(0.075, context),
                            width: MQuery.width(0.45, context),
                            child: ElevatedButton(
                              onPressed: (){
                                if(answerReviewer(controller.text) == true){
                                  setState(() {
                                    isAnswerPage = [true, true];
                                  });
                                } else {
                                  setState(() {
                                    isAnswerPage = [true, false];
                                  });
                                }
                              },
                              child: Font.out(title: "Submit!", color: Palette.white, fontSize: MQuery.height(0.025, context).toInt()),
                              style: ElevatedButton.styleFrom(
                                primary: Palette.blueAccent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)
                                )
                              )
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          : targetIntent.multipleChoices[0] == "info"
            ? Padding(
              padding: EdgeInsets.all(MQuery.height(0.03, context)),
              child: FadeInUp(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: (){
                            setState(() {
                              isDefault = true;
                            });
                          },
                          icon: Icon(Icons.arrow_back_ios_rounded, size: 24)
                        )
                      ),
                      SizedBox(height: MQuery.height(0.02, context)),
                      Font.out(
                        title: targetIntent.title,
                        fontSize: MQuery.height(0.04, context).toInt(),
                        color: Palette.blueAccent,
                        family: "EinaSemibold"
                      ),
                      SizedBox(height: MQuery.height(0.015, context)),
                      Linkify(
                        text: targetIntent.description ?? "",
                        style: Font.style(fontSize: MQuery.height(0.025, context).toInt() ),
                      ),
                      SizedBox(height: MQuery.height(0.04, context)),                   
                    ],
                  ),
                ),
              ),
            )
            : isAnswerPage[0]
              ?  Padding(
                  padding: EdgeInsets.all(MQuery.height(0.03, context)),
                  child: FadeInUp(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: IconButton(
                              onPressed: (){
                                activityIntents.removeWhere((element) => element.id == targetIntent.id);
                                setState(() {
                                  Get.back();
                                });
                              },
                              icon: Icon(Icons.close_rounded, size: 24)
                            )
                          ),
                          SizedBox(height: MQuery.height(0.02, context)),
                          Font.out(
                            title: isAnswerPage[1] == true ? "Kamu benar!" : "Kamu salah",
                            fontSize: MQuery.height(0.04, context).toInt(),
                            color: Palette.blueAccent,
                            family: "EinaSemibold"
                          ),
                          SizedBox(height: MQuery.height(0.015, context)),
                          Linkify(
                            text: isAnswerPage[1] == true ? "Selamat!" : "Yah! Jangan menyerah ya",
                            style: Font.style(fontSize: MQuery.height(0.025, context).toInt() ),
                          ),
                          SizedBox(height: MQuery.height(0.04, context)),                   
                        ],
                      ),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(MQuery.height(0.03, context)),
                  child: FadeInUp(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            onPressed: (){
                              setState(() {
                                isDefault = true;
                              });
                            },
                            icon: Icon(Icons.arrow_back_ios_rounded, size: 24)
                          )
                        ),
                        SizedBox(height: MQuery.height(0.02, context)),
                        Font.out(
                          title: targetIntent.title,
                          fontSize: MQuery.height(0.04, context).toInt(),
                          color: Palette.blueAccent,
                          family: "EinaSemibold"
                        ),
                        SizedBox(height: MQuery.height(0.015, context)),
                        Font.out(
                          title: targetIntent.description,
                          fontSize: MQuery.height(0.025, context).toInt(),
                          color: Palette.black,
                          family: "EinaRegular"
                        ),
                        SizedBox(height: MQuery.height(0.04, context)),
                        Container(
                          height: MQuery.height(0.4, context),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: targetIntent.multipleChoices.length,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: EdgeInsets.only(bottom: MQuery.height(0.02, context)),
                                child: ListTile(
                                  onTap: (){
                                    if(answerReviewer(alphanumGenerator(index)) == true){
                                      setState(() {
                                        isAnswerPage = [true, true];
                                      });
                                    } else {
                                      setState(() {
                                        isAnswerPage = [true, false];
                                      });
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: MQuery.height(0.005, context),
                                    horizontal: MQuery.height(0.02, context)
                                  ),
                                  title: Font.out(
                                    textAlign: TextAlign.start,
                                    family: "EinaRegular",
                                    title: alphanumGenerator(index) + ". " + targetIntent.multipleChoices[index],
                                    fontSize: MQuery.height(0.0225, context).toInt()
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios_rounded),
                                ),
                              );                  
                            },
                          )
                        )
                      ],
                    ),
                  ),
              )
      )
    );
  }
}