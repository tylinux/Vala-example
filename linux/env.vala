using GLib;

public static int main(string[] args) {
    stdout.printf("%s\n", Environment.get_variable("HOME"));
    return 0;
}