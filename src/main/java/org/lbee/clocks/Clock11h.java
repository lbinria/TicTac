package org.lbee.clocks;

import java.io.IOException;
import java.util.Random;
import java.util.concurrent.TimeUnit;

import org.lbee.instrumentation.clock.ClockException;
import org.lbee.instrumentation.clock.ClockFactory;
import org.lbee.instrumentation.trace.TLATracer;
import org.lbee.instrumentation.trace.VirtualField;

public class Clock11h implements TicTacImplementation {
    @Override
    public void run() throws IOException, InterruptedException, ClockException {
        // Create a tracer
        TLATracer tracer = TLATracer.getTracer("Clock11h.ndjson",
                ClockFactory.getClock(ClockFactory.MEMORY));

        // Get variables from spec
        VirtualField specHour = tracer.getVariableTracer("hour");
        VirtualField specMinute = tracer.getVariableTracer("minute");

        Random rand = new Random(42);
        int hour = rand.nextInt(0, 23), minute = rand.nextInt(0, 59);
        while (true) {
            if (minute < 59) {
                minute += 1;
                specMinute.update(minute);
            } else {
                minute = 0;
                specMinute.update(0);
                // Introduce error here, condition should be hour < 11
                if (hour <= 11) {
                    hour += 1;
                    specHour.update(hour);
                } else {
                    hour = 0;
                    specHour.update(0);
                }
            }

            // Commit event tick !
            tracer.log("Tick");

            System.out.printf("Clock: %s:%s.\n", hour, minute);
            TimeUnit.MILLISECONDS.sleep(10);
        }
    }

    public static void main(String[] args) throws IOException, InterruptedException, ClockException {
        final TicTacImplementation impl = new Clock11h();
        impl.run();
    }
}
