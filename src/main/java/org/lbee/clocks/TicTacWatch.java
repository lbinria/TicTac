package org.lbee.clocks;

import java.io.IOException;
import java.util.Arrays;

import org.lbee.instrumentation.clock.ClockException;
import org.lbee.instrumentation.clock.ClockFactory;
import org.lbee.instrumentation.trace.TLATracer;
import org.lbee.instrumentation.trace.VirtualField;

public class TicTacWatch {
    public static String array2String(String[][] array) {
        StringBuilder sb = new StringBuilder();
        for (String[] row : array) {
            sb.append(Arrays.toString(row));
            sb.append("\n");
        }
        return sb.toString();
    }

    public void run(int startHour, int startMinute, int nbTicks)
            throws IOException, InterruptedException, ClockException {
        // Create a tracer
        TLATracer tracer = TLATracer.getTracer("tictacwatch.ndjson",
                ClockFactory.getClock(ClockFactory.MEMORY));

        // Get variables from spec
        VirtualField specNTick = tracer.getVariableTracer("nTick");
        VirtualField specNTack = tracer.getVariableTracer("nTack");
        VirtualField specHour = tracer.getVariableTracer("hour");
        VirtualField specMinute = tracer.getVariableTracer("minute");
        VirtualField specTictac = tracer.getVariableTracer("tictac");

        String[][] tictac = new String[24][60];
        int hour = startHour;
        int minute = startMinute;

        String eventName = "Tick";

        System.out.println("Starting at " + hour + ":" + minute + " with " + nbTicks + " ticks");

        for (int i = 0; i < nbTicks; i++) {
            if (minute < 59) {
                minute += 1;
                specMinute.update(minute);
            } else {
                minute = 0;
                if (hour < 23) {
                    hour += 1;
                } else {
                    hour = 0;
                }
                specMinute.update(0);
                specHour.update(hour);
            }

            // BUG: if (minute % 2 == 0) {
            if ((hour+minute) % 2 == 0) {
                specNTack.apply("Add", 1);
                eventName = "Tack";
            } else {
                specNTick.apply("Add", 1);
                eventName = "Tick";
            }
            tictac[hour][minute] = eventName;

            specTictac.getField(hour).getField(minute).update(eventName);
            tracer.log(eventName);

            System.out.println(eventName + " - " + hour + ":" + minute);
        }
    }

    public static void main(String[] args) throws IOException, InterruptedException, ClockException {
        int startHour = args.length > 0 ? Integer.parseInt(args[0]) : 0;
        int startMinute = args.length > 1 ? Integer.parseInt(args[1]) : 0;
        int nbTicks = args.length > 2 ? Integer.parseInt(args[2]) : 0;
        TicTacWatch impl = new TicTacWatch();
        impl.run(startHour, startMinute, nbTicks);
    }
}
