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
