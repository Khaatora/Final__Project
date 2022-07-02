import 'package:final_pro/shared/components/default_container.dart';
import 'package:flutter/material.dart';

class TaskSetting extends StatelessWidget {
  const TaskSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width/15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Setting Icon', style: TextStyle(color: Colors.blue, fontSize: 30)),
            Text('Board1 in List1 ', style: TextStyle(color: Colors.grey, fontSize: 17)),

      SizedBox(height: MediaQuery.of(context).size.height/15,),

defaultContainer(text: 'task setting', context: context,add: Column(
  children: [
    Text('asdada'),
    Text('asdada'),

  ],
),),
            SizedBox(height: 10,),
            defaultContainer(text: 'task setting', context: context,add: Column(
              children: [
                Text('asdada'),
                Text('asdada'),
                Text('asdada'),
                Text('asdada'),

              ],
            ),),
            SizedBox(height: 10,),
            defaultContainer(text: 'task setting', context: context,add: Column(
              children: [
                Text('asdada'),
                Text('asdada'),
                Text('asdada'),
                Text('asdada'),

              ],
            ),),
            SizedBox(height: 10,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      hintText: 'Write your message here...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'send',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),


          ],
        ),
      ),

    );
  }
}
