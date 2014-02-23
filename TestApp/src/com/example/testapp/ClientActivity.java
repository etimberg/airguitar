package com.example.testapp;

import java.io.BufferedWriter;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.Socket;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;

public class ClientActivity extends Activity {

	private String serverIpAddress = "192.168.0.103";

	private final int SERVER_PORT = 3490;

	private String message = "";

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		// setContentView(R.layout.client);

		// serverIp = (EditText) findViewById(R.id.server_ip);
		// connectPhones = (Button) findViewById(R.id.connect_phones);
		// connectPhones.setOnClickListener(connectListener);
	}

	public void sendData(String s) {
		message = s;
		if (!serverIpAddress.equals("")) {
			Thread cThread = new Thread(new ClientThread());
			cThread.start();
		}
	}

	public class ClientThread implements Runnable {

		public void run() {
			try {
				InetAddress serverAddr = InetAddress.getByName(serverIpAddress);
				Log.d("ClientActivity", "C: Connecting...");
				Socket socket = new Socket(serverAddr, SERVER_PORT);
				try {
					Log.d("ClientActivity", "C: Sending command.");
					PrintWriter out = new PrintWriter(new BufferedWriter(
							new OutputStreamWriter(socket.getOutputStream())),
							true);
					// where you issue the commands
					out.println(message);
					Log.d("ClientActivity", "C: Sent.");

					Log.d("ClientActivity", "vzhang debug:" + message);
				} catch (Exception e) {
					Log.e("ClientActivity", "S: Error", e);
				}
				socket.close();
				Log.d("ClientActivity", "C: Closed.");
			} catch (Exception e) {
				Log.e("ClientActivity", "C: Error", e);
			}
		}
	}
}