import '../menu/base/single_value_field.dart';
import 'utils.dart';
import 'validations.dart';

class Const {
    // serial values should be unique 
  static const nodeIdSerial = "node_id";
  static const parentIdSerial = "node_p_id";
  static const childIdSerial = "node_c_id";
  static const nodeNameSerial = "node_name";
  static const nodeAdditionalInformationSerial = "node_name";

  static SingleValueField<int> nodeIdField = SingleValueField<int>(name: Const.nodeIdSerial, message: "Enter a node id", cast: Utils.castToInt, validate: Validations.none);
  static SingleValueField<int> parentIdField = SingleValueField<int>(name: Const.parentIdSerial, message: "Enter a the parent node id", cast: Utils.castToInt, validate: Validations.none);
  static SingleValueField<int> childIdField = SingleValueField<int>(name: Const.childIdSerial, message: "Enter a the child node id", cast: Utils.castToInt, validate: Validations.none);

  static SingleValueField<String> nodeNameField = SingleValueField<String>(name: Const.nodeNameSerial, message: "Enter a the node name", cast: Utils.castToString, validate: Validations.none);
    
}