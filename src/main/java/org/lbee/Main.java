package org.lbee;

import java.io.IOException;

import org.lbee.clocks.Clock11h;
import org.lbee.clocks.TicTacImplementation;
import org.lbee.clocks.TicTacV2;
import org.lbee.instrumentation.clock.ClockException;

public class Main {
    public static void main(String[] args) throws IOException, InterruptedException, ClockException {

        assert args.length > 0 : "We expect the name of the version to execute as an argument.";

        final TicTacImplementation impl;

        if (args[0].equals("Clock11h"))
            impl = new Clock11h();
        else if (args[0].equals("v2"))
            impl = new TicTacV2();
        else
            // Default case
            impl = new Clock11h();

        impl.run();
    }
}