<p align="left">
  <img 
    src="https://i.postimg.cc/vBkbwwnc/Component-4-1.png"
  >
</p>

# CNP Detection - Delphi, Winium, Python and VHDL

The system receives an image of the identity card, localizes the 13 digits of the CNP (unique string of 13 digits), it
classifies each digit, using a convolutional neural network. The digits are detected, and the results of the convolutions
applied on them are send to the FPGA board, using UART transmission protocol. The artificial neural network implemented 
on the FPGA gets the intermediate results and the model (weights and biases) of the neural network, and classifies each 
digit.

The requests of the system include:
  - Creating a program that localizes the digits from CNP.
  - Creating a program that gets every digit of the 13 digits and classifies each one of them, using a convolutional
neural network.
  - Creating a desktop application, with a user-friendly graphic user interface, intuitive and fast, with a commercial look.
  - Creating a database in order to save the users of the app and data about them, (hashed passwords), the original images 
 and the processed images, and a event history of the app, for each user.
  - Creating an artificial neural network on the FPGA board, in order to classify those 13 digits of the CNP.
  - Creating a program that automatizes the desktop app, with the purpose of transmitting the input of the artificial neural
network and the model to the FPGA board.

## Installation
The installation process is described in chapter 7, page 79, of the [documentation](https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Documentation.pdf).

## Summary
✅ G.U.I. 

❌ Ease of installation

✅ Additional hardware needed

