**Platforms**
This package is successfully tested in Android,iOS.

```dart
 class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Demo Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Search Items and Select',
            ),
            const SizedBox(
              height: 10,
            ),
            DropDownSelector(
              listOfItems: const [
                "1",
                "2",
                "3",
                "4",
                "5",
                "6"
              ],
              title: "Select Items",
              onChanged: (List list) {
                //selected items from the list will get here.
              },
            ),
          ],
        ),
      ),
    );
  }
}

 ```