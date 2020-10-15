Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA3128F63E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Oct 2020 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbgJOP6W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Oct 2020 11:58:22 -0400
Received: from outbound.soverin.net ([116.202.65.218]:49341 "EHLO
        outbound.soverin.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730085AbgJOP6V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Oct 2020 11:58:21 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Oct 2020 11:58:20 EDT
Received: from smtp.soverin.net (unknown [10.10.3.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 94ABD60AA0;
        Thu, 15 Oct 2020 15:52:30 +0000 (UTC)
Received: from smtp.soverin.net (smtp.soverin.net [159.69.232.138]) by soverin.net
To:     linux-wireless@vger.kernel.org
From:   Jack Mitchell <ml@embed.me.uk>
Subject: brcmfmac: low throughput/high retries 2.4GHz AP
Cc:     Brett Rudley <brudley@broadcom.com>,
        Arend van Spriel <arend@broadcom.com>,
        "Franky (Zhenhui) Lin" <frankyl@broadcom.com>,
        Hante Meuleman <meuleman@broadcom.com>,
        brcm80211-dev-list@broadcom.com, Phillip Karls <prkarls@gmail.com>
Message-ID: <669dfc09-6ff8-2323-25d7-51917a9c30d3@embed.me.uk>
Date:   Thu, 15 Oct 2020 16:52:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have a few boards with Ampak 6256 chipsets which all have an issue
with 2.4GHz AP throughput and I am keen to find out if this is a known
issue or limitation of the chipset. The AP6256 contains a brcm43456 and
I have seen similar performance issues all the way back to Linux v5.2, I
haven't tested any further than that. I have also tried with various
available firmware found around the internet which has made no difference.

If anybody has any input on how to debug or if they know anything about
the issue I would be very interested to hear about it.

Please see some iperf3 throughput results below as examples. These were
conducted in a residential environment with very few other APs in the
vicinity.

AP6256 2.4GHz Channel 11 AP
---------------------------

[root@alarm ~]# cat /etc/hostapd/hostapd.conf
interface=wlan1
driver=nl80211
ctrl_interface=/var/run/hostapd
ssid=test
channel=11
ieee80211n=1
hw_mode=g
ignore_broadcast_ssid=0

Connecting to host 192.168.10.121, port 5201
[  5] local 192.168.10.1 port 38954 connected to 192.168.10.121 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  1.69 MBytes  14.2 Mbits/sec  112   17.0 KBytes
[  5]   1.00-2.00   sec  1.12 MBytes  9.38 Mbits/sec   40   15.6 KBytes
[  5]   2.00-3.00   sec  1.12 MBytes  9.38 Mbits/sec   28   15.6 KBytes
[  5]   3.00-4.00   sec  1.24 MBytes  10.4 Mbits/sec   22   24.0 KBytes
[  5]   4.00-5.00   sec   891 KBytes  7.30 Mbits/sec   23   18.4 KBytes
[  5]   5.00-6.00   sec  1.49 MBytes  12.5 Mbits/sec   36   15.6 KBytes
[  5]   6.00-7.00   sec  1.12 MBytes  9.38 Mbits/sec   23   18.4 KBytes
[  5]   7.00-8.00   sec  1018 KBytes  8.34 Mbits/sec   17   14.1 KBytes
[  5]   8.00-9.00   sec  1.24 MBytes  10.4 Mbits/sec   28   14.1 KBytes
[  5]   9.00-10.00  sec  1018 KBytes  8.34 Mbits/sec   29   11.3 KBytes
[  5]  10.00-11.00  sec  1.12 MBytes  9.38 Mbits/sec   25   15.6 KBytes
[  5]  11.00-12.00  sec  1.24 MBytes  10.4 Mbits/sec   21   17.0 KBytes
[  5]  12.00-13.00  sec  1018 KBytes  8.34 Mbits/sec   23   33.9 KBytes
[  5]  13.00-14.00  sec  1.12 MBytes  9.38 Mbits/sec   35   14.1 KBytes
[  5]  14.00-15.00  sec  1.37 MBytes  11.5 Mbits/sec   33   24.0 KBytes
[  5]  15.00-16.00  sec  1.12 MBytes  9.38 Mbits/sec   19   14.1 KBytes
[  5]  16.00-17.00  sec   891 KBytes  7.30 Mbits/sec   19   8.48 KBytes
[  5]  17.00-18.00  sec  1.37 MBytes  11.5 Mbits/sec   27   17.0 KBytes
[  5]  18.00-19.00  sec  1.37 MBytes  11.5 Mbits/sec   26   15.6 KBytes
[  5]  19.00-20.00  sec  1.12 MBytes  9.38 Mbits/sec   51   17.0 KBytes
[  5]  20.00-21.00  sec  1018 KBytes  8.34 Mbits/sec   23   5.66 KBytes
[  5]  21.00-22.00  sec  1.12 MBytes  9.38 Mbits/sec   28   17.0 KBytes
[  5]  22.00-23.00  sec   891 KBytes  7.30 Mbits/sec   23   9.90 KBytes
[  5]  23.00-24.00  sec  1.49 MBytes  12.5 Mbits/sec   28   18.4 KBytes
[  5]  24.00-25.00  sec  1.24 MBytes  10.4 Mbits/sec   25   19.8 KBytes
[  5]  25.00-26.00  sec  1.12 MBytes  9.38 Mbits/sec   23   9.90 KBytes
[  5]  26.00-27.00  sec  1.37 MBytes  11.5 Mbits/sec   27   17.0 KBytes
[  5]  27.00-28.00  sec  1.49 MBytes  12.5 Mbits/sec   22   18.4 KBytes
[  5]  28.00-29.00  sec  1.37 MBytes  11.5 Mbits/sec   27   14.1 KBytes
[  5]  29.00-30.00  sec  1018 KBytes  8.34 Mbits/sec   15   18.4 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-30.00  sec  35.6 MBytes  9.96 Mbits/sec  878             sender
[  5]   0.00-30.00  sec  35.6 MBytes  9.96 Mbits/sec
receiver

iperf Done.

AP6256 5GHz Channel 36 AP
-------------------------

[root@alarm ~]# iperf3 -c 192.168.10.121 -t 30
Connecting to host 192.168.10.121, port 5201
[  5] local 192.168.10.1 port 50634 connected to 192.168.10.121 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  7.18 MBytes  60.2 Mbits/sec    0    332 KBytes
[  5]   1.00-2.00   sec  8.76 MBytes  73.5 Mbits/sec    0    553 KBytes
[  5]   2.00-3.00   sec  9.01 MBytes  75.6 Mbits/sec    0    697 KBytes
[  5]   3.00-4.00   sec  8.02 MBytes  67.2 Mbits/sec    0    773 KBytes
[  5]   4.00-5.00   sec  8.82 MBytes  74.0 Mbits/sec    0    911 KBytes
[  5]   5.00-6.00   sec  8.26 MBytes  69.3 Mbits/sec    0    981 KBytes
[  5]   6.00-7.00   sec  8.76 MBytes  73.5 Mbits/sec    0    981 KBytes
[  5]   7.00-8.00   sec  7.83 MBytes  65.7 Mbits/sec    0    981 KBytes
[  5]   8.00-9.00   sec  9.20 MBytes  77.2 Mbits/sec    0   1.07 MBytes
[  5]   9.00-10.00  sec  8.20 MBytes  68.8 Mbits/sec    0   1.07 MBytes
[  5]  10.00-11.00  sec  8.26 MBytes  69.3 Mbits/sec    0   1.13 MBytes
[  5]  11.00-12.00  sec  8.45 MBytes  70.9 Mbits/sec    0   1.13 MBytes
[  5]  12.00-13.00  sec  8.51 MBytes  71.4 Mbits/sec    0   1.13 MBytes
[  5]  13.00-14.00  sec  8.51 MBytes  71.4 Mbits/sec    0   1.13 MBytes
[  5]  14.00-15.00  sec  8.68 MBytes  72.8 Mbits/sec    0   1.58 MBytes
[  5]  15.00-16.00  sec  7.50 MBytes  62.9 Mbits/sec    0   1.58 MBytes
[  5]  16.00-17.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes
[  5]  17.00-18.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes
[  5]  18.00-19.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes
[  5]  19.00-20.00  sec  7.50 MBytes  62.9 Mbits/sec    0   1.58 MBytes
[  5]  20.00-21.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes
[  5]  21.00-22.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes
[  5]  22.00-23.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes
[  5]  23.00-24.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes
[  5]  24.00-25.00  sec  7.50 MBytes  62.9 Mbits/sec    0   1.58 MBytes
[  5]  25.00-26.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes
[  5]  26.00-27.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes
[  5]  27.00-28.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes
[  5]  28.00-29.00  sec  7.50 MBytes  62.9 Mbits/sec    0   1.58 MBytes
[  5]  29.00-30.00  sec  8.75 MBytes  73.4 Mbits/sec    0   1.58 MBytes

- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-30.00  sec   253 MBytes  70.7 Mbits/sec    0             sender
[  5]   0.00-30.00  sec   250 MBytes  69.9 Mbits/sec
receiver

iperf Done.

AP6256 2.4GHz Channel 11 STA
----------------------------

[root@alarm ~]# iw wlan0 info
Interface wlan0
	ifindex 3
	wdev 0x1
	addr c0:84:7d:31:5d:d4
	ssid test
	type managed
	wiphy 0
	channel 11 (2462 MHz), width: 20 MHz, center1: 2462 MHz
	txpower 31.00 dBm

[root@alarm ~]# iperf3 -c 192.168.11.1
Connecting to host 192.168.11.1, port 5201
[  5] local 192.168.11.70 port 58330 connected to 192.168.11.1 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  2.71 MBytes  22.7 Mbits/sec    0    146 KBytes
[  5]   1.00-2.00   sec  3.42 MBytes  28.7 Mbits/sec    0    280 KBytes
[  5]   2.00-3.00   sec  3.29 MBytes  27.6 Mbits/sec    0    407 KBytes
[  5]   3.00-4.00   sec  3.04 MBytes  25.5 Mbits/sec    0    553 KBytes
[  5]   4.00-5.00   sec  3.23 MBytes  27.1 Mbits/sec    0    696 KBytes
[  5]   5.00-6.00   sec  3.23 MBytes  27.1 Mbits/sec    0    844 KBytes
[  5]   6.00-7.00   sec  3.73 MBytes  31.3 Mbits/sec    0    892 KBytes
[  5]   7.00-8.00   sec  2.80 MBytes  23.5 Mbits/sec    1    624 KBytes
[  5]   8.00-9.00   sec  2.80 MBytes  23.5 Mbits/sec    0    711 KBytes
[  5]   9.00-10.00  sec  2.80 MBytes  23.5 Mbits/sec    0    711 KBytes

- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  31.0 MBytes  26.0 Mbits/sec    1             sender
[  5]   0.00-10.04  sec  29.4 MBytes  24.5 Mbits/sec
receiver

iperf Done.
