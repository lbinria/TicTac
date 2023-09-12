package org.lbee;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException, InterruptedException {

        assert args.length > 0 : "We expect the name of the version to execute as an argument.";

        final TicTacImplementation impl;

        if (args[0].equals("v1"))
            impl = new TicTacV1();
        else if (args[0].equals("v2"))
            impl = new TicTacV2();
        else
            // Default case
            impl = new TicTacV1();

        impl.run();
    }
}