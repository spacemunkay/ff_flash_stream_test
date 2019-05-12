package {
import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.media.Video;
import flash.net.NetConnection;
import flash.net.NetStream;
import flash.events.NetStatusEvent;
import flash.text.TextField;
import flash.text.TextFormat;



public class RawStreamTest extends MovieClip {
	public var stream:NetStream;
	public var button1:MovieClip;
	public var button3:MovieClip;
	public var inputField:TextField;
	
	public function RawStreamTest():void {
		var video:Video = new Video(800,600);
		addChild(video);
		
		var miFormat1:TextFormat = new TextFormat();
		miFormat1.size = 25;
		miFormat1.align='center';
		
		var miText1:TextField = new TextField();
		miText1.text = "Toggle Pause";
		miText1.width = 150;
		miText1.setTextFormat(miFormat1);
		miText1.x = 160;
		
		button1 = new MovieClip();
		button1.buttonMode = true;
		button1.graphics.beginFill(0xFFCC00);
		button1.mouseChildren = false;
		button1.addChild(miText1);
		button1.graphics.drawRect(160, 0, 150, 30);
		button1.addEventListener(MouseEvent.CLICK,togglePauseButtonClick);
		button1.visible = false;
		
		var miText2:TextField = new TextField();
		miText2.text = "Load Stream";
		miText2.width = 150;
		miText2.setTextFormat(miFormat1);
		
		var button2:MovieClip = new MovieClip();
		button2.buttonMode = true;
		button2.graphics.beginFill(0xFFCC00);
		button2.mouseChildren = false;
		button2.addChild(miText2);
		button2.graphics.drawRect(0, 0, 150, 30);
		button2.addEventListener(MouseEvent.CLICK,loadStreamButtonClick);
		
		
		var miText3:TextField = new TextField();
		miText3.text = "Close Stream";
		miText3.width = 150;
		miText3.setTextFormat(miFormat1);
		miText3.x = 320;
		
		button3 = new MovieClip();
		button3.buttonMode = true;
		button3.graphics.beginFill(0xFFCC00);
		button3.mouseChildren = false;
		button3.addChild(miText3);
		button3.graphics.drawRect(320, 0, 150, 30);
		button3.addEventListener(MouseEvent.CLICK,closeStreamButtonClick);
		button3.visible = false;

		inputField = new TextField();		
		inputField.border = true;
		inputField.background = true;
		inputField.width = 800;
		inputField.height = 20;
		inputField.y = 40;
		inputField.type = "input";
		inputField.text = "http://www.helpexamples.com/flash/video/cuepoints.flv";
		
		addChild(button1);
		addChild(button2);
		addChild(button3);
		addChild(inputField);
		
	
		var connection:NetConnection = new NetConnection();
		connection.connect(null);

		stream = new NetStream(connection);
		stream.client = new CustomClient();
		stream.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
		video.attachNetStream(stream);

	}
	
	public function loadStreamButtonClick(e:MouseEvent):void {
		//stream.play("http://localhost:5000/swing_dancing.flv");
		//stream.play("https://s3.amazonaws.com/bmoreplayground/swing_dancing.flv");
		stream.play(inputField.text);
		button1.visible = true;
		button3.visible = true;
	}
	
	public function togglePauseButtonClick(e:MouseEvent):void {
		stream.togglePause();
	}
	
	public function closeStreamButtonClick(e:MouseEvent):void {
		stream.close();
		button1.visible = false;
		button3.visible = false;
	}
	
	public function onNetStatus(info:NetStatusEvent):void {
		var key:String; 
		for (key in info) 
		{ 
			trace(key + ": " + info[key]); 
		} 
	}
}
}

class CustomClient {
	public function onMetaData(info:Object):void {
		trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
	}
	public function onCuePoint(info:Object):void {
		trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	}
	public function onPlayStatus(info:Object):void {
		var key:String; 
		for (key in info) 
		{ 
			trace(key + ": " + info[key]); 
		} 
	}
	public function onSeekPoint(info:Object):void {
		var key:String; 
		for (key in info) 
		{ 
			trace(key + ": " + info[key]); 
		} 
	}
}