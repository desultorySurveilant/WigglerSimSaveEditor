import 'dart:convert';
import 'dart:html';
import 'defaultSave.dart' as placeholder;
Map save = placeholder.save;
DivElement output = querySelector("#output");

void main() {
  output.append(FileUploader());
  output.append(FileSaver());
  output.appendHtml("<br/>");
  output.append(SaveEditor());
  TextAreaElement saveDisplay = TextAreaElement();
  output.append(saveDisplay);
  ButtonElement showSave = ButtonElement();
  showSave.onClick.listen((_)=> saveDisplay.value = refuckJson(save));
  output.append(showSave);
}

DivElement SaveEditor(){
  DivElement editor = DivElement()
    ..style.border = "1px solid black"
    ..style.width = "700px"
    ..id = "editor";
  editor.append(UniversalSaveBits());
  if(save["PetInventory"].containsKey("empress"))
    editor.append(EmpressDiv());
  editor.append(PetList(save["PetInventory"]["petsList"]));
  editor.append(AlumList());
  editor.append(InvList());
  return editor;
}
DivElement UniversalSaveBits(){
  DivElement universals = DivElement()
    ..style.display = "flex"
    ..style.flexDirection = "row"
    ..style.flexWrap = "wrap"
    ..style.padding = "10px";
  universals.append(GenericInput(save, "name", "Caretaker Name: ")..style.flexBasis = "100%");
  universals.append(GenericInput(save, "lastPlayed", "Last Played: ", number: true));
  universals.append(GenericInput(save, "caegers", "Caegers: ", number: true));
  universals.append(GenericInput(save, "lastAllowence", "Last Allowence: ", number: true));
  universals.append(GenericInput(save, "bgIndex", "Background: ", number: true));
  universals.append(DollInput(save, "dataString", "Caretaker Doll: "));
  return universals;
}
DivElement EmpressDiv(){
  DivElement empressDiv = DivElement()
    ..style.padding = "10px";
  empressDiv.appendHtml("Empress:");
  empressDiv.append(AlumDiv(save["PetInventory"]["empress"]));
  return empressDiv;
}
DivElement PetList(List petsList){
  DivElement petList = DivElement()
    ..style.display = "flex"
    ..style.flexDirection = "column"
    ..style.padding = "10px"
    ..appendHtml("Pets:")
    ..id = "PetList";
  for(Map pet in petsList){
    petList.append(PetDiv(pet));
  }
  petList.append(
    ButtonElement()
      ..innerHtml = "[+]"
      ..onClick.listen((_) {
        petsList.add(placeholder.pet);
        querySelector("#PetList").replaceWith(PetList(petsList));
      })
  );
  return petList;
}
DivElement AlumList(){
  DivElement alumList = DivElement()
    ..style.display = "flex"
    ..style.flexDirection = "column"
    ..style.padding = "10px"
    ..appendHtml("Alumni:");
  for(Map alum in save["PetInventory"]["alumni"]){
    alumList.append(AlumDiv(alum));
  }
  return alumList;
}
DivElement InvList(){
  DivElement invList = DivElement()
    ..style.display = "flex"
    ..style.flexDirection = "column"
    ..style.padding = "10px"
    ..appendHtml("Items:");
  for(Map item in save["ItemInventory"]["itemList"]){
    invList.append(ItemDiv(item));
  }
  return invList;
}
DivElement ItemDiv(Map item){
  DivElement itemDiv = DivElement()
    ..style.display = "flex"..style.flexWrap = "wrap"
    ..style.padding = "10px"..style.border = "1px solid black";
  itemDiv.append(GenericInput(item, "id", "ID: ", number: true)..style.flexBasis = "100%");
  itemDiv.append(GenericInput(item, "patience", "Patient/Impatient: ", number: true));
  itemDiv.append(GenericInput(item, "idealistic", "Idealistic/Realistic: ", number: true));
  itemDiv.append(GenericInput(item, "curious", "Curious/Accepting: ", number: true));
  itemDiv.append(GenericInput(item, "loyal", "Loyal/Free-spirited: ", number: true));
  itemDiv.append(GenericInput(item, "energetic", "Energetic/Calm: ", number: true));
  itemDiv.append(GenericInput(item, "external", "External/Internal: ", number: true));
  itemDiv.appendHtml("Appearances: ");
  DivElement appDiv = DivElement()
    ..style.display = "flex"..style.flexWrap = "wrap"..style.flexBasis = "100%"
    ..style.padding = "10px"..style.border = "1px solid black";
  for(int i = 0; i < item["itemAppearances"].length; i++){
    appDiv.append(GenericInput(item["itemAppearances"][i], "name", "Name $i: "));
    appDiv.append(GenericInput(item["itemAppearances"][i], "imageLoc", "Image $i: "));
  }
  itemDiv.append(appDiv);
  return itemDiv;
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
//  petDiv.append(ListInput(pet, "remembered", "Remembered Items: ", number: true));
//  petDiv.append(ListInput(pet, "rememberedNames", "Remembered Names: "));
//  petDiv.append(ListInput(pet, "rememberedCastes", "Remembered Castes: "));
  petDiv.append(DollInput(pet, "dollDATAURL", "Doll: "));
  return petDiv;
}
DivElement AlumDiv(Map alum){
  DivElement alumDiv = PetDiv(alum);
  alumDiv.children[1].replaceWith(TypeInput(alum, "TYPE", "Type: ", true));
  alumDiv.append(BigTextInput(alum, "epilogue", "Epilogue: ", 4));
  return alumDiv;
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
LabelElement GenericInput(Map source, Object loc, String text, {number = false}){
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
LabelElement ListInput(Map source, String loc, String text, {number = false}){
  LabelElement label = LabelElement()
    ..text = text
    ..style.display = "flex"
    ..style.flexWrap = "wrap"
    ..style.flexBasis = "100%";
  List l = source[loc];
  for(int i = 0; i < l.length; i++){
    InputElement input = number ? NumberInputElement() : TextInputElement();
    input.value = l[i];
    input.onChange.listen((e){
      l[i] = input.value;
    });
    label.append(input);
  }
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
LabelElement DollInput(Map source, String loc, String text){
  LabelElement label = LabelElement()
    ..text = text
    ..style.display = "flex"
    ..style.flexBasis = "100%";
  TextAreaElement input = TextAreaElement()
    ..style.flex = "99"
    ..style.wordBreak = "break-all";
  input.value = source[loc];
  input.onChange.listen((e){
    source[loc] = input.value;
  });
  label.append(input);
  return label;
}
LabelElement BigTextInput(Map source, String loc, String text, [int rows = 2]){
  LabelElement label = LabelElement()
    ..text = text
    ..style.display = "flex"
    ..style.flexBasis = "100%";
  TextAreaElement input = TextAreaElement()
    ..style.flex = "99"
    ..rows = rows;
  input.value = source[loc];
  input.onChange.listen((e){
    source[loc] = input.value;
  });
  label.append(input);
  return label;
}
AnchorElement FileSaver(){
  AnchorElement saver = AnchorElement()
    ..innerHtml = "Save edited file"
    ..target = "_blank"
    ..download = "editedWigglerSimSave.txt"
    ..href = "";//UriData.fromString(refuckJson(save), mimeType: "text/plain", encoding: Utf8Codec());
  return saver;
}
Map unfuckJson(String saveString){
  Map save = jsonDecode(saveString);
  save["PetInventory"] = jsonDecode(save["PetInventory"]);
  save["PetInventory"]["petsList"] = jsonDecode(save["PetInventory"]["petsList"]) as List;
  save["PetInventory"]["alumni"] = jsonDecode(save["PetInventory"]["alumni"]) as List;
  for(Map pet in save["PetInventory"]["petsList"]){
    pet["remembered"] = parseJsonList(pet["remembered"]);
    pet["rememberedNames"] = parseJsonList(pet["rememberedNames"]);
    pet["rememberedCastes"] = parseJsonList(pet["rememberedCastes"]);
  }
  for(Map alum in save["PetInventory"]["alumni"]){
    alum["remembered"] = parseJsonList(alum["remembered"]);
    alum["rememberedNames"] = parseJsonList(alum["rememberedNames"]);
    alum["rememberedCastes"] = parseJsonList(alum["rememberedCastes"]);
  }
  if(save["PetInventory"].containsKey("empress")){
    save["PetInventory"]["empress"] = jsonDecode(save["PetInventory"]["empress"]);
    save["PetInventory"]["empress"]["remembered"] =
        parseJsonList(save["PetInventory"]["empress"]["remembered"]);
    save["PetInventory"]["empress"]["rememberedNames"] =
        parseJsonList(save["PetInventory"]["empress"]["rememberedNames"]);
    save["PetInventory"]["empress"]["rememberedCastes"] =
        parseJsonList(save["PetInventory"]["empress"]["rememberedCastes"]);
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
String refuckJson(Map save){
  Map ret = {};
  ret["dataString"] = save["dataString"];
  ret["name"] = save["name"];
  ret["bgIndex"] = save["bgIndex"];
  ret["lastPlayed"] = save["lastPlayed"];
  ret["PetInventory"] = jsonPetInv(save["PetInventory"]);
  ret["ItemInventory"] = jsonItemInv(save["ItemInventory"]);
  ret["caegers"] = save["caegers"];
  ret["lastAllowence"] = save["lastAllowence"];
  return jsonEncode(ret);
}
String jsonPetInv(Map petInv){
  String ret = "{";
  ret += '"petsList":"${jsonPetsList(petInv["petsList"])}",';
  if(save["PetInventory"].containsKey("empress")){
    ret += '"empress":"${petToJson(save["PetInventory"]["empress"])}",';
  }
  ret += '"alumni":"${jsonPetsList(petInv["alumni"])}"';
  ret += '}';
  return ret;
}
String jsonPetsList(List petsList){
  List<String> ret = [];
  for(Map pet in petsList){
    ret.add(petToJson(pet));
  }
  return ret.toString();
}
String petToJson(Map pet) {
  String ret = "{";
  for (String k in pet.keys) {
    ret += '"$k":"${pet[k].toString()}",';
  }
  ret = ret.substring(0, ret.length - 1);
  ret += "}";
  ret = ret.replaceAll('\n','\\n');
  return ret.replaceAll(r'\', r'\\').replaceAll(r'"', r'\"').replaceAll(r'[', r'{').replaceAll(r']', r'}');
}
String jsonItemInv(Map inv){
  String ret = "";
  ret += r'{"itemList":"';
  List<String> itemList = [];
  for(Map item in inv["itemList"]){
    itemList.add(itemToJson(item));
  }
  ret += itemList.toString();
  ret += r'"}';
  return ret.toString();
}
String itemToJson(Map item){
  String ret = "{";
  for (String k in item.keys) {
    if(k != "itemAppearances")
      ret += '"$k":"${item[k].toString()}",';
  }
  List itemApp = [];
  for (Map app in item["itemAppearances"]){
    itemApp.add('{\\\"imageLoc\\\":\\\"${app["imageLoc"]}\\\",\\\"name\\\":\\\"${app["name"]}\\\"}');
  }
  ret += '\"itemAppearances\":\"${itemApp.toString()}\"}';
  ret = ret.substring(0, ret.length - 1);
  ret += "}";
  return ret.replaceAll(r'\', r'\\').replaceAll(r'"', r'\"');
}