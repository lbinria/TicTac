package org.lbee.clocks;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import org.lbee.instrumentation.clock.ClockException;
import org.lbee.instrumentation.clock.ClockFactory;
import org.lbee.instrumentation.trace.TLATracer;
import org.lbee.instrumentation.trace.VirtualField;

public class StopWatch {
    public void run(int startHour, int startMinute, int endHour, int endMinute)
            throws IOException, InterruptedException, ClockException {
        // Create a tracer
        TLATracer tracer = TLATracer.getTracer("stopwatch.ndjson",
                ClockFactory.getClock(ClockFactory.MEMORY));

        // Get variables from spec
        VirtualField specHour = tracer.getVariableTracer("hour");
        VirtualField specMinute = tracer.getVariableTracer("minute");

        int hour = startHour;
        int minute = startMinute;
        while (! (hour == endHour && minute == endMinute)) {
            if (minute < 59) {
                minute += 1;
                specMinute.update(minute);
            } else {
                minute = 0;
                // BUG: condition should be hour < 23
                if (hour <= 23) {
                    hour += 1;
                } else {
                    hour = 0;
                }
                specMinute.update(0);
                specHour.update(hour);
            }
            // Commit event tick !
            tracer.log("Tick");

            System.out.printf("Clock: %s:%s.\n", hour, minute);
            TimeUnit.MILLISECONDS.sleep(10);
        }
    }

    public static void main(String[] args) throws IOException, InterruptedException, ClockException {
        int startHour = args.length > 0 ? Integer.parseInt(args[0]) : 0;
        int startMinute = args.length > 1 ? Integer.parseInt(args[1]) : 0;
        int endHour = args.length > 2 ? Integer.parseInt(args[2]) : 23;
        int endMinute = args.length > 3 ? Integer.parseInt(args[3]) : 59;
        StopWatch impl = new StopWatch();
        impl.run(startHour, startMinute, endHour, endMinute);
    }
}
