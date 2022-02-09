

/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React, { useEffect } from 'react';

import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
  NativeModules,
  TouchableOpacity,
  Image,
  NativeEventEmitter
} from 'react-native';
import FormData from "form-data";
import axios from "axios"

const App = () => {

  const { Torch } = NativeModules;
  const [imageData, setImageData] = React.useState(null);
  const [imageText, setImageText] = React.useState(null);

  const formData = new FormData();

  const finished = new NativeEventEmitter(Torch);
  finished.addListener(
    "finishScan",
    (res) => setImageData(res.imageData)
  );

  

  const showImage = () => { 
    Torch.getTorchImageData((error, data) => {
      setImageData(data)
      
    });
  }
  const showImageText = () => {
    Torch.getTorchImageText((error, data) => {
      setImageText(data)
    });
  }
 
  // const sendImageServer = () => {
   
  //     formData.append("file", {
  //       uri: imageData,
  //       name: "image.jpg",
  //       type: "image/jpeg"
  //     });
  //     axios.post('http://192.168.0.195:8000/api/expenses/upload-photo/', formData)
  //       .then((result) => {
  //         console.log(result.data.datas)
  //       }).catch(err => {
  //         console.log(err)
  //       })
   
    
  // }
 
  return (
    <SafeAreaView >
      <ScrollView
     >
      <View style={{
        alignItems: 'center',
        justifyContent: 'center',
        flex: 1,
      }}>
      {imageData && <Image style={{width: 500, height: 500, resizeMode:"contain"}} source={{ uri: `data:image/png;base64,${imageData}` }} />}
      {imageText ? <Text style={{fontSize: 20}}>{imageText}</Text> : null}
      <TouchableOpacity
        onPress={() => {
          setImageData(null)
          Torch.open()
            }}
            style={{ marginTop: 20 }}
      >
        <Text>Open Scanner</Text>
      </TouchableOpacity>
     
    
      <TouchableOpacity
        onPress={() => showImageText()}
        style={{ marginTop: 20 }}
      >
        <Text>Show Text</Text>
          </TouchableOpacity>
          <TouchableOpacity
            onPress={() => showImageText()}
            style={{ marginTop: 20 }}
          >
            <Text>Send Server</Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

export default App;



// import React from 'react';

// import {
//   SafeAreaView,
//   ScrollView,
//   StatusBar,
//   StyleSheet,
//   Text,
//   useColorScheme,
//   View,
//   NativeModules,
//   TouchableOpacity,
//   requireNativeComponent
// } from 'react-native';


// const App = () => {

//   const Switch = requireNativeComponent('Switch');

 

  
//   return (
//     <SafeAreaView style={{
//       alignItems: 'center',
//       justifyContent: 'center',
//       flex: 1,
//     }}>
//       <Switch style={{
//         height: 200,
//         width: 400,
//         backgroundColor: 'yellow',
//       }} isOn={false} />
      
//     </SafeAreaView>
//   );
// };



// export default App;