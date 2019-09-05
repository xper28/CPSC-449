import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class FCFS {
    public static void main(String args[]) {
        //List to store all processes
        List<Integer> processes = new ArrayList<Integer>();
        //Read cmd line args
        String inp = args[0];
        String out = args[1];

        //Open input file to read and read processes into list
        try {
            BufferedReader reader = new BufferedReader(new FileReader(inp));
            int count = 0;
            String line = "";
            while ((line = reader.readLine()) != null) {
                String trimmed = line.trim();
                if(trimmed.isEmpty()){
                    continue;
                }
                int temp = Integer.parseInt(trimmed);
                processes.add(count, temp);
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
        try{
            BufferedWriter writer = new BufferedWriter(new FileWriter(out));
            for (int i = 0; i < processes.size(); i++){
                writer.write(Integer.toString(currWait));
                writer.newLine();
                totalWait += currWait;
                currWait += processes.get(i);
            }
            //Print out avg wait time
            double avgWait = totalWait/processes.size();
            System.out.println(avgWait);
            writer.write(Double.toString(avgWait));
            writer.close();
        }
        catch(IOException e){
            System.out.println(e);
        }
    }
}
