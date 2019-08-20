import 'package:flutter/material.dart';
import '../ui/widgets/my_appbar.dart';
import '../ui/widgets/flip_card.dart';
import '../ui/widgets/card_front.dart';
import '../ui/widgets/card_back.dart';
import '../helpers/card_colors.dart';
import '../helpers/formatters.dart';
import '../blocs/card_bloc.dart';
import '../blocs/bloc_provider.dart';
import '../models/card_color_model.dart';
import './card_wallet.dart';

class CardCreate extends StatefulWidget {
  @override
  _CardCreate createState() => _CardCreate();
}

class _CardCreate extends State<CardCreate> {
  final GlobalKey<FlipCardState> animatedStateKey = GlobalKey<FlipCardState>();

  FocusNode _focusNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<Null> _focusNodeListener() async {
    animatedStateKey.currentState.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);
    
    // final _cardCompany = Padding(
    //   padding: const EdgeInsets.only(top: 6.0),
    //   child: DropdownMenuItem(
    //     value: 'Mastercard',
    //     child: Text('Mastercard'),
    //   ),
    // );

    final _creditCard = Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Card(
        color: Colors.grey[100],
        elevation: 0.0,
        margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child: FlipCard(
          key: animatedStateKey,
          front: CardFront(rotatedTurnsValue: 0),
          back: CardBack(),
        ),
      ),
    );

    final _cardHolderName = StreamBuilder(
        stream: bloc.cardHolderName,
        builder: (context, snapshot) {
          return TextField(
            textCapitalization: TextCapitalization.characters,
            onChanged: bloc.changeCardHolderName,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Cardholder Name',
              errorText: snapshot.error,
            ),
          );
        });

    final _cardNumber = Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: StreamBuilder(
          stream: bloc.cardNumber,
          builder: (context, snapshot) {
            return TextField(
              onChanged: bloc.changeCardNumber,
              keyboardType: TextInputType.number,
              maxLength: 19,
              maxLengthEnforced: true,
              inputFormatters: [
                MaskedTextInputFormatter(
                  mask: 'xxxx xxxx xxxx xxxx',
                  separator: ' ',
                ),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'Card Number',
                counterText: '',
                errorText: snapshot.error,
              ),
            );
          }),
    );

    final _cardMonth = StreamBuilder(
      stream: bloc.cardMonth,
      builder: (context, snapshot) {
        return Container(
           width: 50.0,
          child: TextField(
            onChanged: bloc.changeCardMonth,
            keyboardType: TextInputType.number,
            maxLength: 2,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'MM',
              counterText: '',
              errorText: snapshot.error,
            ),
          ),
        );
      },
    );

    final _cardYear = StreamBuilder(
        stream: bloc.cardYear,
        builder: (context, snapshot) {
          return Container(
            width: 60.0,
            child: TextField(
              onChanged: bloc.changeCardYear,
              keyboardType: TextInputType.number,
              maxLength: 4,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white,
                hintText: 'YYYY',
                counterText: '',
                errorText: snapshot.error,
              ),
            ),
          );
        });

    final _cardVerificationValue = StreamBuilder(
        stream: bloc.cardCvv,
        builder: (context, snapshot) {
          return Container(
            width: 70.0,
            child: TextField(
              focusNode: _focusNode,
              onChanged: bloc.changeCardCvv,
              keyboardType: TextInputType.number,
              maxLength: 3,
              maxLengthEnforced: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  counterText: '',
                  hintText: 'CVV',
                  errorText: snapshot.error),
            ),
          );
        });

    final _saveCard = StreamBuilder(
      stream: bloc.savecardValid,
      builder: (context, snapshot) {
        return Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 50,
          child: RaisedButton(
            child: Text(
              'Save Card',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.lightBlue,
            onPressed: snapshot.hasData
                ? () {
                    var blocProviderCardWallet = BlocProvider(
                      bloc: bloc,
                      child: CardWallet(),
                    );
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => blocProviderCardWallet));
                  }
                : null,
          ),
        );
      },
    );

    return new Scaffold(
        appBar: MyAppBar(
          appBarTitle: 'Create card',
          leadingIcon: Icons.arrow_back_ios,
          context: context,
        ),
        backgroundColor: Colors.grey[100],
        body: ListView(
          itemExtent: 750.0,
          padding: EdgeInsets.only(top: 30.0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: _creditCard,
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        _cardHolderName,
                        _cardNumber,
                        SizedBox(height: 12.0),
                        Wrap(
                          alignment: WrapAlignment.start,
                          runSpacing: 10,
                          children: <Widget>[
                            _cardMonth,
                            SizedBox(width: 26.0),
                            _cardYear,
                            SizedBox(width: 20.0),
                            _cardVerificationValue,
                          ],
                        ),
                        SizedBox(height: 30.0),
                        cardColors(bloc),
                        SizedBox(height: 50.0),
                        _saveCard,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget cardColors(CardBloc bloc) {
    final dotSize =
        (MediaQuery.of(context).size.width - 220) / CardColor.baseColors.length;

    List<Widget> dotList = new List<Widget>();

    for (var i = 0; i < CardColor.baseColors.length; i++) {
      dotList.add(
        StreamBuilder<List<CardColorModel>>(
          stream: bloc.cardColorsList,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () => bloc.selectCardColor(i),
                child: Container(
                  child: snapshot.hasData
                      ? snapshot.data[i].isSelected
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16.0,
                            )
                          : Container()
                      : Container(),
                  width: dotSize,
                  height: dotSize,
                  decoration: new BoxDecoration(
                    color: CardColor.baseColors[i],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dotList,
    );
  }
}
