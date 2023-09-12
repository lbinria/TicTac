package org.lbee;

import org.lbee.instrumentation.BehaviorRecorder;
import org.lbee.instrumentation.VirtualField;
import org.lbee.instrumentation.clock.SharedClock;

import java.io.IOException;
import java.util.Random;
import java.util.concurrent.TimeUnit;

public class TicTacV1 implements TicTacImplementation {
    @Override
    public void run() throws IOException, InterruptedException {

        // Get & init clock
        SharedClock clock = SharedClock.get("tictac.clock");
        clock.reset();

        // Init behavior recorder
        BehaviorRecorder behaviorRecorder = BehaviorRecorder.create("tictac.ndjson", clock);
        // Get variables from spec
        VirtualField specHour = behaviorRecorder.getVariable("hour");
        VirtualField specMinute = behaviorRecorder.getVariable("minute");

        Random rand = new Random(42);
        int hour = rand.nextInt(0, 23), minute = rand.nextInt(0, 59);
        while (true) {

            if (minute < 59) {
                minute += 1;
                // Notify
//                specMinute.apply("Add", 1);
                specMinute.set(minute);
            } else {
                minute = 0;
                specMinute.set(0);

                // Introduce error here, condition should be hour < 23
                if (hour <= 23) {
                    hour += 1;
                    //specHour.apply("Add", 1);
                    specHour.set(hour);
                } else {
                    hour = 0;
                    specHour.set(0);
                }
            }

            // Commit event tick !
            behaviorRecorder.commitChanges("Tick");

            System.out.printf("Clock: %s:%s.\n", hour, minute);
            TimeUnit.MILLISECONDS.sleep(10);
        }
    }
}
