import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:playflow/shared/themes/app_colors.dart';
import 'package:playflow/shared/themes/app_text_styles.dart';
import 'package:playflow/shared/widgets/input_text/input_text_widget.dart';
import 'package:playflow/shared/widgets/set_buttons/set_label_buttons.dart';

import 'insert_boleto_controller.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;
  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    decimalSeparator: ",",
  );

  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");
  final barcodeInputTextController = TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: BackButton(
            color: AppColors.input,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 93),
                  child: Text(
                    "Preencha os dados do boleto",
                    style: TextStyles.titleBoldHeading,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputTextWidget(
                        label: "Nome do boleto",
                        icon: Icons.description_outlined,
                        onChanged: (value) {
                          controller.onChange(name: value);
                        },
                        validator: controller.validateName,
                      ),
                      InputTextWidget(
                        controller: dueDateInputTextController,
                        label: "Vencimento",
                        icon: FontAwesomeIcons.calendarCheck,
                        onChanged: (value) {
                          controller.onChange(dueDate: value);
                        },
                        validator: controller.validateVencimento,
                      ),
                      InputTextWidget(
                        controller: moneyInputTextController,
                        label: "Valor",
                        onChanged: (value) {
                          controller.onChange(
                              value: moneyInputTextController.numberValue);
                        },
                        validator: (_) => controller.validateValor(
                            moneyInputTextController.numberValue),
                        icon: Icons.monetization_on_outlined,
                      ),
                      InputTextWidget(
                        controller: barcodeInputTextController,
                        label: "Código",
                        onChanged: (value) {
                          controller.onChange(barcode: value);
                        },
                        validator: controller.validateCodigo,
                        icon: FontAwesomeIcons.barcode,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SetLabelButtons(
          enableSecondaryColor: true,
          labelPrimary: "Cancelar",
          onTapPrimary: () {
            Navigator.pop(context);
          },
          labelSecondary: "Cadastrar",
          onTapSecondary: () async {
            await controller.cadastarBoleto();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
