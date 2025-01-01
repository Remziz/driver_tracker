import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vehical_app/blocs/transport_on_set_state/transport_on_set_state_bloc.dart';
import 'package:vehical_app/design/styles.dart';
import 'package:vehical_app/models/states_model.dart';

class StateSelectWidget extends StatelessWidget {
  const StateSelectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SvgPicture stateImage = StateModel.stateList[0].imagePath;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: BlocBuilder<TransportOnSetStateBloc, TransportOnSetStateState>(
          builder: (context, state) {
            if (state is ChangedStateOnAdd) {
              stateImage = StateModel.getImageState(state.status);
            }
            return Row(
              children: [
                SizedBox(width: 15),
                stateImage,
                SizedBox(width: 5),
                Expanded(
                  child: BlocBuilder<TransportOnSetStateBloc,
                      TransportOnSetStateState>(
                    builder: (context, state) {
                      if (state is TransportOnSetStateInitial ||
                          state is ChangingStateOnAdd) {
                        return Text(
                          'Статус не выбран',
                          style: bodyListItemStyle,
                        );
                      } else if (state is ChangedStateOnAdd) {
                        return Column(
                          children: [
                            Text(
                              'Выбран статус:',
                              style: hintBodyListItemStyle,
                            ),
                            SizedBox(height: 5),
                            Text(
                              state.status,
                              style: bodyListItemStyle,
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      onTap: () async {
        await Navigator.of(context).pushNamed('/select_state');
      },
    );
  }
}
