package org.lbee;

import java.io.IOException;

import org.lbee.clocks.StopWatch;
import org.lbee.clocks.TicTacImplementation;
import org.lbee.clocks.TicTacV2;
import org.lbee.instrumentation.clock.ClockException;

public class Main {
    public static void main(String[] args) throws IOException, InterruptedException, ClockException {

        assert args.length > 0 : "We expect the name of the version to execute as an argument.";

        if (args[0].equals("Clock11h")) {
            StopWatch impl = new StopWatch();
            impl.run(5, 0, 3, 0);
        } else if (args[0].equals("v2")) {
            TicTacImplementation impl = new TicTacV2();
            impl.run();
        } else {
            throw new IllegalArgumentException("Unknown version: " + args[0]);
        }
    }
}