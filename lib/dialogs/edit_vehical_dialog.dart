import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehical_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:vehical_app/blocs/transport_delete_bloc/transport_delete_bloc.dart';
import 'package:vehical_app/blocs/transport_driver/transport_driver_bloc.dart';
import 'package:vehical_app/pages/driver/driver_page.dart';
import 'package:vehical_app/pages/vehical_state/vehical_state_page.dart';

// Виджет, который нас уносит в изменение карточки
class EditVehicalDialog extends StatelessWidget {
  const EditVehicalDialog({
    super.key,
    required this.id,
    required this.status,
    required this.transportModel,
    required this.driver,
  });

  final int id;
  final String driver;
  final String status;
  final String transportModel;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Изменить карточку'),
      actions: [
        CupertinoDialogAction(
          child: Text('Поменять водителя'),
          onPressed: () async {
            // Код который переносит нас на на страницу с изменением водителя
            final String userId =
                context.read<AuthBloc>().supabase.auth.currentUser!.id;
            context
                .read<TransportDriverBloc>()
                .add(TransportDriverLoadEvent(userId));
            Navigator.of(context).pop();
            await Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) {
                  return DriverPage(
                    id: id,
                    status: status,
                    transportModel: transportModel,
                  );
                },
              ),
            );
          },
        ),
        CupertinoDialogAction(
          child: Text('Поменять статус'),
          onPressed: () async {
            Navigator.of(context).pop();
            // Код который нас перенесёт на изменение состояния
            await Navigator.push(context,
                CupertinoPageRoute(builder: (context) {
              return VehicalStatePage(
                id: id,
                driver: driver,
                transportModel: transportModel,
              );
            }));
          },
        ),
        CupertinoDialogAction(
          // Код с удалением карточки, если нажимаем Удалить
          // переносимся на другой диалог с конечным выбором
          isDestructiveAction: true,
          child: Text('Удалить'),
          onPressed: () {
            Navigator.of(context).pop();
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text('Удаление'),
                    content: const Text(
                        'Вы уверены что хотите удалить эту карточку?'),
                    actions: [
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: Text('Нет'),
                        onPressed: () {
                          return Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('Да'),
                        onPressed: () async {
                          // Вызываем евент из bloc для удаления
                          Navigator.of(context).pop();
                          context.read<TransportDeleteBloc>().add(
                                TransportDeleteEvent(
                                    id, driver, transportModel, status),
                              );
                        },
                      ),
                    ],
                  );
                });
          },
        ),
      ],
    );
  }
}
