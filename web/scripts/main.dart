import 'dart:convert';
import 'dart:html';
import 'defaultSave.dart';
Map save = jsonDecode(defaultSave);
DivElement output = querySelector("#output");

void main() {
  output.append(FileUploader());
  output.appendHtml("<br/>");
  output.append(SaveEditor());
//  TextAreaElement saveDisplay = TextAreaElement();
//  output.append(saveDisplay);
//  ButtonElement showSave = ButtonElement();
//  showSave.onClick.listen((_){
//    saveDisplay.value = jsonEncode(save);
//  });
//  output.append(showSave);
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
  //universals.append(CaretakerNameInput());
  universals.append(GenericInput(save, "name", "Caretaker Name: "));
  universals.append(GenericInput(save, "lastPlayed", "Last Played: ", number: true));
  universals.append(GenericInput(save, "caegers", "Caegers: ", number: true));
  universals.append(GenericInput(save, "lastAllowence", "Last Allowence: ", number: true));
  universals.append(DollInput(save, "dataString", "Caretaker Dollstring: "));
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
  DivElement petDiv = DivElement()
    ..style.display = "flex"..style.flexWrap = "wrap"
    ..style.padding = "10px"..style.border = "1px solid black";
  petDiv.append(GenericInput(pet, "nameJSON", "Name: "));
  petDiv.append(TypeInput(pet, "TYPE", "Type: ", false));
  petDiv.append(BoolInput(pet, "isempress", "isEmpress: "));
  petDiv.append(BoolInput(pet, "corrupt", "Corrupt: "));
  petDiv.append(BoolInput(pet, "purified", "Purified: "));
  petDiv.append(GenericInput(pet, "healthJson", "Health: ", number: true));
  petDiv.append(GenericInput(pet, "hatchDate", "Hatch Date: "));
  petDiv.append(GenericInput(pet, "boredomJson", "Boredom: ", number: true));
  petDiv.append(GenericInput(pet, "lastPlayed", "Last Played: ", number: true));
  petDiv.append(GenericInput(pet, "lastFed", "Last Fed: ", number: true));
  petDiv.append(GenericInput(pet, "patience", "Patient/Impatient: ", number: true));
  petDiv.append(GenericInput(pet, "idealistic", "Idealistic/Realistic: ", number: true));
  petDiv.append(GenericInput(pet, "curious", "Curious/Accepting: ", number: true));
  petDiv.append(GenericInput(pet, "loyal", "Loyal/Free-spirited: ", number: true));
  petDiv.append(GenericInput(pet, "energetic", "Energetic/Calm: ", number: true));
  petDiv.append(GenericInput(pet, "external", "External/Internal: ", number: true));
  return petDiv;
}
LabelElement TypeInput(Map source, String loc, String text, bool showAdult){
  LabelElement label = LabelElement()..text = text..style.flexBasis = "25%";
  SelectElement input = SelectElement();
  input.append(OptionElement()..value = "EGG"..text = "Egg");
  input.append(OptionElement()..value = "GRUB"..text = "Grub");
  input.append(OptionElement()..value = "TREEBAB"..text = "Treebab");
  input.append(OptionElement()..value = "COCOON"..text = "Cocoon");
  if(showAdult){
    input.append(OptionElement()..value = "TROLL"..text = "Troll");
  }
  input.value = source[loc];
  label.append(input);
  return label;
}
LabelElement BoolInput(Map source, String loc, String text){
  LabelElement label = LabelElement()..text = text..style.flexBasis = "25%";
  bool b = source[loc] == "true" ? true : false;
  InputElement input =  CheckboxInputElement()..checked = b;
  input.onChange.listen((e){
    source[loc] = input.checked;
  });
  label.append(input);
  return label;
}
LabelElement GenericInput(Map source, String loc, String text, {number = false}){
  LabelElement label = LabelElement()..text = text..style.display = "flex";
  InputElement input = number ? NumberInputElement() : TextInputElement();
  input.style.flex = "99";
  input.value = source[loc];
  input.onChange.listen((e){
    source[loc] = input.value;
  });
  label.append(input);
  return label;
}
LabelElement DollInput(Map source, String loc, String text){
  LabelElement label = LabelElement()
    ..text = text
    ..style.display = "flex"
    ..style.flexBasis = "100%";
  TextAreaElement input = TextAreaElement()
    ..value = source[loc]
    ..rows = 3
    ..cols = 60
    ..style.wordBreak = "break-all";
  input.onChange.listen((e){
    source[loc] = input.value;
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