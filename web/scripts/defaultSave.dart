import 'dart:convert';

Map save = jsonDecode('''{
"dataString": "UNIMPORTANT:___this is not a real dollstring, do not use",
"name": "UNIMPORTANT",
"lastPlayed": "1515151515151",
"bgIndex": "0",
"PetInventory": {
"petsList": [{"lastPlayed": "1576796385671", "isempress": "false", "hatchDate": "1576796385671", "lastFed": "1576796385671", "dollDATAURL":  "Teal Egg:___HBQ-CW4AgoIAQUEAgoIAw8MAQUEAgoIAgoIAgoIAAABLS0s6OjoREREAAAAREREzMzPExMQAgoIAQUEIgbgNwBNf9AFsALYAUIAoWA==", "boredomJson": "0", "nameJSON":  "Teal Egg", "healthJson": "100", "TYPE": "EGG", "corrupt": "false", "purified": "false", "patience": "13", "idealistic": "-46", "curious": "38", "loyal": "45", "energetic": "-40", "external": "42", "remembered": [], "rememberedNames": [], "rememberedCastes": []}],
"alumni": []
},
"ItemInventory": {
"itemList": []
},
"caegers": "0",
"lastAllowence": "1515151515151"
}''');
Map pet = jsonDecode('{"lastPlayed": "1576796385671", "isempress": "false", "hatchDate": "1576796385671", "lastFed": "1576796385671", "dollDATAURL":  "Teal Egg:___HBQ-CW4AgoIAQUEAgoIAw8MAQUEAgoIAgoIAgoIAAABLS0s6OjoREREAAAAREREzMzPExMQAgoIAQUEIgbgNwBNf9AFsALYAUIAoWA==", "boredomJson": "0", "nameJSON":  "Teal Egg", "healthJson": "100", "TYPE": "EGG", "corrupt": "false", "purified": "false", "patience": "13", "idealistic": "-46", "curious": "38", "loyal": "45", "energetic": "-40", "external": "42", "remembered": [], "rememberedNames": [], "rememberedCastes": []}');