import hxd.Window;
import h2d.Scene;
import h3d.pass.Base;
import Random;
import haxe.Timer;
using StringTools;

class Base2D extends hxd.App {

  var obj : h2d.Object;
  var tf : h2d.Text;
  static var score = 0;
  static var xRandom = 450;
  static var yRandom = 500;
  static var squareSide = 25;

  static function loadOfficeMap(obj : h2d.Object, s2d) {
    //tile
    obj.x = Std.int(s2d.width / 2);
    obj.y = Std.int(s2d.height / 2);
    var tile = hxd.Res.officeMap.toTile();
    tile = tile.center();
    var bmp = new h2d.Bitmap(tile, obj);
  }

  static function loadRectangle(s2d) {
    // rectangle
    xRandom = Random.int(450, 1350);
    yRandom = Random.int(70, 800);
    var customGraphics = new h2d.Graphics(s2d);
    customGraphics.beginFill(0x000000);
    customGraphics.drawRect(xRandom, yRandom, Base2D.squareSide, Base2D.squareSide);
    customGraphics.endFill();
  }

  static function updateScore(s2d) {
    var font : h2d.Font = hxd.Res.gravityFont.toFont();
    var tf = new h2d.Text(font, s2d);
    tf.textColor = 0xFFFFFF;
    tf.text = "Score: " + Std.string(Base2D.score);
    tf.y = 20;
    tf.x = 20;
    tf.scale(2);
  }

  function gameOverScreen() {
    updateScreen();

    var customGraphics = new h2d.Graphics(s2d);
    customGraphics.beginFill(0xFFFFFF);
    customGraphics.drawRect(20, 150, 600, 150);
    customGraphics.endFill();
    var font : h2d.Font = hxd.Res.gravityFont.toFont();
    var tf = new h2d.Text(font, s2d);
    tf.textColor = 0x800080;
    tf.text = "Click missed!!! Game Over";
    tf.y = 200;
    tf.x = 60;
    tf.scale(2);

    Base2D.score = 0;
  }
  
  function isValidClick(x, y):Bool {
    return((x > Base2D.xRandom) && (x <= (Base2D.xRandom + Base2D.squareSide)) 
      && (y > Base2D.yRandom) && (y <= (Base2D.yRandom + Base2D.squareSide)));
  }

  function updateScreen() {
    Base2D.loadOfficeMap(new h2d.Object(s2d), s2d);
    Base2D.loadRectangle(s2d);
    Base2D.updateScore(s2d);
  }


  function getX(event: String): Int {
    var eventX = event.split(',')[0];
    eventX = eventX.substr(6,eventX.length);
    trace(eventX);
    return Std.parseInt(eventX);
  }

  function getY(event: String): Int {
    var eventY = event.split(',')[1];
    eventY = eventY.substr(0,eventY.length-1);
    trace(eventY);
    return Std.parseInt(eventY);
  }

  function setScreen() {
   
  }

  //main entry point
  override function init() {
    var timer = new Timer(3000);
    timer.run = function() {
      //setScreen();
      updateScreen();
      //on Click / Event
      function onEvent(event : hxd.Event) {
        //timer.stop();
        switch(event.kind) {
          case EPush:
            trace(event.toString());
            if(isValidClick(getX(event.toString()), getY(event.toString()))) {
              Base2D.score = Base2D.score + 1;
              s2d.removeChildren();
              updateScreen();
            }
            else {
              Window.getInstance().removeEventTarget(onEvent);
              gameOverScreen();
              timer.stop();
            }
          case _: //trace('other');
        }
      }
      hxd.Window.getInstance().addEventTarget(onEvent);
    }
  }

  // if we the window has been resized
  override function onResize() {
   if( obj == null ) return;
    // move our text up/down accordingly
    if( tf != null ) tf.y = s2d.height - 80;
  }

  static function main() {
    hxd.Res.initEmbed();
    var base = new Base2D();
    //base.setScene();
  }
}