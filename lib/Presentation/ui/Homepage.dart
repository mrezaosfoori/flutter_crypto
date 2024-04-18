
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:demo/Presentation/ui/ui_helper/HomePageView.dart';
import 'package:demo/Presentation/ui/ui_helper/ThemeSwitcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../data/data_source/ResponseModel.dart';
import '../../data/models/CryptoModel/CryptoData.dart';
import '../../logic/providers/CryptoDataProvider.dart';
import '../helpers/decimalRounder.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageViewController = PageController(
    initialPage: 0,
  );

  final List<String> _choicesList = ['Top MarketCaps', 'Top Gainers', 'Top Losers'];

  @override
  Widget build(BuildContext context) {

    final cryptoProvider = Provider.of<CryptoDataProvider>(context);

    var height = MediaQuery.of(context).size.height;

    var primaryColor = const Color(0xff704F38);
    TextTheme textTheme = Theme.of(context).textTheme;


    return Scaffold(
      // drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: const [
          ThemeSwitcher(),
        ],
        title: const Text("Home"),
        titleTextStyle: textTheme.titleLarge,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [

              // PageView
              Padding(
                padding: const EdgeInsets.only(top: 10.0,left: 5,right: 5),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      HomePageView(controller: _pageViewController),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: SmoothPageIndicator(
                            controller: _pageViewController,
                            count:  4,
                            effect: const ExpandingDotsEffect(
                                dotWidth: 10,
                                dotHeight: 10
                            ),
                            onDotClicked: (index) => _pageViewController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

             

             const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0XFFA13D2D))),
                          onPressed: null,
                          child: Text(
                            "Buy",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Color(0XFF6A6E09))),
                          onPressed: null,
                          child: Text(
                            "Sell",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                    )
                  ],
                ),
              ),

              ///choicechip
           SizedBox(height: 10,),

              /// choice chip
              Padding(
                padding: const EdgeInsets.only(right: 5.0, left: 5),
                child: Row(
                  children: [
                    Consumer<CryptoDataProvider>(
                      builder: (context, cryptoDataProvider, child){
                          return Wrap(
                          spacing: 8,
                          children: List.generate(_choicesList.length, (index) {
                            return ChoiceChip(
                                label: Text(
                                    _choicesList[index],
                                    style: textTheme.titleSmall),
                                selected: cryptoDataProvider.defaultChoiceIndex == index,
                                selectedColor: Colors.blue,
                                onSelected: (value){
                                    switch(index){
                                      case 0:
                                        cryptoProvider.getTopMarketCapData();
                                        break;
                                      case 1:
                                        cryptoProvider.getTopGainersData();
                                        break;
                                      case 2:
                                        cryptoProvider.getTopLosersData();
                                        break;
                                    }
                                }
                            );
                          }),
                        );
                        },
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 500,
                child: Consumer<CryptoDataProvider>(
                    builder: (context, cryptoDataProvider,child){
                      switch(cryptoDataProvider.state.status){
                        case Status.LOADING:
                          return SizedBox(
                            height: 80,
                            child: Shimmer.fromColors(
                                child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index){
                                      return Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 8.0,bottom: 8,left: 8),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 30,
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 8.0, left: 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: SizedBox(
                                                      width: 25,
                                                      height: 15,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),                                                       ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: SizedBox(
                                              width: 70,
                                              height: 40,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: Colors.white,
                                                ),                                               ),
                                            ),
                                          ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            child: Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  SizedBox(
                                                    width: 50,
                                                    height: 15,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        color: Colors.white,
                                                      ),                                                     ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top: 8.0),
                                                    child: SizedBox(
                                                      width: 25,
                                                      height: 15,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: Colors.white,
                                                        ),                                                       ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                ),
                                baseColor: Colors.grey.shade400,
                                highlightColor: Colors.white
                            ),
                          );
                        case Status.COMPLETED:
                          List<CryptoData>? model = cryptoDataProvider.dataFuture.data!.cryptoCurrencyList;

                          // print(model![0].symbol);
                          return ListView.separated(
                              itemBuilder: (context, index){

                                var number = index + 1;
                                var tokenId = model![index].id;

                                MaterialColor filterColor = DecimalRounder.setColorFilter(model[index].quotes![0].percentChange24h);

                                var finalPrice = DecimalRounder.removePriceDecimals(model[index].quotes![0].price);

                                // percent change setup decimals and colors
                                var percentChange = DecimalRounder.removePercentDecimals(model[index].quotes![0].percentChange24h);

                                Color percentColor = DecimalRounder.setPercentChangesColor(model[index].quotes![0].percentChange24h);
                                Icon percentIcon = DecimalRounder.setPercentChangesIcon(model[index].quotes![0].percentChange24h);


                                return SizedBox(
                                  height: height * 0.075,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0),
                                        child: Text(number.toString(),style: textTheme.bodySmall,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 15),
                                        child: CachedNetworkImage(
                                          fadeInDuration: const Duration(milliseconds: 500),
                                          height: 32,
                                          width: 32,
                                          imageUrl: "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) {
                                            return const Icon(Icons.error);
                                          }
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.tight,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(model[index].name!,style: textTheme.bodySmall,),
                                            Text(model[index].symbol!,style: textTheme.labelSmall,),
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                          fit: FlexFit.tight,
                                          child: ColorFiltered(
                                              colorFilter: ColorFilter.mode(filterColor, BlendMode.srcATop),
                                              child: SvgPicture.network("https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg")),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Text("\$$finalPrice",style: textTheme.bodySmall,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  percentIcon,
                                                  Text(percentChange + "%",style: GoogleFonts.ubuntu(color: percentColor, fontSize: 13),),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (context, index){
                                return const Divider();
                              },
                              itemCount: 10
                          );
                        case Status.ERROR:
                          return Text(cryptoDataProvider.state.message);
                        default:
                          return Container();
                      }
                    }
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
