Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DD9682BD5
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 12:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjAaLvg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 06:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjAaLvf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 06:51:35 -0500
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 03:51:31 PST
Received: from pi.fatal.se (94-255-170-6.cust.bredband2.com [94.255.170.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D315B35B7
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 03:51:31 -0800 (PST)
Received: by pi.fatal.se (Postfix, from userid 1000)
        id 6341128D45; Tue, 31 Jan 2023 12:46:11 +0100 (CET)
Date:   Tue, 31 Jan 2023 12:46:11 +0100
From:   Andreas Henriksson <andreas@fatal.se>
To:     linux-wireless@vger.kernel.org
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>
Subject: rtw88: rtw8822cu (LM842) stalls completely, needs replugging to wake
 up.
Message-ID: <20230131114611.sm6m3fc4g5n7lhqc@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        TO_NO_BRKTS_PCNT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I've tested the rtw88 usb driver additions that was merged in 6.2-rc1 on an LM842 dongle (rtw8822cu)
and would like to ask if anyone else has noticed the problems I'm seeing.
After downloading a certain amount of data the traffic just completely stalls. No error messages
(not even when using rtw88_core with debug_mask=0xff).

My dongle:
https://www.lm-technologies.com/product/wifi-802-11ac-bluetooth-5-0-2t2r-usb-combi-adapter-lm842/

I've tested on 2 different systems (32bit arm + arm64) and can reproduce
the problem on both (although alot quicker on the 32bit system, on arm64
it would usually trigger around 3GB downloaded).

I've tried different version of the firmware. I'm using a debian
userspace and tried with the following versions of "firmware-realtek":

 stable: 20210315-3
 stable-bpo: 20210818-1~bpo11+1
 testing: 20221214-5

https://tracker.debian.org/firmware-realtek


The problem occurs both on 2.4GHz and 5GHz networks but only for *downloads* as far as I can tell. I've also tested different APs.

When the traffic stalls, the only way I've found to recover is to yank
the dongle and replug it. It also works to unbind and bind the device
(which I guess is pretty much the same thing).

There are no relevant/obvious error messages in dmesg when the stall
happens. The only real error I can see is that if I take the link down
(succeeds) and the tries to take it back up again I get:

```
$ sudo ip link set dev wlx34c9f08deb6e up
[  633.627674] rtw_8822cu 1-1:1.2: error beacon valid
[  633.636167] rtw_8822cu 1-1:1.2: failed to download rsvd page
[  633.651576] rtw_8822cu 1-1:1.2: failed to download firmware
```












Here's a bit more log to show what I did to reproduce the problem:

```
$ wget -O /dev/null http://speedtest.tele2.net/10GB.zip
--2023-01-31 10:32:30--  http://speedtest.tele2.net/10GB.zip
Resolving speedtest.tele2.net (speedtest.tele2.net)... 90.130.70.73, 2a00:800:1010::1
Connecting to speedtest.tele2.net (speedtest.tele2.net)|90.130.70.73|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 10737418240 (10G) [application/zip]
Saving to: ‘/dev/null’

/dev/null             0%[                    ]  17.40M  3.37MB/s    eta 52m 8s
/dev/null             0%[                    ]  89.12M  2.09MB/s    eta 58m 11s
/dev/null             1%[                    ] 194.33M  --.-KB/s    eta 62m 14s
/dev/null             1%[                    ] 194.33M  --.-KB/s    eta 65m 31s
/dev/null             1%[                    ] 194.33M  --.-KB/s    eta 70m 27s
^C

$ ip neigh
192.168.1.1 dev wlx34c9f08deb6e lladdr 04:a1:51:c0:f9:84 DELAY

$ ping -n -c 3 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
^C
--- 8.8.8.8 ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1050ms

$ dmesg | tail
[   37.426535] Micrel KSZ8081 or KSZ8091 2188000.ethernet-1:01: attached PHY driver (mii_bus:phy_addr=2188000.ethernet-1:01, irq=POLL)
[   38.086142] Micrel KSZ8081 or KSZ8091 2188000.ethernet-1:03: attached PHY driver (mii_bus:phy_addr=2188000.ethernet-1:03, irq=POLL)
[   98.560361] hrtimer: interrupt took 714333 ns
[  384.499968] wlx34c9f08deb6e: authenticate with 82:2a:a8:8b:15:93
[  389.575902] wlx34c9f08deb6e: send auth to 82:2a:a8:8b:15:93 (try 1/3)
[  389.591437] wlx34c9f08deb6e: authenticated
[  389.625692] wlx34c9f08deb6e: associate with 82:2a:a8:8b:15:93 (try 1/3)
[  389.660940] wlx34c9f08deb6e: RX AssocResp from 82:2a:a8:8b:15:93 (capab=0x411 status=0 aid=2)
[  389.738412] wlx34c9f08deb6e: associated
[  390.125777] IPv6: ADDRCONF(NETDEV_CHANGE): wlx34c9f08deb6e: link becomes ready

$ sudo ip link set dev wlx34c9f08deb6e down
[  626.938024] wlx34c9f08deb6e: deauthenticating from 82:2a:a8:8b:15:93 by local choice (Reason: 3=DEAUTH_LEAVING)

$ sudo ip link set dev wlx34c9f08deb6e up
[  633.627674] rtw_8822cu 1-1:1.2: error beacon valid
[  633.636167] rtw_8822cu 1-1:1.2: failed to download rsvd page
[  633.651576] rtw_8822cu 1-1:1.2: failed to download firmware
RTNETLINK answers: Device or resource busy
```


Now to recover:

```
/sys/bus/usb/drivers/rtw_8822cu# ls
1-1:1.2  bind  module  new_id  remove_id  uevent  unbind

/sys/bus/usb/drivers/rtw_8822cu# echo 1-1\:1.2 > unbind
[ 1111.287044] Bluetooth: hci0: urb 9b3b80d1 failed to resubmit (2)
[ 1111.341278] rtw_8822cu 1-1:1.2: failed to get tx report from firmware
[ 1111.734386] usb 1-1: reset high-speed USB device number 2 using ci_hdrc
[ 1112.082998] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=09a8 lmp_ver=0a lmp_subver=a0cb
[ 1112.313635] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c lmp_ver=0a lmp_subver=8822
[ 1112.327152] Bluetooth: hci0: RTL: rom_version status=0 version=3
[ 1112.333590] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[ 1112.343427] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[ 1112.350894] Bluetooth: hci0: RTL: cfg_sz 6, total sz 38782
[ 1112.605276] Bluetooth: hci0: RTL: fw version 0x09a8a0cb
[ 1112.706788] Bluetooth: MGMT ver 1.22

/sys/bus/usb/drivers/rtw_8822cu# echo 1-1\:1.2 > bind
[ 1120.637698] rtw_8822cu 1-1:1.2: Firmware version 9.9.10, H2C version 15
[ 1120.668770] rtw_8822cu 1-1:1.2: WOW Firmware version 9.9.4, H2C version 15
[ 1121.625334] rtw_8822cu 1-1:1.2 wlx34c9f08deb6e: renamed from wlan0

/sys/bus/usb/drivers/rtw_8822cu# nmcli c up ubnt5g
[ 1169.758065] wlx34c9f08deb6e: authenticate with 82:2a:a8:8b:15:93
[ 1174.593034] wlx34c9f08deb6e: send auth to 82:2a:a8:8b:15:93 (try 1/3)
[ 1174.604704] wlx34c9f08deb6e: authenticated
[ 1174.683291] wlx34c9f08deb6e: associate with 82:2a:a8:8b:15:93 (try 1/3)
[ 1174.742427] wlx34c9f08deb6e: RX AssocResp from 82:2a:a8:8b:15:93 (capab=0x411 status=0 aid=2)
[ 1174.863893] wlx34c9f08deb6e: associated
[ 1175.043744] IPv6: ADDRCONF(NETDEV_CHANGE): wlx34c9f08deb6e: link becomes ready
Connection successfully activated (D-Bus active path: /org/freedesktop/NetworkManager/ActiveConnection/3)

/sys/bus/usb/drivers/rtw_8822cu# ping -n -c 3 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=55 time=17.8 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=55 time=15.0 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=55 time=15.5 ms

--- 8.8.8.8 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2005ms
rtt min/avg/max/mdev = 15.046/16.102/17.797/1.210 ms
/sys/bus/usb/drivers/rtw_8822cu#
```


Plug info:

```
[ 1501.660950] usb 1-1: New USB device found, idVendor=0bda, idProduct=c82c, bcdDevice= 0.00
[ 1501.669356] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1501.676744] usb 1-1: Product: 802.11ac NIC
[ 1501.680876] usb 1-1: Manufacturer: Realtek
[ 1501.685149] usb 1-1: SerialNumber: 123456
[ 1501.791905] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c lmp_ver=0a lmp_subver=8822
[ 1501.808695] Bluetooth: hci0: RTL: rom_version status=0 version=3
[ 1501.814888] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[ 1501.823992] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[ 1501.831631] Bluetooth: hci0: RTL: cfg_sz 6, total sz 38782
[ 1501.919854] rtw_8822cu 1-1:1.2: Firmware version 9.9.10, H2C version 15
[ 1501.958637] rtw_8822cu 1-1:1.2: WOW Firmware version 9.9.4, H2C version 15
[ 1502.099501] Bluetooth: hci0: RTL: fw version 0x09a8a0cb
[ 1502.193978] Bluetooth: MGMT ver 1.22
```


Testing with upgraded firmware-realtek:

```
# 
[  133.146482] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[  133.383211] usb 1-1: New USB device found, idVendor=0bda, idProduct=c82c, bcdDevice= 0.00
[  133.392493] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[  133.400127] usb 1-1: Product: 802.11ac NIC
[  133.404668] usb 1-1: Manufacturer: Realtek
[  133.408831] usb 1-1: SerialNumber: 123456
[  133.958378] usbcore: registered new interface driver btusb
[  134.003839] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c lmp_ver=0a lmp_subver=8822
[  134.017315] Bluetooth: hci0: RTL: rom_version status=0 version=3
[  134.023680] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[  134.046459] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[  134.058542] Bluetooth: hci0: RTL: cfg_sz 6, total sz 35458
[  134.250277] rtw_8822cu 1-1:1.2: Firmware version 9.9.13, H2C version 15
[  134.310449] rtw_8822cu 1-1:1.2: WOW Firmware version 9.9.4, H2C version 15
[  134.355176] Bluetooth: hci0: RTL: fw version 0xffb8abd3
[  134.451791] Bluetooth: MGMT ver 1.22
[  135.360112] usbcore: registered new interface driver rtw_8822cu
[  135.775082] rtw_8822cu 1-1:1.2 wlx34c9f08deb6e: renamed from wlan0
[  164.259307] wlx34c9f08deb6e: authenticate with 82:2a:a8:8b:15:93
[  168.831972] wlx34c9f08deb6e: send auth to 82:2a:a8:8b:15:93 (try 1/3)
[  168.848679] wlx34c9f08deb6e: authenticated
[  168.945306] wlx34c9f08deb6e: associate with 82:2a:a8:8b:15:93 (try 1/3)
[  169.015007] wlx34c9f08deb6e: RX AssocResp from 82:2a:a8:8b:15:93 (capab=0x411 status=0 aid=2)
[  169.120547] wlx34c9f08deb6e: associated
[  169.540323] IPv6: ADDRCONF(NETDEV_CHANGE): wlx34c9f08deb6e: link becomes ready



$ wget -O /dev/null http://speedtest.tele2.net/10GB.zip
--2023-01-31 10:59:32--  http://speedtest.tele2.net/10GB.zip
Resolving speedtest.tele2.net (speedtest.tele2.net)... 90.130.70.73, 2a00:800:1010::1
Connecting to speedtest.tele2.net (speedtest.tele2.net)|90.130.70.73|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 10737418240 (10G) [application/zip]
Saving to: ‘/dev/null’

/dev/null             0%[                    ]  23.42M  4.12MB/s    eta 41m 27s
/dev/null             0%[                    ]  92.36M  3.83MB/s    eta 41m 58s
/dev/null             3%[                    ] 331.75M  3.85MB/s    eta 43m 5s
/dev/null             3%[                    ] 338.69M  1.85MB/s    eta 44m 26s



/dev/null             3%[                    ] 338.69M  --.-KB/s    eta 47m 13s
/dev/null             3%[                    ] 338.69M  --.-KB/s    eta 55m 34s
/dev/null             3%[                    ] 338.69M  --.-KB/s    eta 60m 13s
/dev/null             3%[                    ] 338.69M  --.-KB/s    eta 61m 9s 
^C


##### pulling dongle

$
[  424.730686] usb 1-1: USB disconnect, device number 2
[  424.999929] wlx34c9f08deb6e: deauthenticating from 82:2a:a8:8b:15:93 by local choice (Reason: 3=DEAUTH_LEAVING)
[  425.639332] rtw_8822cu 1-1:1.2: timed out to flush queue 0
[  426.022426] rtw_8822cu 1-1:1.2: timed out to flush queue 2
[  426.223475] rtw_8822cu 1-1:1.2: timed out to flush queue 3

```




Reproducing with rtw88_core debug_mask=0xff:

```

# modprobe rtw88_core debug_mask=0xff

#
[   96.578079] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[   96.832223] usb 1-1: New USB device found, idVendor=0bda, idProduct=c82c, bcdDevice= 0.00
[   96.841442] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   96.849063] usb 1-1: Product: 802.11ac NIC
[   96.853377] usb 1-1: Manufacturer: Realtek
[   96.857541] usb 1-1: SerialNumber: 123456
[   97.415773] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c lmp_ver=0a lmp_subver=8822
[   97.430499] Bluetooth: hci0: RTL: rom_version status=0 version=3
[   97.436891] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[   97.452705] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[   97.461214] Bluetooth: hci0: RTL: cfg_sz 6, total sz 35458
[   97.483763] usbcore: registered new interface driver btusb
[   97.535332] rtw_8822cu 1-1:1.2: WOW Firmware version 9.9.4, H2C version 15
[   97.561501] rtw_8822cu 1-1:1.2: Firmware version 9.9.13, H2C version 15
[   97.760431] Bluetooth: hci0: RTL: fw version 0xffb8abd3
[   97.855425] Bluetooth: MGMT ver 1.22
[   98.653772] usbcore: registered new interface driver rtw_8822cu
[   99.014427] rtw_8822cu 1-1:1.2 wlx34c9f08deb6e: renamed from wlan0

# 
[  127.024456] wlx34c9f08deb6e: authenticate with 82:2a:a8:8b:15:93

#
[  131.843545] wlx34c9f08deb6e: send auth to 82:2a:a8:8b:15:93 (try 1/3)
[  131.856291] wlx34c9f08deb6e: authenticated
[  131.905151] wlx34c9f08deb6e: associate with 82:2a:a8:8b:15:93 (try 1/3)
[  131.962055] wlx34c9f08deb6e: RX AssocResp from 82:2a:a8:8b:15:93 (capab=0x411 status=0 aid=2)
[  132.065220] wlx34c9f08deb6e: associated
[  132.589550] IPv6: ADDRCONF(NETDEV_CHANGE): wlx34c9f08deb6e: link becomes ready


# wget -O /dev/null http://speedtest.tele2.net/10GB.zip
--2023-01-31 11:30:18--  http://speedtest.tele2.net/10GB.zip
Resolving speedtest.tele2.net (speedtest.tele2.net)... 90.130.70.73, 2a00:800:1010::1
Connecting to speedtest.tele2.net (speedtest.tele2.net)|90.130.70.73|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 10737418240 (10G) [application/zip]
Saving to: ‘/dev/null’

/dev/null             0%[                    ]  25.40M  2.88MB/s    eta 58m 35s
/dev/null             0%[                    ]  45.68M  --.-KB/s    eta 83m 0s
/dev/null             0%[                    ]  45.68M  --.-KB/s    eta 97m 12s
^C

# dmesg | tail -n 30
[  180.447344] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0x39, len=6
[  182.417144] rtw_8822cu 1-1:1.2: [BTCoex], Hi-Pri Rx/Tx: 1/0, Lo-Pri Rx/Tx: 0/0
[  182.417236] rtw_8822cu 1-1:1.2: send H2C content 29000042 00000002
[  182.440044] rtw_8822cu 1-1:1.2: send H2C content 00000058 0019043d
[  182.459176] rtw_8822cu 1-1:1.2: send H2C content 0029105a 00000005
[  182.460598] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0x3a, len=6
[  182.578075] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 14
[  182.578222] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 0
[  182.586018] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_wl_under5g()
[  182.586082] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[  182.587018] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[  182.587074] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_5G_RUNTIME
[  182.597496] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 0
[  182.598482] rtw_8822cu 1-1:1.2: [BTCoex], Skip TDMA because no change TDMA(off, 0)
[  184.416502] rtw_8822cu 1-1:1.2: [BTCoex], Hi-Pri Rx/Tx: 3/0, Lo-Pri Rx/Tx: 0/0
[  184.416590] rtw_8822cu 1-1:1.2: send H2C content 29000042 00000002
[  184.435229] rtw_8822cu 1-1:1.2: send H2C content 00000058 001b043d
[  184.449164] rtw_8822cu 1-1:1.2: send H2C content 0029105a 00000005
[  184.450511] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0x3b, len=6
[  186.426871] rtw_8822cu 1-1:1.2: [BTCoex], Hi-Pri Rx/Tx: 2/0, Lo-Pri Rx/Tx: 0/0
[  186.427045] rtw_8822cu 1-1:1.2: send H2C content 29000042 00000002
[  186.452141] rtw_8822cu 1-1:1.2: send H2C content 00000058 001a043d
[  186.458538] rtw_8822cu 1-1:1.2: send H2C content 0029105a 00000005
[  186.459954] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0x3c, len=6
[  188.416105] rtw_8822cu 1-1:1.2: [BTCoex], Hi-Pri Rx/Tx: 3/0, Lo-Pri Rx/Tx: 0/0
[  188.416192] rtw_8822cu 1-1:1.2: send H2C content 29000042 00000002
[  188.438151] rtw_8822cu 1-1:1.2: send H2C content 00000058 001b043d
[  188.438923] rtw_8822cu 1-1:1.2: send H2C content 5d890040 ffffc000
[  188.449887] rtw_8822cu 1-1:1.2: send H2C content 0029105a 00000005
[  188.451074] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0x3d, len=6


# ip link set dev wlx34c9f08deb6e down
[  496.548202] wlx34c9f08deb6e: deauthenticating from 82:2a:a8:8b:15:93 by local choice (Reason: 3=DEAUTH_LEAVING)

# ip link set dev wlx34c9f08deb6e up
[  507.455259] rtw_8822cu 1-1:1.2: error beacon valid
[  507.461628] rtw_8822cu 1-1:1.2: failed to download rsvd page
[  507.475390] rtw_8822cu 1-1:1.2: failed to download firmware
RTNETLINK answers: Device or resource busy

# dmesg | tail -n 30
[  494.451618] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0xd6, len=6
[  496.416099] rtw_8822cu 1-1:1.2: [BTCoex], Hi-Pri Rx/Tx: 3/0, Lo-Pri Rx/Tx: 0/0
[  496.416150] rtw_8822cu 1-1:1.2: send H2C content 28000042 00000002
[  496.428165] rtw_8822cu 1-1:1.2: send H2C content 00000058 001b043d
[  496.443824] rtw_8822cu 1-1:1.2: send H2C content 0028105a 00000005
[  496.445828] rtw_8822cu 1-1:1.2: recv C2H, id=0x37, seq=0xd7, len=6
[  496.544758] rtw_8822cu 1-1:1.2: config rx filter, changed=0x00000000, new=0x00000000, rcr=0xf410408e
[  496.548202] wlx34c9f08deb6e: deauthenticating from 82:2a:a8:8b:15:93 by local choice (Reason: 3=DEAUTH_LEAVING)
[  496.634009] rtw_8822cu 1-1:1.2: send H2C content 00000057 00000000
[  496.644913] rtw_8822cu 1-1:1.2: send H2C content 00000001 00000000
[  496.722391] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_switchband_notify(): TO_5G
[  496.722496] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_run_coex(): reason = 4
[  496.722523] rtw_8822cu 1-1:1.2: [BTCoex], wl_noisy_level = 0
[  496.722780] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_wl_under5g()
[  496.722810] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[  496.723406] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[  496.723438] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_5G_RUNTIME
[  496.742916] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 0
[  496.748724] rtw_8822cu 1-1:1.2: [BTCoex], Skip TDMA because no change TDMA(off, 0)
[  496.787572] rtw_8822cu 1-1:1.2: [BTCoex], IPS ENTER notify
[  496.787927] rtw_8822cu 1-1:1.2: [BTCoex], (Before Ant Setup) Delay by IQK
[  496.788518] rtw_8822cu 1-1:1.2: [BTCoex],  coex_stat->bt_disabled = 0x0
[  496.788551] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_ant_path() - PHASE_WLAN_OFF
[  496.789073] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_action_coex_all_off()
[  496.789106] rtw_8822cu 1-1:1.2: [BTCoex], Coex_Table - 2
[  496.790284] rtw_8822cu 1-1:1.2: [BTCoex], rtw_coex_set_table(): 0x6c0 = 66555555, 0x6c4 = 66555555
[  496.790324] rtw_8822cu 1-1:1.2: [BTCoex], Skip TDMA because no change TDMA(off, 0)
[  507.455259] rtw_8822cu 1-1:1.2: error beacon valid
[  507.461628] rtw_8822cu 1-1:1.2: failed to download rsvd page
[  507.475390] rtw_8822cu 1-1:1.2: failed to download firmware
#

```

If anyone has any clues or if you can just confirm/deny you're also seeing this problem I would be greatful!

Regards,
Andreas Henriksson
