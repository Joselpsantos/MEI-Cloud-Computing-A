#!/usr/bin/env python3
import paho.mqtt.client as mqtt

broker_address = "192.168.8.60"
username = "pico"
password = "pico"
topic = "my/topic"

def on_connect(client, userdata, flags, rc):
    # This will be called once the client connects
    print(f"Connected with result code {rc}")
    # Subscribe here!
    client.subscribe(topic)

def on_message(client, userdata, msg):
    print(f"Message received [{msg.topic}]: {msg.payload.decode('utf-8')}")

client = mqtt.Client("mqtt-test") # client ID "mqtt-test"
client.on_connect = on_connect
client.on_message = on_message
client.username_pw_set(username,password)
client.connect(broker_address, 1883, 60) # host, port, ka
client.loop_forever()
