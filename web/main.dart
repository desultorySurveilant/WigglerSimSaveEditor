import 'dart:convert';
import 'dart:html';

void main() {
  DivElement output = querySelector("#output");
  InputElement fileElement = InputElement()..type = "file";
  fileElement.innerHtml = "Load Save";
  output.append(fileElement);

  fileElement.onChange.listen((e) {
    File file = fileElement.files.first;
    FileReader reader = FileReader();
    reader.readAsText(file);
    reader.onLoadEnd.first.then((e) {
      String saveString = reader.result;
      output.appendText(jsonEncode(unfuckJson(saveString)));
    });
  });
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