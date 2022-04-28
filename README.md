<p align="left">
  <img 
    src="https://i.postimg.cc/vBkbwwnc/Component-4-1.png"
  >
</p>

# CNP Detection - Delphi, Winium, Python and VHDL

The system receives an image of the identity card, localizes the 13 digits of the CNP (unique string of 13 digits), it
classifies each digit, using a convolutional neural network. The digits are detected, and the results of the convolutions
applied on them are send to the FPGA board, using UART transmission protocole. The artificial neural network implemented 
on the FPGA gets the intermediate results and the model (weights and biases) of the neural network, and classifies each 
digit.

The requests of the system include:
  - Creating a program that localizes the digits from CNP;
  - Creating a program that gets every digit of the 13 digits and classifies each one of them, using a convolutional
neural netowork.
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

✅ Video available

✅ [Synthesis](https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Synthesis.pdf)

✅ [Documentation](https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Documentation.pdf)

## Project description

### Folder structure

📁 Delphi_files : contains the Delphi project for the desktop application.

📁 Java_files : contains the Winium project for the automatization process of sending files to FPGA board.

📁 Python_files : contains the Pythons scripts.

📁 VHDL_files : contains the VHDL project that implements the artificial neural network that classifies the digits of the CNP.
    
📄 [Documentation.pdf](https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Documentation.pdf)
: represents the full documentation of the system, and contains:
  - Introduction : short introduction of AI and the reason of creating the given project.
  - The purpose of the project: the main objectives of the system, the target group and the requirements of the system.
  - Research: the main sources of inspiration for implementing different components of the system.
  - Project analysis: flow of the apps of the system, flow diagrams, use cases, description of algorithms and components.
  - Project implementation: detailed description about each component (app) of the system. 
  - Testing and validation: the ways in which the system can be tested.
  - Installation manual: the steps required to install the apps of the system and the ways in which the apps can be run.
  - Conclusions: describes the biggest advantages of the system, possible upgrades/updates.

📄 [Synthesis.pdf](https://github.com/mariusstoica21/licenta_detectie_cnp/blob/main/Synthesis.pdf) : 
represents a short description of the project.
