package org.lbee.clocks;

import java.io.IOException;
import java.util.Random;

import org.lbee.instrumentation.clock.ClockException;
import org.lbee.instrumentation.clock.ClockFactory;
import org.lbee.instrumentation.trace.TLATracer;
import org.lbee.instrumentation.trace.VirtualField;

public class TicTac {
    public void run(int nbTicks) throws IOException, InterruptedException, ClockException {
        // Create a tracer
        TLATracer tracer = TLATracer.getTracer("tictac.ndjson",
                ClockFactory.getClock(ClockFactory.MEMORY));

        // Get variables from spec
        VirtualField specClock = tracer.getVariableTracer("clockValue");
        VirtualField specNTick = tracer.getVariableTracer("nTick");
        VirtualField specNTack = tracer.getVariableTracer("nTack");

        Random rand = new Random(42);

        int clockValue = 0;
        int nTick = 0;
        int nTack = 0;

        for (int i = 0; i < nbTicks; i++) {
            // At random point, reset clock
            if (rand.nextInt(0, 100) == 42 && clockValue % 2 == 1){
                System.out.printf("Reset clock at %s.\n", clockValue);
                clockValue = 0;

                specClock.update(clockValue);
                tracer.log("ResetClock");
            }

            String eventName;
            if (clockValue % 2 == 0) {
                nTick++;
                specNTick.apply("Add", 1);
                eventName = "Tick";
            }
            else {
                nTack++;
                specNTack.apply("Add", 1);
                eventName = "Tack";
            }
            // Advance clock
            clockValue++;
            specClock.apply("Add", 1);

            tracer.log(eventName);

            System.out.println(eventName + " - " + clockValue);
        }

        System.out.println("Number of tics/tacs: " + nTick + "/" + nTack);

    }
    public static void main(String[] args) throws IOException, InterruptedException, ClockException {
        int nbTicks = args.length > 0 ? Integer.parseInt(args[0]) : 0;
        TicTac impl = new TicTac();
        impl.run(nbTicks);
    }
}
