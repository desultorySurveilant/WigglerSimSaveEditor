import 'dart:convert';
import 'dart:html';
import 'defaultSave.dart';
Map save = jsonDecode(defaultSave);
DivElement output = querySelector("#output");

void main() {
  output.append(FileUploader());
  output.appendHtml("<br/>");
  output.append(SaveEditor());
}

DivElement SaveEditor(){
  DivElement editor = DivElement()
    ..style.border = "1px solid black"
    ..style.width = "700px"
    ..id = "editor";
  editor.append(UniversalSaveBits());
  editor.append(PetList());
  return editor;
}
DivElement UniversalSaveBits(){
  DivElement universals = DivElement()
    ..style.display = "flex"
    ..style.flexDirection = "row"
    ..style.flexWrap = "wrap"
    ..style.padding = "10px";
  universals.append(CaretakerNameInput());
  universals.append(LastPlayedInput());
  universals.append(CaegerInput());
  universals.append(LastAllowenceInput());
  universals.append(CaretakerDollInput());
  return universals;
}
DivElement PetList(){
  DivElement petList = DivElement()
    ..style.display = "flex"
    ..style.flexDirection = "column"
    ..style.padding = "10px";
  for(Map pet in save["PetInventory"]["petsList"]){
    petList.append(PetDiv(pet));
  }
  return petList;
}
DivElement PetDiv(Map pet){
  DivElement petDiv = DivElement()..style.padding = "10px"..style.border = "1px solid black";

  return petDiv;
}
LabelElement CaretakerNameInput(){
  LabelElement nameLabel = LabelElement() ..text = "Caretaker Name: ";
  TextInputElement nameInput = TextInputElement()..value = save["name"];
  nameInput.onChange.listen((e){
    save["name"] = nameInput.value;
  });
  nameLabel.append(nameInput);
  return nameLabel;
}
LabelElement CaretakerDollInput(){
  LabelElement caretakerDollLabel = LabelElement()
    ..text = "Caretaker Dollstring: "
    ..style.display = "flex"
    ..style.flexBasis = "100%";
  TextAreaElement caretakeDollInput = TextAreaElement()
    ..value = save["dataString"]
    ..rows = 3
    ..cols = 60
    ..style.wordBreak = "break-all";
  caretakeDollInput.onChange.listen((e){
    save["dataString"] = caretakeDollInput.value;
  });
  caretakerDollLabel.append(caretakeDollInput);
  return caretakerDollLabel;
}
LabelElement LastPlayedInput(){
  LabelElement LPLabel = LabelElement() ..text = "Last Played: ";
  NumberInputElement LPInput = NumberInputElement()..value = save["lastPlayed"];
  LPInput.onChange.listen((e){
    save["lastPlayed"] = LPInput.value;
  });
  LPLabel.append(LPInput);
  return LPLabel;
}
LabelElement CaegerInput(){
  LabelElement caegerLabel = LabelElement() ..text = "Caegers: ";
  NumberInputElement caegerInput = NumberInputElement()..value = save["caegers"];
  caegerInput.onChange.listen((e){
    save["caegers"] = caegerInput.value;
  });
  caegerLabel.append(caegerInput);
  return caegerLabel;
}
LabelElement LastAllowenceInput(){
  LabelElement label = LabelElement() ..text = "Last Allowence: ";
  NumberInputElement input = NumberInputElement()..value = save["lastAllowence"];
  label.onChange.listen((e){
    save["lastAllowence"] = input.value;
  });
  label.append(input);
  return label;
}
InputElement FileUploader(){
  InputElement fileElement = InputElement()..type = "file"..style.textAlign = "center";
  fileElement.innerHtml = "Load Save";

  fileElement.onChange.listen((e) {
    File file = fileElement.files.first;
    FileReader reader = FileReader();
    reader.readAsText(file);
    reader.onLoadEnd.first.then((e) {
      save = unfuckJson(reader.result);
      querySelector("#editor").replaceWith(SaveEditor());
    });
  });
  return fileElement;
}
Map unfuckJson(String saveString){
  Map save = jsonDecode(saveString);
  save["PetInventory"] = jsonDecode(save["PetInventory"]);
  save["PetInventory"]["petsList"] = jsonDecode(save["PetInventory"]["petsList"]) as List;
  save["PetInventory"]["empress"] = jsonDecode(save["PetInventory"]["empress"]);
  save["PetInventory"]["alumni"] = jsonDecode(save["PetInventory"]["alumni"]) as List;
  for(Map pet in save["PetInventory"]["petsList"]){
    pet["remembered"] = parseJsonList(pet["remembered"]);
    pet["rememberedNames"] = parseJsonList(pet["rememberedNames"]);
    pet["rememberedCastes"] = parseJsonList(pet["rememberedCastes"]);
  }{//empress
    save["PetInventory"]["empress"]["remembered"] = parseJsonList(save["PetInventory"]["empress"]["remembered"]);
    save["PetInventory"]["empress"]["rememberedNames"] = parseJsonList(save["PetInventory"]["empress"]["rememberedNames"]);
    save["PetInventory"]["empress"]["rememberedCastes"] = parseJsonList(save["PetInventory"]["empress"]["rememberedCastes"]);
  }for(Map alum in save["PetInventory"]["alumni"]){
    alum["remembered"] = parseJsonList(alum["remembered"]);
    alum["rememberedNames"] = parseJsonList(alum["rememberedNames"]);
    alum["rememberedCastes"] = parseJsonList(alum["rememberedCastes"]);
  }
  save["ItemInventory"] = jsonDecode(save["ItemInventory"]);
  save["ItemInventory"]["itemList"] = jsonDecode(save["ItemInventory"]["itemList"]) as List;
  for(Map item in save["ItemInventory"]["itemList"]){
    item["itemAppearances"] = jsonDecode(item["itemAppearances"]) as List;
  }
  return save;
}
List<String> parseJsonList(String jsonList){
  return jsonList.substring(1, jsonList.length - 1).split(", ");
}