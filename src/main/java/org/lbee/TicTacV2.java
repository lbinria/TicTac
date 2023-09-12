package org.lbee;

import org.lbee.instrumentation.BehaviorRecorder;
import org.lbee.instrumentation.VirtualField;
import org.lbee.instrumentation.clock.SharedClock;

import java.io.IOException;
import java.util.Random;

public class TicTacV2 implements TicTacImplementation {
    @Override
    public void run() throws IOException, InterruptedException {

        // Get & init clock
        SharedClock clock = SharedClock.get("tictac.v2.clock");
        clock.reset();

        // Init behavior recorder
        BehaviorRecorder behaviorRecorder = BehaviorRecorder.create("tictac.v2.ndjson", clock);
        // Get variables from spec
        VirtualField specClock = behaviorRecorder.getVariable("clockValue");
        VirtualField specNTick = behaviorRecorder.getVariable("nTick");
        VirtualField specNTack = behaviorRecorder.getVariable("nTack");

        Random rand = new Random(42);
        Random rand2 = new Random(42);

        final int MAX_ITER = 100;
        int clockValue = 2;
        int nTick = 0;
        int nTack = 0;

        for (int i = 0; i < MAX_ITER; i++) {

            // At random point, reset clock
            if (rand.nextInt(0, 100) == 42 && clockValue % 2 == 1)
            {
                System.out.printf("Reset clock at %s.\n", clockValue);
                clockValue = 2;
                specClock.set(2);

                behaviorRecorder.commitChanges("ResetClock");
                continue;
            }



            String eventName;
            if (clockValue % 2 == 0) {
                nTick++;
//                specNTick.apply("Add", 1);
                eventName = "Tick";
            }
            else {
                nTack++;
//                specNTack.apply("Add", 1);
                eventName = "Tack";
            }

            // Advance clock
            clockValue++;
            specClock.apply("Add", 1);

//            behaviorRecorder.commitChanges(eventName);
            behaviorRecorder.commitChanges();
            System.out.println(eventName + ".");

        }

    }
}
