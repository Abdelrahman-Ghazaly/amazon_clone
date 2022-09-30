import 'package:amazon_clone/constants/app_colors.dart';
import 'package:amazon_clone/model/model.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/services/services.dart';
import 'package:amazon_clone/ui/screens/entry/widgets/custom_text_field.dart';
import 'package:amazon_clone/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({Key? key}) : super(key: key);

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  bool isLoading = false;
  Uint8List? image;
  int selected = 1;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemCostController = TextEditingController();
  List<double> discountIndex = [0, 0.25, 0.50, 0.75];

  @override
  void dispose() {
    itemCostController.dispose();
    itemNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isLoading
            ? const LoadingWidget()
            : SingleChildScrollView(
                child: SizedBox(
                  height: screenSize.height,
                  width: screenSize.width,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          children: [
                            if (image == null)
                              Icon(
                                Icons.person,
                                size: screenSize.height / 10,
                                color: Colors.grey,
                              )
                            else
                              Image.memory(
                                image!,
                                height: screenSize.height / 10,
                              ),
                            IconButton(
                              onPressed: () async {
                                Uint8List? temp = await Utilities().pickImage();
                                if (temp != null) {
                                  setState(
                                    () {
                                      image = temp;
                                    },
                                  );
                                }
                              },
                              icon: const Icon(Icons.file_upload),
                            ),
                          ],
                        ),
                        Container(
                          height: screenSize.height * 0.7,
                          width: screenSize.width * 0.8,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomTextField(
                                  title: 'Item Name',
                                  controller: itemNameController,
                                  hintText: 'Enter the item\'s name',
                                ),
                                CustomTextField(
                                  title: 'Cost',
                                  controller: itemCostController,
                                  hintText: 'Enter the cost\'s price',
                                ),
                                const Text(
                                  'Discount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                                buildRadioButton(
                                    value: 1, trailingText: 'None'),
                                buildRadioButton(value: 2, trailingText: '25%'),
                                buildRadioButton(value: 3, trailingText: '50%'),
                                buildRadioButton(value: 4, trailingText: '75%'),
                              ],
                            ),
                          ),
                        ),
                        CustomButton(
                          color: kYellowColor,
                          onPressed: () async {
                            double? rawCost =
                                double.tryParse(itemCostController.text);
                            late String output;

                            setState(() {
                              isLoading = true;
                            });

                            if (rawCost != null) {
                              Product product = Product(
                                rawImage: image,
                                imageUrl: null,
                                productName: itemNameController.text,
                                cost: rawCost -
                                    (rawCost * discountIndex[selected - 1]),
                                discount: discountIndex[selected - 1],
                                uid: '0',
                                sellerName: Provider.of<UserProvider>(context,
                                        listen: false)
                                    .currentUser
                                    .name,
                                sellerUid:
                                    FirebaseAuth.instance.currentUser!.uid,
                                rating: 5,
                                numberOfRatings: 0,
                              );

                              output = await CloudFirestore()
                                  .uploadProdcutToDatabase(product);
                            } else {
                              output = 'Check the Cost Field';
                            }
                            if (output == 'Success') {
                              Utilities().showSnackBar(
                                context: context,
                                message: 'Product uploaded successfully',
                                color: Colors.green,
                              );
                            } else {
                              Utilities().showSnackBar(
                                context: context,
                                message: output,
                                color: Colors.red,
                              );
                            }

                            setState(() {
                              isLoading = false;
                            });
                          },
                          isLoading: isLoading,
                          child: const Text(
                            'Sell',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        CustomButton(
                          color: Colors.grey[200]!,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          isLoading: isLoading,
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  ListTile buildRadioButton(
      {required int value, required String trailingText}) {
    return ListTile(
      title: Text(trailingText),
      leading: Radio(
        value: value,
        groupValue: selected,
        onChanged: (int? i) {
          setState(() {
            selected = i!;
          });
        },
      ),
    );
  }
}
