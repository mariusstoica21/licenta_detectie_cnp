package testcases;

import java.awt.List;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Scanner;

import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.winium.DesktopOptions;
import org.openqa.selenium.winium.WiniumDriver;



public class MyFirstTestCase {

	public static void main(String[] args) throws MalformedURLException, InterruptedException {
		// TODO Auto-generated method stub
		DesktopOptions option = new DesktopOptions();
		
		//option.setApplicationPath("C:\\Windows\\System32\\calc.exe");
		option.setApplicationPath("E:\\HTerm\\hterm.exe");
		
		WiniumDriver driver = new WiniumDriver(new URL("http://localhost:9999"),option);
		
		
		
		Actions actions = new Actions(driver);
		
		Thread.sleep(3000);
		
		
//		driver.findElement(By.name("Send file")).click();
//    	driver.findElement(By.name("File name:")).sendKeys("InputsAllVHDL.txt");
//		driver.findElement(By.name("Open")).click();
//		driver.findElement(By.id("-31913")).click();
		
		String[] fileNameArray = {"InputsALLVHDL.txt","WeightsALLVHDL.txt"};
	    
	    int count = 0;
	    int noFiles = 2;
	    
	    while(count < noFiles)
	    {
	    	driver.findElement(By.name("Send file")).click();
	    	Thread.sleep(3000);
	    	driver.findElement(By.name("File name:")).sendKeys(fileNameArray[count]);
			driver.findElement(By.name("Open")).click();
			driver.findElement(By.id("-31913")).click();
			//driver.findElementByXPath("//*[@Name='Autosend']").findElement(By.name("Start")).click();
			Thread.sleep(12000);
			count += 1;
	    }

	}

}
