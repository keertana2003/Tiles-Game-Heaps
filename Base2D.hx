import h2d.Object;
import hxd.Window;
import h2d.Scene;
import Random;

class Base2D extends hxd.App {

  var obj : h2d.Object;
  var tf : h2d.Text;

  static function loadOfficeMap(obj : h2d.Object, s2d) {
    //tile
    obj.x = Std.int(s2d.width / 2);
    obj.y = Std.int(s2d.height / 2);
    var tile = hxd.Res.officeMap.toTile();
    tile = tile.center();
    var bmp = new h2d.Bitmap(tile, obj);
  }

  function setScreen() {
    loadOfficeMap(new Object(s2d), s2d);
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