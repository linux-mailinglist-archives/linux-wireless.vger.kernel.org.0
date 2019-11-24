Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D05108568
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2019 23:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfKXWyZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Nov 2019 17:54:25 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:42345 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfKXWyZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Nov 2019 17:54:25 -0500
Received: by mail-vs1-f43.google.com with SMTP id a143so8745003vsd.9
        for <linux-wireless@vger.kernel.org>; Sun, 24 Nov 2019 14:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=D+r7+N7VKoelc0q8KSQNMvzvQnsKxOcGjdGDhc3FXKE=;
        b=eev30IAUyb7BQG7yyL9K+SbCKAJECbCvszoozpV/IfETWnyJCTScolDCg62yW2YhyL
         Q3B6IP/68d6NaJd/tFpVLILndy6yypfdCmhGQzWDwUyzAp0ssS9WDpvPcBeFXYyS4+YL
         lW4gXONV1WVBvkkLtPi/lY8huViWh4DDHCwOc8tGMZjvTbIGuh05X02o4NnS4xsGoxFg
         LxaWG1p/vvH+RKc+lPH2BkVmY7dmdjiJsLIfpTb5RrKh33wQcg0HdOBgLT6WyuQj4yiE
         pqnpJx6YR2RiVZX32hCcnJOjYhqcWXRiUVhibJnAeaEFVxKuxD0wvIQQos7//AVBJ6Ex
         gkeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=D+r7+N7VKoelc0q8KSQNMvzvQnsKxOcGjdGDhc3FXKE=;
        b=qf8b3RUEefLJbItq93HobFham14hPqa68KnlDP5Qfbx0YlQKFWeFcuybKaOoyoRi5f
         XHkMvIJ5JAWlg1675oPt4UvjD77013BEMzkEpGkzZ3l0a6tuehWp/B3a34Yg0FgoSWMe
         aD6gNzWGVzd8UHHU8Qwo8pH0Zm94Xmw0330Y8enN8VQLQR4CzBZaD5qekGiAX6Bbdd3p
         Wgdzumneh9I+HVf66BNDTmO8a2s/nx1TBSwjKXD1WX5qfY+m9O5cAwSs3lK58izAgeAw
         GMEwUtbWo8W57dOSBfOsM20p9FkQP2u7gsbyLzsPDGydrW0XqWOpLQBYsS+ZEVU1gqro
         Uzig==
X-Gm-Message-State: APjAAAXbI3CYSFed0L7GVEQSN3QH/2GSjpufeJLJ82YHGMu1OXTxeroJ
        VBNP17FmI8iwVXWtFFGaZWHbwc0DLByFEIiGXeyqCc9o
X-Google-Smtp-Source: APXvYqxbC3thCUfaVY25f+6roVBnLzEc0k9iHY0v5Pg23GKxEWz0uO64mg3YXUNQMLrNzcqDk1rxjQaeZ3tgqBSn2uE=
X-Received: by 2002:a67:b302:: with SMTP id a2mr5163707vsm.237.1574636063377;
 Sun, 24 Nov 2019 14:54:23 -0800 (PST)
MIME-Version: 1.0
From:   "Miguel A. Vallejo" <ea4eoz@gmail.com>
Date:   Sun, 24 Nov 2019 23:54:12 +0100
Message-ID: <CANLb0oKtYzXns1vOvq5MYwG=pPxrZfVgRZJ_DSQyMZd17AxfQg@mail.gmail.com>
Subject: TP-LINK Archer T1U USB WiFi device only works on pure N networks
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

Playing with different 802.11ac usb devices I noticed the small 5 GHz
only TP-Link Archer T1U (usbid 2357:0105) only works if you try to
connect to a pure 5 GHz 802.11n network. In this case no problem at
all.

But if you try to connect to a 802.11ac/n network, it does not
connect, falling in a endless connecting loop. Tested with kernel
5.3.0-2-amd64 (5.3.9-3) and firmware-misc-nonfree 20190717-2 (Debian
Sid) over the same WiFi router, only changing the 5 GHz band mode from
N to AC/N.

Please contact me directly if someone need more data because I'm not
subscribed to Linux Wireless mailing list.

Greetings

Syslog:

