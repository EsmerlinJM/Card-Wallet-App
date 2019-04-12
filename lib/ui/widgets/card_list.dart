import '../../blocs/card_list_bloc.dart';
import 'package:flutter/material.dart';
import '../../models/card_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './card_chip.dart';

class CardList extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return StreamBuilder<List<CardResults>>(
      stream: cardListBloc.cardList,
      builder: (context, snapshot){
        return Column(
          children: <Widget>[
            !snapshot.hasData 
              ? CircularProgressIndicator() 
              : SizedBox(
                height: _screenSize.height * 0.8,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index){
                    return CardFromList(
                      cardModel: snapshot.data[index],
                    );
                  },
                  itemCount: snapshot.data.length,
                  itemWidth: _screenSize.width * 0.61,
                  itemHeight: _screenSize.height * 0.52,
                  layout: SwiperLayout.STACK,
                  scrollDirection: Axis.vertical,
                ),
              )  
          ],
        );
      },
    );
  }
}

// Crear en un nuevo archivo e importarlo
class CardFromList extends StatelessWidget {
  final CardResults cardModel;

  CardFromList({this.cardModel});

  @override
  Widget build(BuildContext context) {
    final _cardLogo = Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 25.0, right: 52.0),
          child: Image(
            image: AssetImage('assets/visa_logo.png'),
            width: 65.0,
            height: 32.0,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 52.0),
          child: Text(
            cardModel.cardType,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.w400
            ),
          ),
        )
      ],
    );

    final _cardNumber = Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildDots()
        ],
      ),
    );

    final _cardLastNumber = Padding(
      padding: const EdgeInsets.only(top: 1.0, left: 55.0),
      child: Text(
        cardModel.cardNumber.substring(12),
        style: TextStyle(color: Colors.white, fontSize: 8.0),
      ),
    );

    final _cardValidThru = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'Valid',
                style: TextStyle(color: Colors.white, fontSize: 8.0),
              ),
              Text(
                'thru',
                style: TextStyle(color: Colors.white, fontSize: 8.0),
              )
            ],
          ),
          SizedBox(width: 5.0),
          Text(
            '${cardModel.cardMonth}/${cardModel.cardYear.substring(2)}',
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          )
        ],
      ),
    );
    
    final _cardOwner = Padding(
      padding: const EdgeInsets.only(top: 15.0, left: 50.0),
      child: Text(
        cardModel.cardHolderName,
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
    );
    
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: cardModel.cardColor
      ),
      child: RotatedBox(
        quarterTurns: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _cardLogo,
            CardChip(),
            _cardNumber,
            _cardLastNumber,
            _cardValidThru,
            _cardOwner
          ],
        ),
      ),
    );
  }

  Widget _buildDots(){
    List<Widget> dotList = List<Widget>();
    var counter = 0;
    for (var i = 0; i < 12; i++) {
      counter += 1;
      dotList.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Container(
            width: 9.0,
            height: 9.0,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
          ),
        )
      );
      if(counter == 4){
        counter = 0;
        dotList.add(SizedBox(width: 50.0));
      }
    }
    dotList.add(_buildNumbers());
    return Row(children: dotList);
  }

  Widget _buildNumbers(){
    return Text(
        cardModel.cardNumber.substring(12),
        style: TextStyle(color: Colors.white),
    );
  }
}