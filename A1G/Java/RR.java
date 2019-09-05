import java.io.*;
import java.util.*;

public class RR {
    public static void main(String args[]) {
        //List to store all processes
        List<Integer> processes = new ArrayList<>();
        int count = 0;
        int quantum = 0;
        //Read cmd line args
        String inp = args[0];
        String out = args[1];

        //Open input file to read and read processes into list
        try {
            BufferedReader reader = new BufferedReader(new FileReader(inp));
            String line = "";
            while ((line = reader.readLine()) != null) {
                String trimmed = line.trim();
                if(trimmed.isEmpty()){
                    continue;
                }
                int temp = Integer.parseInt(trimmed);
                //First line is the quantum length
                if(count == 0){
                    quantum = temp;
                }else{
                    processes.add(temp);
                }
                count++;
            }
        } catch (FileNotFoundException e) {
            System.out.println("File not found!");
        } catch (IOException e) {
            System.out.println("IOException!");
        }
        //Mend counter
        count -=1;

        //Iterate over list simulating RR
        int[] waitTimes = new int[count];
        int[] remaining = new int[count];
        //Copy burst times over
        for(int i=0; i<processes.size(); i++){
            remaining[i] = processes.get(i);
        }
        int time = 0;
        while(true){
            Boolean done = true;
            for(int i=0; i<count; i++){
                int current = remaining[i];
                //If unfinished process found
                if(remaining[i] > 0){
                    done = false;
                    int diff = current - quantum;
                    if(diff > 0){
                        time += quantum;
                        remaining[i] = diff;
                    }else{
                        time += remaining[i];
                        waitTimes[i] = time - processes.get(i);
                        remaining[i]=0;
                    }
                }
            }
            if(done){
                break;
            }
        }
        //Print out wait times
        try {
            BufferedWriter writer = new BufferedWriter((new FileWriter(out)));
            //Calculate and output avg wait time
            double totalWait = 0;
            for(int i=0; i<waitTimes.length; i++){
                writer.write(Integer.toString(waitTimes[i]));
                writer.newLine();
                System.out.println(waitTimes[i]);
                totalWait+=waitTimes[i];
            }
            double avgWait = totalWait/count;
            avgWait = (double)Math.round(avgWait*100)/100;
            writer.write(Double.toString(avgWait));
            writer.close();
        }
        catch(IOException e){

        }

    }
}