Nov 22 22:41:58 waterhole kernel: [ 5604.108872] usb 1-6: new
high-speed USB device number 9 using xhci_hcd
Nov 22 22:41:58 waterhole kernel: [ 5604.272184] usb 1-6: New USB
device found, idVendor=2357, idProduct=0105, bcdDevice= 1.00
Nov 22 22:41:58 waterhole kernel: [ 5604.272189] usb 1-6: New USB
device strings: Mfr=1, Product=2, SerialNumber=3
Nov 22 22:41:58 waterhole kernel: [ 5604.272193] usb 1-6: Product: WiFi
Nov 22 22:41:58 waterhole kernel: [ 5604.272195] usb 1-6: Manufacturer: MediaTek
Nov 22 22:41:58 waterhole kernel: [ 5604.272198] usb 1-6: SerialNumber: 1.0
Nov 22 22:41:59 waterhole kernel: [ 5604.405191] usb 1-6: reset
high-speed USB device number 9 using xhci_hcd
Nov 22 22:41:59 waterhole kernel: [ 5604.558249] usb 1-6: ASIC
revision: 76100002 MAC revision: 76502000
Nov 22 22:41:59 waterhole kernel: [ 5604.559434] usb 1-6: firmware:
direct-loading firmware mediatek/mt7610e.bin
Nov 22 22:41:59 waterhole systemd[1]:
NetworkManager-dispatcher.service: Succeeded.
Nov 22 22:42:00 waterhole kernel: [ 5605.559757] usb 1-6: EEPROM ver:02 fae:01
Nov 22 22:42:00 waterhole kernel: [ 5605.801741] ieee80211 phy11:
Selected rate control algorithm 'minstrel_ht'
Nov 22 22:42:00 waterhole NetworkManager[654]: <info>
[1574458920.4396] device (wlan0): driver supports Access Point (AP)
mode
Nov 22 22:42:00 waterhole NetworkManager[654]: <info>
[1574458920.4407] manager: (wlan0): new 802.11 Wi-Fi device
(/org/freedesktop/NetworkManager/Devices/13)
Nov 22 22:42:00 waterhole systemd[1]: Starting Load/Save RF Kill
Switch Status...
Nov 22 22:42:00 waterhole mtp-probe: checking bus 1, device 9:
"/sys/devices/pci0000:00/0000:00:14.0/usb1/1-6"
Nov 22 22:42:00 waterhole mtp-probe: bus: 1, device: 9 was not an MTP device
Nov 22 22:42:00 waterhole systemd-udevd[10423]: Using default
interface naming scheme 'v243'.
Nov 22 22:42:00 waterhole systemd-udevd[10423]: ethtool:
autonegotiation is unset or enabled, the speed and duplex are not
writable.
Nov 22 22:42:00 waterhole kernel: [ 5605.860583] usb 1-6
wlxc025e96f9d55: renamed from wlan0
Nov 22 22:42:00 waterhole systemd[1]: Started Load/Save RF Kill Switch Status.
Nov 22 22:42:00 waterhole NetworkManager[654]: <info>
[1574458920.5049] rfkill11: found Wi-Fi radio killswitch (at
/sys/devices/pci0000:00/0000:00:14.0/usb1/1-6/ieee80211/phy11/rfkill11)
(driver usb)
Nov 22 22:42:00 waterhole NetworkManager[654]: <info>
[1574458920.5176] device (wlan0): interface index 13 renamed iface
from 'wlan0' to 'wlxc025e96f9d55'
Nov 22 22:42:00 waterhole NetworkManager[654]: <info>
[1574458920.5274] device (wlxc025e96f9d55): state change: unmanaged ->
unavailable (reason 'managed', sys-iface-state: 'external')
Nov 22 22:42:00 waterhole mtp-probe: checking bus 1, device 9:
"/sys/devices/pci0000:00/0000:00:14.0/usb1/1-6"
Nov 22 22:42:00 waterhole mtp-probe: bus: 1, device: 9 was not an MTP device
Nov 22 22:42:00 waterhole systemd-udevd[10405]: Using default
interface naming scheme 'v243'.
Nov 22 22:42:01 waterhole dbus-daemon[653]: [system] Activating via
systemd: service name='org.freedesktop.nm_dispatcher'
unit='dbus-org.freedesktop.nm-dispatcher.service' requested by ':1.8'
(uid=0 pid=654 comm="/usr/sbin/NetworkManager --no-daemon ")
Nov 22 22:42:01 waterhole systemd[1]: Starting Network Manager Script
Dispatcher Service...
Nov 22 22:42:01 waterhole dbus-daemon[653]: [system] Successfully
activated service 'org.freedesktop.nm_dispatcher'
Nov 22 22:42:01 waterhole systemd[1]: Started Network Manager Script
Dispatcher Service.
Nov 22 22:42:01 waterhole wpa_supplicant[664]: dbus:
fill_dict_with_properties
dbus_interface=fi.w1.wpa_supplicant1.Interface.P2PDevice
dbus_property=P2PDeviceConfig getter failed
Nov 22 22:42:01 waterhole NetworkManager[654]: <info>
[1574458921.4166] sup-iface[0x56310c3b5a20,wlxc025e96f9d55]: supports
4 scan SSIDs
Nov 22 22:42:01 waterhole NetworkManager[654]: <info>
[1574458921.4171] device (wlxc025e96f9d55): supplicant interface
state: starting -> ready
Nov 22 22:42:01 waterhole NetworkManager[654]: <info>
[1574458921.4172] device (wlxc025e96f9d55): state change: unavailable
-> disconnected (reason 'supplicant-available', sys-iface-state:
'managed')
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5728] policy: auto-activating connection 'Wireless2'
(b7f9451b-48dc-4011-8305-649c4fd808b8)
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5749] device (wlxc025e96f9d55): Activation: starting
connection 'Wireless2' (b7f9451b-48dc-4011-8305-649c4fd808b8)
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5753] device (wlxc025e96f9d55): state change: disconnected
-> prepare (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5760] manager: NetworkManager state is now CONNECTING
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5768] device (wlxc025e96f9d55): state change: prepare ->
config (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5774] device (wlxc025e96f9d55): Activation: (wifi) access
point 'Wireless2' has security, but secrets are required.
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5775] device (wlxc025e96f9d55): state change: config ->
need-auth (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5779] sup-iface[0x56310c3b5a20,wlxc025e96f9d55]: wps: type
pbc start...
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5810] device (wlxc025e96f9d55): state change: need-auth ->
prepare (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5819] device (wlxc025e96f9d55): state change: prepare ->
config (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5822] device (wlxc025e96f9d55): Activation: (wifi)
connection 'Wireless2' has security, and secrets exist.  No new
secrets needed.
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5822] Config: added 'ssid' value 'Wireless2'
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5822] Config: added 'scan_ssid' value '1'
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5822] Config: added 'bssid' value 'A0:64:8F:XX:XX:XX'
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5822] Config: added 'key_mgmt' value 'WPA-PSK
WPA-PSK-SHA256 FT-PSK'
Nov 22 22:42:03 waterhole NetworkManager[654]: <info>
[1574458923.5822] Config: added 'psk' value '<hidden>'
Nov 22 22:42:03 waterhole wpa_supplicant[664]: wlxc025e96f9d55: SME:
Trying to authenticate with a0:64:8f:xx:xx:xx (SSID='Wireless2'
freq=5540 MHz)
Nov 22 22:42:03 waterhole kernel: [ 5608.955637] wlxc025e96f9d55:
authenticate with a0:64:8f:xx:xx:xx
Nov 22 22:42:04 waterhole kernel: [ 5609.740546] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 1/3)
Nov 22 22:42:04 waterhole NetworkManager[654]: <info>
[1574458924.3778] device (wlxc025e96f9d55): supplicant interface
state: ready -> authenticating
Nov 22 22:42:05 waterhole systemd[1]: systemd-rfkill.service: Succeeded.
Nov 22 22:42:05 waterhole kernel: [ 5611.177191] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 2/3)
Nov 22 22:42:05 waterhole kernel: [ 5611.281011] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 3/3)
Nov 22 22:42:05 waterhole kernel: [ 5611.297500] wlxc025e96f9d55:
authentication with a0:64:8f:xx:xx:xx timed out
Nov 22 22:42:06 waterhole NetworkManager[654]: <info>
[1574458926.3982] device (wlxc025e96f9d55): supplicant interface
state: authenticating -> disconnected
Nov 22 22:42:06 waterhole NetworkManager[654]: <info>
[1574458926.4982] device (wlxc025e96f9d55): supplicant interface
state: disconnected -> scanning
Nov 22 22:42:08 waterhole wpa_supplicant[664]: wlxc025e96f9d55: SME:
Trying to authenticate with a0:64:8f:xx:xx:xx (SSID='Wireless2'
freq=5540 MHz)
Nov 22 22:42:08 waterhole kernel: [ 5613.975020] wlxc025e96f9d55:
authenticate with a0:64:8f:xx:xx:xx
Nov 22 22:42:09 waterhole kernel: [ 5614.829634] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 1/3)
Nov 22 22:42:09 waterhole NetworkManager[654]: <info>
[1574458929.4679] device (wlxc025e96f9d55): supplicant interface
state: scanning -> authenticating
Nov 22 22:42:10 waterhole kernel: [ 5616.257345] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 2/3)
Nov 22 22:42:11 waterhole kernel: [ 5616.361097] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 3/3)
Nov 22 22:42:11 waterhole kernel: [ 5616.377498] wlxc025e96f9d55:
authentication with a0:64:8f:xx:xx:xx timed out
Nov 22 22:42:11 waterhole NetworkManager[654]: <info>
[1574458931.4867] device (wlxc025e96f9d55): supplicant interface
state: authenticating -> disconnected
Nov 22 22:42:11 waterhole systemd[1]:
NetworkManager-dispatcher.service: Succeeded.
Nov 22 22:42:11 waterhole NetworkManager[654]: <info>
[1574458931.9872] device (wlxc025e96f9d55): supplicant interface
state: disconnected -> scanning
Nov 22 22:42:14 waterhole wpa_supplicant[664]: wlxc025e96f9d55: SME:
Trying to authenticate with a0:64:8f:xx:xx:xx (SSID='Wireless2'
freq=5540 MHz)
Nov 22 22:42:14 waterhole kernel: [ 5619.470616] wlxc025e96f9d55:
authenticate with a0:64:8f:xx:xx:xx
Nov 22 22:42:14 waterhole kernel: [ 5620.337186] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 1/3)
Nov 22 22:42:14 waterhole NetworkManager[654]: <info>
[1574458934.9787] device (wlxc025e96f9d55): supplicant interface
state: scanning -> authenticating
Nov 22 22:42:15 waterhole kernel: [ 5621.065222] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 2/3)
Nov 22 22:42:15 waterhole kernel: [ 5621.081693] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 3/3)
Nov 22 22:42:16 waterhole kernel: [ 5622.053235] wlxc025e96f9d55:
authentication with a0:64:8f:xx:xx:xx timed out
Nov 22 22:42:17 waterhole NetworkManager[654]: <info>
[1574458937.1553] device (wlxc025e96f9d55): supplicant interface
state: authenticating -> disconnected
Nov 22 22:42:18 waterhole NetworkManager[654]: <info>
[1574458938.1555] device (wlxc025e96f9d55): supplicant interface
state: disconnected -> scanning
Nov 22 22:42:20 waterhole wpa_supplicant[664]: wlxc025e96f9d55: SME:
Trying to authenticate with a0:64:8f:xx:xx:xx (SSID='Wireless2'
freq=5540 MHz)
Nov 22 22:42:20 waterhole kernel: [ 5625.630745] wlxc025e96f9d55:
authenticate with a0:64:8f:xx:xx:xx
Nov 22 22:42:21 waterhole kernel: [ 5626.476389] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 1/3)
Nov 22 22:42:21 waterhole NetworkManager[654]: <info>
[1574458941.1150] device (wlxc025e96f9d55): supplicant interface
state: scanning -> authenticating
Nov 22 22:42:21 waterhole kernel: [ 5627.045321] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 2/3)
Nov 22 22:42:21 waterhole kernel: [ 5627.065827] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 3/3)
Nov 22 22:42:22 waterhole kernel: [ 5628.069345] wlxc025e96f9d55:
authentication with a0:64:8f:xx:xx:xx timed out
Nov 22 22:42:23 waterhole wpa_supplicant[664]: wlxc025e96f9d55:
CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="Wireless2" auth_failures=1
duration=10 reason=CONN_FAILED
Nov 22 22:42:23 waterhole NetworkManager[654]: <info>
[1574458943.1984] device (wlxc025e96f9d55): supplicant interface
state: authenticating -> disconnected
Nov 22 22:42:28 waterhole NetworkManager[654]: <info>
[1574458948.2017] device (wlxc025e96f9d55): supplicant interface
state: disconnected -> scanning
Nov 22 22:42:28 waterhole NetworkManager[654]: <warn>
[1574458948.7375] device (wlxc025e96f9d55): Activation: (wifi)
association took too long, failing activation
Nov 22 22:42:28 waterhole NetworkManager[654]: <info>
[1574458948.7376] device (wlxc025e96f9d55): state change: config ->
failed (reason 'ssid-not-found', sys-iface-state: 'managed')
Nov 22 22:42:28 waterhole NetworkManager[654]: <info>
[1574458948.7384] manager: NetworkManager state is now DISCONNECTED
Nov 22 22:42:28 waterhole NetworkManager[654]: <warn>
[1574458948.7409] device (wlxc025e96f9d55): Activation: failed for
connection 'Wireless2'
Nov 22 22:42:28 waterhole NetworkManager[654]: <info>
[1574458948.7416] device (wlxc025e96f9d55): state change: failed ->
disconnected (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:28 waterhole wpa_supplicant[664]: wlxc025e96f9d55: Reject
scan trigger since one is already pending
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3320] device (wlxc025e96f9d55): supplicant interface
state: scanning -> disconnected
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3344] policy: auto-activating connection 'Wireless2'
(b7f9451b-48dc-4011-8305-649c4fd808b8)
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3370] device (wlxc025e96f9d55): Activation: starting
connection 'Wireless2' (b7f9451b-48dc-4011-8305-649c4fd808b8)
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3373] device (wlxc025e96f9d55): state change: disconnected
-> prepare (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3380] manager: NetworkManager state is now CONNECTING
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3389] device (wlxc025e96f9d55): state change: prepare ->
config (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3396] device (wlxc025e96f9d55): Activation: (wifi) access
point 'Wireless2' has security, but secrets are required.
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3396] device (wlxc025e96f9d55): state change: config ->
need-auth (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3401] sup-iface[0x56310c3b5a20,wlxc025e96f9d55]: wps: type
pbc start...
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3463] device (wlxc025e96f9d55): state change: need-auth ->
prepare (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3475] device (wlxc025e96f9d55): state change: prepare ->
config (reason 'none', sys-iface-state: 'managed')
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3481] device (wlxc025e96f9d55): Activation: (wifi)
connection 'Wireless2' has security, and secrets exist.  No new
secrets needed.
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3482] Config: added 'ssid' value 'Wireless2'
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3482] Config: added 'scan_ssid' value '1'
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3482] Config: added 'bssid' value 'A0:64:8F:XX:XX:XX'
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3483] Config: added 'key_mgmt' value 'WPA-PSK
WPA-PSK-SHA256 FT-PSK'
Nov 22 22:42:30 waterhole NetworkManager[654]: <info>
[1574458950.3483] Config: added 'psk' value '<hidden>'
Nov 22 22:42:30 waterhole wpa_supplicant[664]: wlxc025e96f9d55: SME:
Trying to authenticate with a0:64:8f:xx:xx:xx (SSID='Wireless2'
freq=5540 MHz)
Nov 22 22:42:30 waterhole kernel: [ 5635.734496] wlxc025e96f9d55:
authenticate with a0:64:8f:xx:xx:xx
Nov 22 22:42:31 waterhole NetworkManager[654]: <info>
[1574458951.1987] device (wlxc025e96f9d55): supplicant interface
state: disconnected -> authenticating
Nov 22 22:42:31 waterhole kernel: [ 5636.561696] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 1/3)
Nov 22 22:42:32 waterhole kernel: [ 5638.098611] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 2/3)
Nov 22 22:42:33 waterhole kernel: [ 5639.077555] wlxc025e96f9d55: send
auth to a0:64:8f:xx:xx:xx (try 3/3)
Nov 22 22:42:33 waterhole kernel: [ 5639.094020] wlxc025e96f9d55:
authentication with a0:64:8f:xx:xx:xx timed out
Nov 22 22:42:34 waterhole wpa_supplicant[664]: wlxc025e96f9d55:
CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="Wireless2" auth_failures=1
duration=10 reason=CONN_FAILED

... and repeats endlessly
