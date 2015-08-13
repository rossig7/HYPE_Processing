import hype.*;

HColorPool colors;
HCanvas canvas;
HDrawablePool pool;
HTimer timer;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#202020).use3D(true);

	colors = new HColorPool(#FFFFFF, #F7F7F7, #ECECEC, #333333, #0095a8, #00616f, #FF3300, #FF6600);

	canvas = new HCanvas(P3D).autoClear(false).fade(2);
	H.add(canvas);

	pool = new HDrawablePool(300);
	pool.autoParent(canvas)
		.add (
			new HRect().rounding(5)
		)

		 .onRequest (
			 new HCallback() {
				public void run(Object obj) {
					HDrawable d = (HDrawable) obj;
					d
						.strokeWeight(1)
						.stroke(#000000, 50)
						.fill( colors.getColor() )
						.loc( (int)random(width), (int)random(height), -(int)random(2000) )
						.anchorAt(H.CENTER)
						.size( 5+((int)random(10)*5) )
					;
				}
			}
		)
	;

	timer = new HTimer()
		.numCycles( pool.numActive() )
		.interval(25)
		.callback(
			new HCallback() { 
				public void run(Object obj) {
					pool.request();
				}
			}
		)
	;
}

void draw() {
  for(HDrawable d : pool) {

		d.rotation( d.z() / 1.5 );
		d.loc(d.x(), d.y(), d.z() + 4 );

		if(d.z() > 4000) {
			pool.release(d);
		}
	}

	H.drawStage();
}