✅ [Video available](https://www.youtube.com/watch?v=b6LXl1tis6I)

✅ [Synthesis](https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Synthesis.pdf)

✅ [Documentation](https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Documentation.pdf)

## Project description

### Folder structure

📁 Delphi_files : contains the Delphi project for the desktop application.

📁 Java_files : contains the Winium project for the automatization process of sending files to FPGA board.

📁 Python_files : contains the Pythons scripts.

📁 VHDL_files : contains the VHDL project that implements the artificial neural network that classifies the digits of the CNP.
    
📄 Documentation.pdf
: represents the full documentation of the system, and contains:
  - Introduction : short introduction of AI and the reason of creating the given project.
  - The purpose of the project: the main objectives of the system, the target group and the requirements of the system.
  - Research: the main sources of inspiration for implementing different components of the system.
  - Project analysis: flow of the apps of the system, flow diagrams, use cases, description of algorithms and components.
  - Project implementation: detailed description about each component (app) of the system. 
  - Testing and validation: the ways in which the system can be tested.
  - Installation manual: the steps required to install the apps of the system and the ways in which the apps can be run.
  - Conclusions: describes the biggest advantages of the system, possible upgrades/updates.

📄 Synthesis.pdf : represents a short description of the project.

### Technologies

<table>
  <tr>
    <th>🔨 Tools/Framework</th>
    <th>📘 Language</th>
    <th>📃 Usage </th>
    <th>➕ Additional resources  </th>
    <th> ℹ Details  </th>
  </tr>
  <tr>
    <td>Xilinx Vivado 2020</td>
    <td>VHDL</td>
    <td>Artificial neurnal network</td>
    <td>Basys3 FPGA board, HTerm</td>
    <td>
       <ul>
        <li>The input of the NN and the model (weights and biases) are send from the PC to the FPGA, using HTerm.</li>
        <li>The values of the two files are stored in the block RAM memory of the FPGA.</li>
        <li>The values are represented in fixed point representation.</li>
         <li>The detection is made using a FSM (finite state machine).</li>
         <li>The output of the NN is showed on the SSD (seven segment display) of the FPGA.</li>
      </ul>
   </td>
  </tr>
  <tr>
    <td>Jupyter Notebook using Anaconda Navigator</td>
    <td>Python</td>
    <td>Convolutional neurnal network, Optical character recognition</td>
    <td>Tensorflow, Tesseract</td>
    <td>
       <ul>
        <li>The convolutional neural network was trained</li>
        <li>The model of the artificial neural network is send to the FPGA board.</li>
        <li>The OCR Script classifies and localizes the digit in the image of the ID.</li>
        <li>The images of the ID's are preprocessed, and using OCR, the digits are detected.</li>
      </ul>
   </td>
  </tr>
  <tr>
    <td>Eclipse</td>
    <td>Java</td>
    <td>Automatization app</td>
    <td>Winium, Inspect.exe, Winium Desktop Driver</td>
    <td>
       <ul>
        <li>The automatization app has the purpose to send automatically the input and weights files to the FPGA board.</li>
        <li>The automatizan app was created using Winium.</li>
        <li>In order to detect the id and names of the buttons, the Inspect.exe tool is used.</li>
        <li>In order to run the automatization app, the 9999 port has to be assigned, using Winium Desktop Driver.</li>
      </ul>
   </td>
  </tr>
  <tr>
    <td>Delphi</td>
    <td>Objective Pascal</td>
    <td>Desktop application</td>
    <td>ImageButton</td>
    <td>
       <ul>
        <li>The main advantage of using Delphi is the quickness in creating the desktop app, using the specialized objects.</li>
        <li>The main disadvantage is the impossibility of colouring buttons.</li>
        <li>This disadvantage was removed by implementing the ImageButton library, that allows using images on the background of the buttons.</li>
      </ul>
   </td>
  </tr>
  <tr>
    <td>MYSQL Workbench</td>
    <td>SQL</td>
    <td>Database</td>
    <td>XAMPP</td>
    <td>
       <ul>
        <li>Information about users, original images and processed images are saved in the database.</li>
        <li>Data are read from the database by the desktop application, using query's.</li>
        <li>XAMPP allows the creation of a local MYSQL database.</li>
      </ul>
   </td>
  </tr>
</table>

## Tutorial

### Delphi

Default form of the app. The form allows the user to log in, in order to have access to the apps functionalities. The user has to have an account and a password. The user has the option to sign up, by pressing "Don't you have an account? Sign up here". The entered password is hashed. The value of the hash is compared to the value of the hash in the database. If there is a match, the user is redirected to the menu of the app.

<p align="center">
  <img 
    src="https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Images/login.JPG"
  >
</p>

The sign up form has the role to sign up the users that do not have an account in the database. The users have the option to choose their profile image, by pressing the 'Choose image' button. The profile image will be loaded from the file system. Users shall write the firstname, lastname, username and password. The password will be hashed and saved in the database.

<p align="center">
  <img 
    src="https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Images/signup.JPG"
  >
</p>

'Load image' has the role to load an image with the identity card, and to pass it to the preprocessing stage. The user will choose the image by pressing the 'Choose image' button. The image can be selected from the file system, and once selected, it will appear in the 'Original image' area. By pressing the 'Send image' button, the original image will be send to the processing stage. After aprox. 15 seconds, the processed image with the CNP digits detected will be shown in the 'Processed image' area. Meanwhile, the input of the neural network and the model (weights and biases) will be send to the FPGA board, in order to classify the digits. The 'Remove images' button will delete both the original and processed images, giving the user the opportunity for a new process of detection.

<p align="center">
  <img 
    src="https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Images/load_image.JPG"
  >
</p>

After the processing stage, the processed image is displayed. Above the original CNP, a string of digits is shown, being the digits that the OCR predicted. In the given case, OCR has predicted well all the digits.

<p align="center">
  <img 
    src="https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Images/res.png"
  >
</p>

'Results' will display the images that correspond to the detected digits in CNP. Results appear only if the an image of identity card was loaded and send to processing. Under 'Images', the images of the digits are shown. Under 'Expected results', the expected results are shown, either with a green border for those who were classified correctly, or a red border otherwise.

<p align="center">
  <img 
    src="https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Images/results.JPG"
  >
</p>

'Library' displays the saved images from the database, both original and processed. There are two tables, one with the original images, and another one with the processed images. The user may choose the image he/she wants to see, by clicking the desired filename. In case the size of the image shown is too small, the user can 'Open Image' and maximize it. 

<p align="center">
  <img 
    src="https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Images/library.png"
  >
</p>



### VHDL

In the image below, the first 4 digits out of the 13 of the CNP are shown. The values of the CNP are shifted with 1 position to the left, once a second, so that all the digits will be displayed. The leds show the results of the outputs for every digit, in fixed point representation. Every digit has 10 possible outputs. Totally, there are 130 outputs, that can be shown by pressing one of the buttons of the FPGA board. 

<p align="center">
  <img 
    src="https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Images/output.JPG"
  >
</p>

### Artificial Neural Network

Confusion matrix outputs how many times the values were correctly predicted. For example, 0 was correctly predicted 962 times. The value 1 was correctly predicted 1116 times. It can be seen that the values on the diagonal are the greatest, since the digits were most of the time predicted correctly, the neural network having an accuracy of 92%. The confusion matrix also displays the digits with problems. For example, digit 4 was 49 times predicted as being 9.


<p align="center">
  <img 
    src="https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Images/ann.JPG"
  >
</p>


### Convolutional Neural Network

The confusion matrix of the convolutional neural network has better results than the previous confusion matrix. The accuracy has grown from 92% to 98% for the testing dataset. For example, value 0 was predicted 976 times correctly using the CNN, as oposed to 962 with the ANN. The values on the diagonal are greater.

<p align="center">
  <img 
    src="https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Images/cnn.JPG"
  >
</p>

### Optical character recognition

The preprocessing stage before giving the original image as an input for OCR algorithm with Tesseract. Original image was converted into grayscale image, than a tresholded image, and finally the input image after the canny edge detection was applied.

<p align="center">
  <img 
    src="https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Images/ocr.png"
  >
</p>

## Authors

- [@mariusstoica21](https://github.com/mariusstoica21)


