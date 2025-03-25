#!/usr/bin/env python3

import psutil
import time

def get_network_speed(interface="wlp2s0"):  # Замените на ваш интерфейс
    old_value = psutil.net_io_counters(pernic=True)[interface].bytes_sent + psutil.net_io_counters(pernic=True)[interface].bytes_recv
    time.sleep(1)
    new_value = psutil.net_io_counters(pernic=True)[interface].bytes_sent + psutil.net_io_counters(pernic=True)[interface].bytes_recv
    speed = (new_value - old_value) / 1024  # Скорость в КБ/с
    return f"{speed:.1f} KB/s"

if __name__ == "__main__":
    print(get_network_speed())