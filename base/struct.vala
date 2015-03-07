using GLib;

struct Vector {
	public double x;
	public double y;
	public double z;
	public Vector() {
		this.x = 23;
		this.y = 24;
		this.z = 25;
	}
}

public static int main(string[] args) {

	var mystruct = Vector();
	// mystruct.x = 10.0;
	// mystruct.y = 20.0;
	// mystruct.z = 30.0;
	stdout.printf("%lf\n", mystruct.x);
	stdout.printf("%lf\n", mystruct.y);
	stdout.printf("%lf\n", mystruct.z);
    return 0;
}
