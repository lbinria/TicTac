package org.lbee.clocks;

import java.io.IOException;

import org.lbee.instrumentation.clock.ClockException;

public interface TicTacImplementation {
    void run() throws IOException, InterruptedException, ClockException;
}
