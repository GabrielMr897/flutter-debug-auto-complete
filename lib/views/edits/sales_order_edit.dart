import 'package:debug_auto_complete/consumers/sales_order_consumer.dart';
import 'package:debug_auto_complete/models/customer_model.dart';
import 'package:debug_auto_complete/models/price_table_model.dart';
import 'package:debug_auto_complete/models/sales_order_model.dart';
import 'package:debug_auto_complete/views/builders/sales_order_builder.dart';
import 'package:debug_auto_complete/views/edits/controllers/sales_order_edit_controller.dart';
import 'package:debug_auto_complete/views/lists/customer_list.dart';
import 'package:flutter/material.dart';
import 'package:folly_fields/crud/abstract_edit.dart';
import 'package:folly_fields/crud/abstract_function.dart';
import 'package:folly_fields/fields/model_field.dart';
import 'package:folly_fields/fields/string_field.dart';
import 'package:folly_fields/responsive/responsive.dart';

///
///
///
class SalesOrderEdit extends AbstractEdit<SalesOrderModel, SalesOrderBuilder,
    SalesOrderConsumer, SalesOrderEditController> {
  ///
  ///
  ///
  const SalesOrderEdit(
    super.model,
    super.uiBuilder,
    super.consumer, {
    required super.edit,
    required SalesOrderEditController super.editController,
    super.key,
  });

  ///
  ///
  ///
  @override
  List<Responsive> formContent(
    BuildContext context,
    SalesOrderModel model,
    String labelPrefix,
    Function(bool refresh) refresh,
    bool Function() formValidate,
    SalesOrderEditController? editController, {
    required bool edit,
  }) {
    return <Responsive>[
      /// id
      if (model.id != null)
        StringField(
          labelPrefix: labelPrefix,
          label: 'Número do Pedido',
          enabled: false,
          textAlign: TextAlign.left,
          initialValue: model.id.toString(),
          sizeLarge: 2,
          sizeMedium: 6,
          sizeSmall: 12,
        ),

      /// Customer
      ModelField<CustomerModel>(
        labelPrefix: labelPrefix,
        label: 'Cliente*',
        initialValue: model.customer,
        routeBuilder: (BuildContext context) =>
            const CustomerList(selection: true),
        acceptChange: (CustomerModel? customer) async =>
            editController!.updateCustomer(context, model, customer),
        validator: (CustomerModel? value) =>
            value == null ? 'Informe o cliente.' : null,
        sizeLarge: 5,
        sizeMedium: 6,
        sizeSmall: 12,
        onSaved: (CustomerModel? value) => model.customer = value,
      ),

      ModelField<PriceTableModel>(
        labelPrefix: labelPrefix,
        label: 'Tabela de Preço*',
        controller: editController!.priceTableController,
        routeBuilder: (BuildContext context) =>
            const CustomerList(selection: true),
        validator: (PriceTableModel? value) =>
            value == null ? 'Informe a tabela de preço.' : null,
        sizeLarge: 5,
        sizeMedium: 6,
        sizeSmall: 12,
        onSaved: (PriceTableModel? value) => model.priceTable = value,
      )
    ];
  }
}

///
///
///
class SalesOrderEditFromSalesOrderList extends SalesOrderEdit
    implements AbstractModelFunction<SalesOrderModel> {
  ///
  ///
  ///
  SalesOrderEditFromSalesOrderList({
    SalesOrderModel? model,
    SalesOrderBuilder uiBuilder = const SalesOrderBuilder(),
    SalesOrderEditController? editController,
    SalesOrderConsumer consumer = const SalesOrderConsumer(),
    Key? key,
  }) : super(
          model ?? SalesOrderModel(),
          uiBuilder,
          editController: editController ?? SalesOrderEditController(),
          consumer,
          edit: true,
          key: key,
        );

  ///
  ///
  ///
  @override
  List<String> get routeName => const <String>['copy'];

  ///
  ///
  ///
  @override
  Future<bool> showButton(
    BuildContext context,
    SalesOrderModel object, {
    required bool selection,
  }) async =>
      true;

  ///
  ///
  ///
  @override
  Future<Widget?> onPressed(
    BuildContext context,
    SalesOrderModel object, {
    required bool selection,
  }) async =>
      SalesOrderEdit(
        SalesOrderModel.toCopy(object),
        const SalesOrderBuilder(),
        editController: SalesOrderEditController(),
        const SalesOrderConsumer(),
        edit: true,
      );
}
