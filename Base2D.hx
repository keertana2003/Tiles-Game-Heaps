import hxd.Window;
import h2d.Scene;
import h3d.pass.Base;
import Random;

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

  function updateScreen() {
    Base2D.loadOfficeMap(new h2d.Object(s2d), s2d);
    Base2D.loadRectangle(s2d);
  }

  function setScreen() {
    updateScreen();

  }

  //main entry point
  override function init() {
    setScreen();
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