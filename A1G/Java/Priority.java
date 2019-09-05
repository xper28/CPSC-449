import java.io.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
public class Priority {
    public static void main(String args[]) {
        //List to store all processes
        List<Integer> processes = new ArrayList<Integer>();
        List<Integer> priorities = new ArrayList<Integer>();
        int count = 0;
        //Read cmd line args
        String inp = args[0];
        String out = args[1];

        //Open input file to read and read processes into list
        try {
            BufferedReader reader = new BufferedReader(new FileReader(inp));
            String line = "";
            while ((line = reader.readLine()) != null) {
                if(line.isEmpty()){
                    continue;
                }
                if(line.toLowerCase().contains("burstime") ||line.toLowerCase().contains("priority")){
                    continue;
                }
                String clean = line.trim();
                String[] whole = clean.split(" ");
                int proc = Integer.parseInt(whole[0]);
                int prio = Integer.parseInt(whole[1]);
                processes.add(count, proc);
                priorities.add(count, prio);
                count++;
            }
        } catch (FileNotFoundException e) {
            System.out.println("File not found!");
        } catch (IOException e) {
            System.out.println("IOException!");
        }

        //Write outputs to output file
        int currWait = 0;
        double totalWait = 0;
        double size = processes.size();
        try{
            BufferedWriter writer = new BufferedWriter(new FileWriter(out));
            for (int i = 0; i < count; i++){
                //Find min priority
                int min = Collections.min(priorities);
                System.out.print(min + " ");
                int elem = priorities.indexOf(min);
                System.out.println(processes.get(elem));
                writer.write(Integer.toString(currWait));
                writer.newLine();
                totalWait += currWait;
                currWait += processes.get(elem);
                priorities.remove(elem);
                processes.remove(elem);
            }
            //Print out avg wait time
            double avgWait = totalWait/size;
            writer.write(Double.toString(avgWait));
            writer.close();
        }
        catch(IOException e){
            System.out.println(e);
        }
    }
}
