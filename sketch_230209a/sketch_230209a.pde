import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


//
//Global Variables
String path = new File("").getAbsolutePath(); //Exported Program
//CAUTION: GitHub must be linked to the C-Drive instead of FS ... This might need a lesson
String directory = "C:/Users/nur/Documents/nourapp/nourappfliecode/sketch_230209a"; //Not Exported
//Reminder: \n is a character escape, so pathway must have forward slashes
//
Minim minim; //creates an object to access all functions
AudioPlayer[] songs = new AudioPlayer[16]; //creates "Play List" variable holding extensions WAV, AIFF, AU, SND, and MP3
//
void setup() {
  size(900, 900);
  minim = new Minim (this); //load from data directory, loadFile should also load from project folder, like loadImage
  //
  File anyDirectory = new File(path); //Used when exported
  println ("Exported Directory", anyDirectory);
  File[] FileListAnyDirectory = anyDirectory.listFiles();
  printArray(FileListAnyDirectory);
  println("Items in Exported Folder:", FileListAnyDirectory.length);
  int i = 0; //songs index
  for (File file : FileListAnyDirectory) {
    if ( file.isFile() ) {
      if ( file.toString().endsWith(".mp3") ) {
        println("Any Directory is working");
        songs[i] = minim.loadFile( file.getName() );
        i = i + 1;
      }
    }
  }
  //
  //When Prototyping, songs is not loaded from anyDirectory
  File githubDirectory = new File(directory); //Used when prototyping
  println ("Prototyping Directory", githubDirectory);
  File[] FileListGitHubDir = githubDirectory.listFiles();
  if ( songs[0] == null ) {
    printArray(FileListGitHubDir);
    println("Items in Prototyped Folder:", FileListGitHubDir.length);
    for ( File file : FileListGitHubDir ) {
      if ( file.isFile() ) {
        if ( file.toString().endsWith("_sound.mp3") ) {
          println("File Name sound.mp3 only", file.getName() );
          songs[i] = minim.loadFile(file.getName());
          i+=1;
        } else if ( file.toString().endsWith(".mp3") ) {
          println("File Name.mp3 only", file.getName() );
          songs[i] = minim.loadFile(file.getName());
          i+=1;
        }
      }
    }
  } //Catch when Pathway NULL, not exported
  songs[0].loop(0); //Change the index manually
}//End setup
//
void draw() {
  background(123);
  stroke(0);
  strokeWeight(6);
  fill(200);
  // Draw a rectangle to represent the play/pause button
  rect(50, 50, 100, 50);
  // Display the current song title
  textSize(20);
  fill(0);
  
  text(songs[0].getMetaData().title(), 50, 100);
  // Display the current time and total time of the song
  text(nf(songs[0].position()/1000, 2, 2) + " / " + nf(songs[0].length()/1000, 2, 2), 50, 150);
}


void keyPressed() {
}//End keyPressed
//
void mousePressed() {
  if (mouseX > 50 && mouseX < 150 && mouseY > 50 && mouseY < 100) {
    // If the play/pause button was clicked, toggle the playing state of the song
    if (songs[0].isPlaying()) {
      songs[0].pause();
    } else {
      songs[0].play();
    }
  }
}
