import java_cup.runtime.Symbol;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.Reader;
import java.io.StringReader;

public class Tester {
    public static void main(String[] args) {
        if (args.length == 0) {
            System.out.println("Usage: java Tester <input_file>");
            System.exit(-1);
        }
        String filePath = args[0]; // Get the input file path from the command line argument.
        try {
            var reader = new FileReader(filePath);
            Lexer lexer = new Lexer(reader);
            while (true) {
                Symbol token = lexer.next_token();
                if (token.sym == sym.EOF) {
                    System.out.println("\nEnd of lexycal analysis.");
                    break;
                }
                if (token.sym == sym.ERROR) {
                    System.out.println("\n" + token.value.toString());
                    break;
                }
                System.out.print(token.toString() + " ");
            }
        } catch (FileNotFoundException e) {
            System.out.println("File not found while reading file from path: " + filePath);
            System.exit(-2);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}