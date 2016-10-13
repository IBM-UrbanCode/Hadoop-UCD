/**
 * � Copyright IBM Corporation 2014, 2016.  
 * This is licensed under the following license.
 * The Eclipse Public 1.0 License (http://www.eclipse.org/legal/epl-v10.html)
 * U.S. Government Users Restricted Rights:  Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
 */
package com.ibm.rational.deploy.Hadoop;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class is responsible for parsing the parameters and forming hadoop command.
 * That hadoop command will be executed and the output will be displayed to the user.
 *
 */
public class ParseParameters {

	private static Process proc = null;
	public boolean status = false;
	private static List<String> fullcommand = new ArrayList<String>();

	private static String BUNDLE = "com.ibm.rational.deploy.Hadoop.messages";
	private static Logger logger = Logger.getLogger(ParseParameters.class.getName(), BUNDLE);
	private static int exitCode = 0;
	private static boolean processFinished = false;
	private static final int SLEEP_TIME = 100;

	/**
	 * The entry point for this program. It is responsible for forming the hadoop command.
	 * @param args
	 */
	public static void main(String[] args) {
		String hadoop = args[0];
		String command = args[1];
		String jarname = args[2];
		String parameters = args[3];
		String[] Jar_Parameters = parameters.split(" ");

		fullcommand.add(hadoop);
		fullcommand.add(command);
		fullcommand.add(jarname);
		for (String a : Jar_Parameters)
			fullcommand.add(a);
		int rc = 0;
		try {
			rc = run();
		} catch (Exception e) {
			logger.log(Level.SEVERE, "CRWUD00001E");
			logger.log(Level.SEVERE, e.getLocalizedMessage());
			e.printStackTrace();
			rc = -1;
		}

		if(rc==0) {
			logger.log(Level.INFO, "CRWUD00001I");
		}

		System.exit(rc);
	}

	/**
	 * A private method which is responsible for executing the hadoop command and displaying the output to the user.
	 * @return return code
	 * @throws IOException
	 */
	private static int run() throws IOException {
		ProcessBuilder builder = new ProcessBuilder(fullcommand);
		builder.redirectErrorStream(true);
		builder.environment().putAll(System.getenv());
		builder.environment().put("JAVA_HOME", System.getProperty("java.home"));
		try {
			proc = builder.start();
		} catch (IOException e1) {
			logger.log(Level.SEVERE, e1.getLocalizedMessage());
		}

		Thread waiter = new Thread() {
			public void run() {
				try {
					proc.waitFor();
				} catch (InterruptedException ex) {
					ParseParameters.exitCode = -1;
					processFinished = true;
					return;
				}
				ParseParameters.exitCode = proc.exitValue();
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
				}
				proc.destroy();
				proc = null;
				processFinished = true;
			}
		};
		waiter.start();

		BufferedReader reader = new BufferedReader(new InputStreamReader(
				proc.getInputStream(), "UTF-8"));
		StringBuffer output = new StringBuffer();
		String line;
		while ((line = reader.readLine()) != null) {
			output.append(line + "\n");
		}
		while (!processFinished) {
			try {
				Thread.sleep(SLEEP_TIME);
			} catch (InterruptedException e) {
				logger.log(Level.SEVERE, e.getLocalizedMessage());
			}
		}
		logger.log(Level.INFO, output.toString());
		return ParseParameters.exitCode;
	}
}
