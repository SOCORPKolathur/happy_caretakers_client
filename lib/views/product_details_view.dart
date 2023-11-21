import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
import '../constants.dart';
import '../models/product_model.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.productId,required this.productName,required this.userDocId});

  final String productId;
  final String productName;
  final String userDocId;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {

  ProductModel currentProduct = ProductModel();
  List<String> categories = [];

  // bool isAltredyInCart(List<CartModel> carts, String itemId){
  //   bool isAltreadyIn = false;
  //   carts.forEach((element) {
  //     if(element.productId == itemId){
  //       isAltreadyIn = true;
  //     }
  //   });
  //   return isAltreadyIn;
  // }
  //
  // getQuantity(List<CartModel> carts, String itemId){
  //   int quantity = 0;
  //   carts.forEach((element) {
  //     if(element.productId == itemId){
  //       quantity = element.quantity!;
  //     }
  //   });
  //   return quantity;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Constants.appBackgroundolor,
        appBar: AppBar(
          backgroundColor: Constants.primaryAppColor,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back,color: Colors.white),
          ),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance.collection('Eccomerce').doc(widget.productId).get(),
          builder: (ctx, snap){
            if(snap.hasData){
              currentProduct = ProductModel.fromJson(snap.data!.data() as Map<String,dynamic>);
              categories.clear();
              categories.addAll(currentProduct.categoty!.split(','));
              return SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: (){
                        showImageModel(context,currentProduct.img!);
                      },
                      child: Container(
                        height: size.height/3.036,
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                image: NetworkImage(
                                    currentProduct.img!
                                )
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: width/30,vertical: height/50.4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: width/1.44,
                                child: Text(
                                  currentProduct.productname!,
                                  maxLines: 4,
                                  style: GoogleFonts.urbanist(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: width/20,
                                  ),
                                ),
                              ),
                              Text(
                                "₹${currentProduct.price!}",
                                style: GoogleFonts.urbanist(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: width/22.5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height/37.95),
                          Text(
                            'Description',
                            style: GoogleFonts.urbanist(
                              color: Constants.primaryAppColor,
                              fontWeight: FontWeight.w700,
                              fontSize: width/24
                            ),
                          ),
                          SizedBox(height: size.height/75.9),
                          Text(
                            currentProduct.description!,
                            style: GoogleFonts.urbanist(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: width/25.714
                            ),
                          ),
                          SizedBox(height: size.height/75.9),
                          Text(
                            'Categories',
                            style: GoogleFonts.urbanist(
                              color: Constants.primaryAppColor,
                              fontWeight: FontWeight.w700,
                              fontSize: width/25.714
                            ),
                          ),
                          SizedBox(height: size.height/75.9),
                          SizedBox(
                            height: size.height/18.975,
                            width: size.width,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (ctx,i){
                                return Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: width/36.0),
                                  child: Container(
                                    height: size.height/18.975,
                                    decoration: BoxDecoration(
                                      color: Constants.primaryAppColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Center(
                                      child: Padding(
                                        padding:  EdgeInsets.symmetric(horizontal: width/18,vertical: 0),
                                        child: Text(
                                          categories[i],
                                          style: GoogleFonts.urbanist(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: width/25.714
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: size.height/75.9),
                          SizedBox(height: size.height/75.9),
                          Text(
                            'Related Products',
                            style: GoogleFonts.urbanist(
                              color: Constants.primaryAppColor,
                              fontWeight: FontWeight.w700,
                              fontSize: width/25.714
                            ),
                          ),
                          SizedBox(height: size.height/75.9),
                          SizedBox(
                            height: size.height/3.608333333,
                            width: size.width,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance.collection('Eccomerce').snapshots(),
                              builder: (ctx, snapshot) {
                                if (snapshot.hasData) {
                                  List<ProductModel> products = snapshot.data!.docs.map((e) => ProductModel.fromJson(e.data())).toList();
                                  return ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: products.length,
                                    itemBuilder: (ctx,i){
                                      return InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (ctx)=> ProductDetailsView(productId: products[i].id!,productName: products[i].productname!,userDocId: widget.userDocId)));
                                        },
                                        child: Padding(
                                          padding:  EdgeInsets.symmetric(horizontal: width/36.0),
                                          child: Container(
                                            width: size.width/2.305882352941176,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 4,
                                                  offset: Offset(2, 3),
                                                )
                                              ],
                                            ),
                                            padding:  EdgeInsets.symmetric(horizontal:width/45,vertical: height/94.5),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: size.height/5.421428571428571,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,//
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: NetworkImage(
                                                        products[i].img!,
                                                      ),
                                                    ),
                                                  ),
                                                  width: double.infinity,
                                                ),
                                                SizedBox(height: size.height/90),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: size.height/28.866666667,
                                                      child: Text(
                                                        //maxLines: 1,
                                                        //textOverflow: TextOverflow.ellipsis,
                                                        products[i].productname!,
                                                        style: GoogleFonts.urbanist(
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: width/25.714,
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      //maxLines: null,
                                                      "₹${products[i].price!}",
                                                      style: GoogleFonts.urbanist(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: width/30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                          SizedBox(height: size.height/75.9),
                          SizedBox(height: size.height/75.9),
                          SizedBox(height: size.height/75.9),
                          SizedBox(height: size.height/75.9),
                          SizedBox(height: size.height/75.9),
                          SizedBox(height: size.height/75.9),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }return Container(
              child: Center(
                child: CircularProgressIndicator(),
                // child: Lottie.asset(
                //   'assets/churchLoading.json',
                //   fit: BoxFit.contain,
                //   height: size.height * 0.4,
                //   width: size.width * 0.7,
                // ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FutureBuilder(
        //   future: FirebaseFirestore.instance.collection('Products').doc(widget.productId).get(),
        //   builder: (ctx, snaps){
        //     if(snaps.hasData){
        //       ProductModel product = ProductModel.fromJson(snaps.data!.data() as Map<String,dynamic>);
        //       return SizedBox(
        //         height: size.height / 11,
        //         width: size.width,
        //         child: SizedBox(
        //           height: size.height / 18,
        //           child: Center(
        //               child: InkWell(
        //                   onTap: () async {
        //                     Response response = await UserFireCrud.addToCart(userDocId: widget.userDocId, price: product.price!, imgUrl: product.imgUrl!, quantity: 1, productId: product.productId!, productName: product.title!);
        //                   },
        //                   child: StreamBuilder(
        //                     stream: UserFireCrud.fetchCartsForUser(widget.userDocId),
        //                     builder: (ctx,snap){
        //                       if(snap.hasData){
        //                         List<CartModel> carts = snap.data!;
        //                         CartModel cart = CartModel();
        //                         carts.forEach((element) {
        //                           if(element.productId == widget.productId){
        //                             cart = element;
        //                           }
        //                         });
        //                         return Container(
        //                           height: size.height * 0.06,
        //                           width: size.width * 0.85,
        //                           decoration: BoxDecoration(
        //                             borderRadius: BorderRadius.circular(10),
        //                             color: Constants().primaryAppColor,
        //                           ),
        //                           child: Center(
        //                             child: isAltredyInCart(carts,widget.productId)
        //                                 ? Row(
        //                               mainAxisAlignment: MainAxisAlignment.center,
        //                               children: [
        //                                 InkWell(
        //                                   onTap: (){
        //                                     int qty = getQuantity(carts,widget.productId)-1;
        //                                     if(qty == 0){
        //                                       UserFireCrud.deleteCart(userDocId: widget.userDocId, docId: cart.productId!);
        //                                     }else{
        //                                       UserFireCrud.updateCartQuantity(userDocId: widget.userDocId, docId: cart.productId!,quantity: qty);
        //                                     }
        //                                   },
        //                                   child: Icon(
        //                                     Icons.remove_circle_outline,
        //                                     color: Colors.white,
        //                                     size: size.height * 0.045,
        //                                   ),
        //                                 ),
        //                                 SizedBox(width: size.width/31.1),
        //                                 KText(
        //                                   text: getQuantity(carts,widget.productId).toString(),
        //                                   style: GoogleFonts.openSans(
        //                                     color: Colors.white,
        //                                     fontWeight: FontWeight.bold,
        //                                     fontSize: Constants().getFontSize(context, "M"),
        //                                   ),
        //                                 ),
        //                                 SizedBox(width: size.width/31.1),
        //                                 InkWell(
        //                                   onTap:(){
        //                                     int qty = getQuantity(carts,widget.productId)+1;
        //                                     UserFireCrud.updateCartQuantity(userDocId: widget.userDocId, docId: cart.productId!,quantity: qty);
        //                                   },
        //                                   child: Icon(
        //                                     Icons.add_circle_outline,
        //                                     color: Colors.white,
        //                                     size: size.height * 0.045,
        //                                   ),
        //                                 ),
        //                               ],
        //                             )
        //                                 : InkWell(
        //                               onTap: () async {
        //                                 Response response = await UserFireCrud.addToCart(userDocId: widget.userDocId, price: product.price!, imgUrl: product.imgUrl!, quantity: 1, productId: product.productId!, productName: product.title!);
        //                               },
        //                               child: Center(
        //                                 child: KText(
        //                                   text: "Add Cart",
        //                                   style: GoogleFonts.openSans(
        //                                     color: Colors.white,
        //                                     fontWeight: FontWeight.bold,
        //                                     fontSize: Constants().getFontSize(context, "M"),
        //                                   ),
        //                                 ),
        //                               ),
        //                             ),
        //                           ),
        //                         );
        //                       }return Container();
        //                     },
        //                   )
        //               )
        //           ),
        //         ),
        //
        //       );
        //     }return Container();
        //   },
        // )
    );
  }

  showImageModel(context, String imgUrl) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return PhotoView(
          imageProvider: CachedNetworkImageProvider(
            imgUrl,
          ),
        );
      },
    );
  }

}
