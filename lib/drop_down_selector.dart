library drop_down_selector;

import 'package:flutter/material.dart';

final List selectedData = [];

class DropDownSelector<T> extends StatefulWidget {
  final List listOfItems;
  final Color? containColor;
  final String title;
  final Color? buttonColor;
  final String? textFieldHint;
  final Function(List<T?>) onChanged;
  final Function(List<T?>)? onDone;
  final Color? checkBoxColor;
  final Color? tickColor;
  final String? buttonTitle;
  final String? sheetTitle;
  const DropDownSelector(
      {super.key,
      this.onDone,
      this.containColor,
      required this.listOfItems,
      required this.title,
      required this.onChanged,
      this.textFieldHint,
      this.checkBoxColor,
      this.tickColor,
      this.buttonColor,
      this.buttonTitle,
      this.sheetTitle});

  @override
  State<DropDownSelector> createState() => _DropDownSelectorState();
}

class _DropDownSelectorState extends State<DropDownSelector> {
  TextEditingController searchController = TextEditingController();
  List listOfData = [];
  @override
  void initState() {
    listOfData = widget.listOfItems;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        readOnly: true,
        cursorColor: Colors.black,
        onTap: () {
          showModalBottomSheet(
              isScrollControlled: true,
              isDismissible: true,
              useSafeArea: true,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(25),
                  topStart: Radius.circular(25),
                ),
              ),
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.sheetTitle ?? "Items to select",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                widget.buttonColor ??
                                                    Colors.blue)),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      if (widget.onDone != null) {
                                        widget.onDone!(selectedData);
                                      }
                                    },
                                    child: Text(
                                      widget.buttonTitle ?? "Done",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    listOfData.clear();
                                    listOfData = widget.listOfItems;
                                  });
                                } else {
                                  setState(() {
                                    listOfData = widget.listOfItems
                                        .where((item) => item
                                            .toLowerCase()
                                            .startsWith(value.toLowerCase()))
                                        .toList();
                                  });
                                }
                              },
                              controller: searchController,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  prefixIcon: const Icon(
                                    Icons.search,
                                    color: Color(0xffAFAFAF),
                                  ),
                                  suffixIcon: searchController.text.isEmpty
                                      ? null
                                      : InkWell(
                                          onTap: () {
                                            searchController.clear();

                                            setState(() {
                                              listOfData.clear();
                                              listOfData = widget.listOfItems;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.clear,
                                            color: Color(0xff131313),
                                          )),
                                  contentPadding: const EdgeInsets.all(10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Color(0xffFFFFFF)),
                                  ),
                                  hintText: widget.textFieldHint ?? "Search",
                                  hintStyle: const TextStyle(
                                      color: Color(0xffAFAFAF),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Expanded(
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Divider(
                                      thickness: 0.5,
                                    ),
                                  );
                                },
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listOfData.length,
                                itemBuilder: (context, index) {
                                  final data = listOfData[index];
                                  return CheckboxListTile(
                                      checkColor:
                                          widget.tickColor ?? Colors.white,
                                      activeColor:
                                          widget.checkBoxColor ?? Colors.blue,
                                      title: Text("$data"),
                                      value: selectedData.contains(data),
                                      onChanged: (value) {
                                        setState(() {
                                          value == true
                                              ? selectedData.add(data)
                                              : selectedData.remove(data);
                                          widget.onChanged(selectedData);
                                        });
                                      });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.containColor ?? Colors.black12,
          contentPadding:
              const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
          hintText: widget.title,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}
