import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int QIndex=0;
  int scores=0;
  bool endOfQuiz=false;
  int? selected;
List<Map<dynamic,dynamic>>questionsList=[
{
  'question':'The world’s nation 5G mobile network was launched by which country?',
  'answer':['Japan','South Korea','Asia','Malaysia'],
  'value':1
},

{
  'question':'Ctrl, Shift and Alt are called .......... keys.',
  'answer':['modifier','function','alphanumeric',' adjustment'],
  'value':0
},

{
  'question':'Fathometer is used to measure',
  'answer':['Ocean depth','Earthquakes','Rainfall','Sound intensity'],
  'value':0
},

];

void ResetQuiz(){
  setState(() {
    QIndex=0;
    scores=0;
    endOfQuiz=false;
  });
  
}
 
  @override
  Widget build(BuildContext context) {
    final question=questionsList[QIndex];
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: endOfQuiz? 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  scores>questionsList.length/2?'Congratulations!':'The End...',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
            
                  Text(
                  'Your final score is: $scores/${questionsList.length} ',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8,),
                  TextButton(
                  onPressed: (){
                    ResetQuiz();
                  },
                   child: Text("Reset quiz")
                   )
              ]
            ),
          )
          
          
          :Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question['question'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16,),
               Text(
                "Answer and get points",
                style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 155, 120, 120)),
                ),
                SizedBox(height: 8,),

                Text(
                "${QIndex+1} of ${questionsList.length}",
                style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 155, 120, 120)),
                ),
                Container(
                child: LinearProgressIndicator(
                  value:((100/(question['answer'].length-1))*(QIndex+1))/100 ,
                  valueColor: new AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 45, 136, 211)),
                ),
              ),
              SizedBox(height: 16,),

              for(int i=0;i<question['answer'].length;i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          selected=i;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color:i==selected? Color.fromARGB(255, 91, 158, 213):Colors.white ,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey)
                        ),
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(question['answer'][i],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color:i==selected? Colors.white: Colors.black , 
                          ),
                          ),
                        ],
                      ),
                    ),
                      ),
                    ),
                  ),
              
              
            Spacer(),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: (){
                    setState(() {
                      if(selected!=null){
                      if(QIndex==questionsList.length-1){
                       endOfQuiz=true;
                      }
                      else{
                        QIndex++;
                      }
                      if(question['value']==selected){
                            scores++;
                      }
                       selected=null;
                      }
                
                      else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                            content: Text("Please choose one of the Answers"),
                            backgroundColor: Color.fromARGB(255, 183, 28, 28),
                            duration: Duration(seconds:1),
                            ),
                            
                          );
                          
                        }
                    });
                
                  }, 
                  child: Text("Next"),),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}

