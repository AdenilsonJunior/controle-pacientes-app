import 'package:controle_pacientes/model/section.dart';
import 'package:flutter/material.dart';

class SectionCard extends StatelessWidget {
  Section _section;
  Function(Section) callback;
  Function(String) listenCallback;
  List<String> listenSections;

  SectionCard(this.listenSections, this._section, this.callback, this.listenCallback);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Copa: ",
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 13.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 16.0, top: 16.0, bottom: 16.0),
                      child: Text(
                        _section.id,
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.0, left: 16.0),
                      child: Text(
                        "Pacientes: " + _section.patients.length.toString(),
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4.0, left: 16.0),
                        child: Text(
                          "Responsável: " + _section.responsible,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16.0, left: 16.0),
                        child: Text(
                          "Horário: " + _section.time,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 16.0, bottom: 16.0, left: 16.0),
                      child: ElevatedButton(
                          onPressed: () {
                            this.callback.call(_section);
                          },
                          child: Text('Remover')),
                    ),
                    Expanded(
                      child: Padding(padding: const EdgeInsets.only(left: 18.0),
                      child: TextButton(
                        child: Text(getListenSectionsText()),
                        onPressed: () {
                          listenCallback.call(_section.id);
                        },
                      ),),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.chevron_right,
              color: Colors.black38,
            ),
          )
        ],
      ),
    );
  }

  String getListenSectionsText() {
    if (listenSections.contains(_section.id)) {
      return "Desativar notificações";
    } else {
      return "Ativar notificações";
    }
  }
}
