import 'package:demo/helpers/decimalRounder.dart';
import 'package:demo/providers/CryptoDataProvider.dart';
import 'package:demo/data/models/CryptoModel/CryptoData.dart';
import 'package:demo/data/data_source/ResponseModel.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:demo/ui/ui_helper/HomePageView.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController _pageViewController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    //  implement initState
    super.initState();

    final cryptoProvider =
        Provider.of<CryptoDataProvider>(context, listen: false);
    cryptoProvider.getTopMarketData();
  }

  final List<String> _choicesList = [
    'Top MarketCaps',
    'Top Gainers',
    'Top Losers'
  ];
  int _select = 1;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: SizedBox(
                  width: double.infinity,
                  height: 160,
                  child: Stack(
                    children: [
                      HomePageView(controller: _pageViewController),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SmoothPageIndicator(
                            onDotClicked: (index) => {
                              _pageViewController.animateToPage(index,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn)
                            },
                            controller: _pageViewController,
                            count: 4,
                            effect: const ExpandingDotsEffect(
                              dotHeight: 16,
                              dotWidth: 16,
                            ),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Consumer<CryptoDataProvider>(
                    builder: (context, CryptoDataProvider, child) {
                  var height = MediaQuery.of(context).size.height;

                  switch (CryptoDataProvider.state.status) {
                    case Status.LOADING:
                      return Text(CryptoDataProvider.state.message);
                    case Status.COMPLETED:
                      List<CryptoData>? model = CryptoDataProvider
                          .dataFuture.data!.cryptoCurrencyList;

                      return Column(
                        children: [
                             Wrap(
                  spacing: 8,
                  children: List.generate(
                      _choicesList.length,
                      (index) => ChoiceChip(
                            label: Text(_choicesList[index]),
                            selected: CryptoDataProvider.defaultChoiceIndex == index,
                            selectedColor: Colors.grey[800],
                            labelStyle: TextStyle(
                              color: CryptoDataProvider.defaultChoiceIndex  == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            labelPadding: const EdgeInsets.all(2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(color: Colors.grey),
                            ),
                            showCheckmark: false,
                            onSelected: (value) {
                             switch (index) {
                               case 0:
                                CryptoDataProvider.getTopMarketData();
                                 break;
                               case 1:
                                CryptoDataProvider.getTopGainers();
                                 break;
                               case 2:
                                CryptoDataProvider.getTopLosers();
                                 break;
                               default:
                             }
                            },
                          ))),

                          SizedBox(
                            height: 500,
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  var num = index + 1;
                                  var tokenId = model![index].id;
                                  var name = model[index].name;
                                  var symbol = model[index].symbol;
                            
                                    MaterialColor filterColor = DecimalRounder.setColorFilter(model[index].quotes![0].percentChange24h);
                          
                                    var finalPrice = DecimalRounder.removePriceDecimals(model[index].quotes![0].price);
                          
                                    // percent change setup decimals and colors
                                    var percentChange = DecimalRounder.removePercentDecimals(model[index].quotes![0].percentChange24h);
                          
                                    Color percentColor = DecimalRounder.setPercentChangesColor(model[index].quotes![0].percentChange24h);
                                    Icon percentIcon = DecimalRounder.setPercentChangesIcon(model[index].quotes![0].percentChange24h);
                          
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 4),
                                    child: SizedBox(
                                        height: height * 0.06,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("$num"),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0, right: 15),
                                              child: CachedNetworkImage(
                                                  fadeInDuration: const Duration(
                                                      milliseconds: 500),
                                                  height: 32,
                                                  width: 32,
                                                  imageUrl:
                                                      "https://s2.coinmarketcap.com/static/img/coins/32x32/$tokenId.png",
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget:
                                                      (context, url, error) {
                                                    return const Icon(Icons.error);
                                                  }),
                                            ),
                                            Flexible(
                                             fit: FlexFit.tight,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('$name',
                                                  overflow: TextOverflow.ellipsis,
                                                      style: textTheme.labelLarge),
                                                  Text(
                                                    '$symbol',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: textTheme.labelSmall,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: ColorFiltered(
                                                  colorFilter:
                                                       ColorFilter.mode(filterColor,
                                                          BlendMode.srcATop),
                                                  child: SvgPicture.network(
                                                      "https://s3.coinmarketcap.com/generated/sparklines/web/1d/2781/$tokenId.svg")),
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
                                            )
                                               )
                                          ],
                                        )),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                                itemCount: 10),
                          ),
                        ],
                      );
                    case Status.ERROR:
                      return Text(CryptoDataProvider.state.message);
                    default:
                      return Container();
                  }
                }),
              ),
              //marketData
            ],
          ),
        ),
      ),
    );
  }
}
