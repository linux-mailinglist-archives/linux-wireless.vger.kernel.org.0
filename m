Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171923B952E
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jul 2021 19:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhGARGX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jul 2021 13:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhGARGX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jul 2021 13:06:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6140BC061762
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jul 2021 10:03:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg14so11538591ejb.9
        for <linux-wireless@vger.kernel.org>; Thu, 01 Jul 2021 10:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soldelgroup-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pTNHpkXAAxo5HIXbpktO54o5sXiiMNlCOIHraoCWVcQ=;
        b=pWX9l4Zu/xWzT0gWULDqWnyDfysVDCOkKVTHEzd1a7//g6Z/1qLXTt8HFWMk9IoYl7
         yXe5+1vtnaX2dgxg5fwf6nmcrPZreevIVN2FLqhNWtx5AUvUDmgWHRZP4J2PVDQVxC+n
         H4mpBUT3CJ6hIBogMBCUMIvmNM1T5GB+WwznEbajYQsGxscQfEwxoHdV0F/UHdPXJi8y
         2uVNWzqstVk4b8g/B/wq+HUarnuRyuYNHarAmCOxF9jRTOBs2Vvka4p1VUx2S5F5s1rs
         PXXiarM0jcQWjgcJBFKOk3FZDyD3Ks95veWBW13ywOa9TyrIWpdZV9akqqoZ/7fj6zFv
         eCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pTNHpkXAAxo5HIXbpktO54o5sXiiMNlCOIHraoCWVcQ=;
        b=iWKyai//cAil6/RMn/K6UjpV9A8gBM2ZBgK2KBlwVNjPiuNDFsCFfOGVec2WWn6eLz
         m5fxyfFyrjPUffOsDgHlCfLTGoFuEf+9fSSbWf211NUZXTWPuIXW8ffZKEd8hPpdG+YE
         0otmknvQ/LZUvFe2sH2dExWxkgjAPajKLmbd842H/gzI4UYxsy1PIuoYcY0S1qjdlg3Y
         0Ly/jauECEc8KpabdZ590vb4Ef3UNPMtTGc6I9J9zbvfft78KVhiFW2eMJ/9TA4QyOks
         PnxX9Kf1v/oZpLr1OlCzeE8rCu+nuoFdnFl07D5v3tzcob9wJojzgapO6K/nm3Ryjwi6
         9+Ew==
X-Gm-Message-State: AOAM533ZkDdWCO82loZoNJHg5XvKo7syAVSH+uvYPxStDYUd5FJtRr2N
        R20EdX3CzOpsUeIJcMsbvK+B4TJo1Q6ZDtrS2KHveg==
X-Google-Smtp-Source: ABdhPJxQ3BuTbhF7fY+kegRYOgyfppJCmfX+5p05qM6ql/hhrqUE7Af8bFUwgR5OBIojMnrvmXMkLm5VrfUiLTKei6o=
X-Received: by 2002:a17:907:9809:: with SMTP id ji9mr929010ejc.235.1625159026787;
 Thu, 01 Jul 2021 10:03:46 -0700 (PDT)
MIME-Version: 1.0
From:   Christopher Chew <cc@soldelgroup.com>
Date:   Thu, 1 Jul 2021 18:03:35 +0100
Message-ID: <CANw61vGmvnMCrKaWCXO4b=m41YnoacomqpjcRTa2s60Q6w-c9Q@mail.gmail.com>
Subject: Netgear A6210 with mt76x2u driver issues?
To:     nbd@nbd.name, lorenzo.bianconi83@gmail.com
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Sorry for sending this twice but I got an email rejection notice as
the original email had snippets of html. I am resending this as pure
plain text. Original email continues below.

I apologize for cold emailing you but I have been encountering some
issues running a Netgear A6210 USB WiFi dongle with Ubuntu 18.04.05
with kernel v5.4.

Recently, due to network issues, I tried to use this USB adapter to
attempt to be both client to a WiFi and also act as an access point to
a bunch of devices.

Running lsusb -t shows the following.
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/7p, 5000M
    |__ Port 3: Dev 2, If 0, Class=Vendor Specific Class, Driver=mt76x2u, 5000M
    |__ Port 4: Dev 3, If 0, Class=Video, Driver=uvcvideo, 5000M
    |__ Port 4: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 5000M
    |__ Port 4: Dev 3, If 1, Class=Video, Driver=uvcvideo, 5000M
    |__ Port 4: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 5000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/8p, 480M
    |__ Port 1: Dev 3, If 0, Class=Hub, Driver=hub/4p, 480M
        |__ Port 1: Dev 4, If 0, Class=Human Interface Device,
Driver=usbhid, 12M
        |__ Port 1: Dev 4, If 1, Class=Human Interface Device,
Driver=usbhid, 12M
        |__ Port 3: Dev 5, If 0, Class=Human Interface Device,
Driver=usbhid, 1.5M
        |__ Port 3: Dev 5, If 1, Class=Human Interface Device,
Driver=usbhid, 1.5M
        |__ Port 4: Dev 6, If 2, Class=Audio, Driver=snd-usb-audio, 12M
        |__ Port 4: Dev 6, If 0, Class=Audio, Driver=snd-usb-audio, 12M
        |__ Port 4: Dev 6, If 3, Class=Human Interface Device,
Driver=usbhid, 12M
        |__ Port 4: Dev 6, If 1, Class=Audio, Driver=snd-usb-audio, 12M
    |__ Port 2: Dev 2, If 2, Class=Audio, Driver=snd-usb-audio, 12M
    |__ Port 2: Dev 2, If 0, Class=Audio, Driver=snd-usb-audio, 12M
    |__ Port 2: Dev 2, If 3, Class=Human Interface Device, Driver=usbhid, 12M
    |__ Port 2: Dev 2, If 1, Class=Audio, Driver=snd-usb-audio, 12M

The iw list of the Netgear A6210 USB adapter shows the following.

    Wiphy phy0
    max # scan SSIDs: 4
    max scan IEs length: 2243 bytes
    max # sched scan SSIDs: 0
    max # match sets: 0
    max # scan plans: 1
    max scan plan interval: -1
    max scan plan iterations: 0
    Retry short limit: 7
    Retry long limit: 4
    Coverage class: 0 (up to 0m)
    Device supports RSN-IBSS.
    Supported Ciphers:
        * WEP40 (00-0f-ac:1)
        * WEP104 (00-0f-ac:5)
        * TKIP (00-0f-ac:2)
        * CCMP-128 (00-0f-ac:4)
        * CCMP-256 (00-0f-ac:10)
        * GCMP-128 (00-0f-ac:8)
        * GCMP-256 (00-0f-ac:9)
        * CMAC (00-0f-ac:6)
        * CMAC-256 (00-0f-ac:13)
        * GMAC-128 (00-0f-ac:11)
        * GMAC-256 (00-0f-ac:12)
    Available Antennas: TX 0x3 RX 0x3
    Configured Antennas: TX 0x3 RX 0x3
    Supported interface modes:
         * IBSS
         * managed
         * AP
         * AP/VLAN
         * monitor
         * mesh point
    Band 1:
        Capabilities: 0x1ff
            RX LDPC
            HT20/HT40
            SM Power Save disabled
            RX Greenfield
            RX HT20 SGI
            RX HT40 SGI
            TX STBC
            RX STBC 1-stream
            Max AMSDU length: 3839 bytes
            No DSSS/CCK HT40
        Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
        Minimum RX AMPDU time spacing: 4 usec (0x05)
        HT TX/RX MCS rate indexes supported: 0-15
        Bitrates (non-HT):
            * 1.0 Mbps (short preamble supported)
            * 2.0 Mbps (short preamble supported)
            * 5.5 Mbps (short preamble supported)
            * 11.0 Mbps (short preamble supported)
            * 6.0 Mbps
            * 9.0 Mbps
            * 12.0 Mbps
            * 18.0 Mbps
            * 24.0 Mbps
            * 36.0 Mbps
            * 48.0 Mbps
            * 54.0 Mbps
        Frequencies:
            * 2412 MHz [1] (18.0 dBm)
            * 2417 MHz [2] (18.0 dBm)
            * 2422 MHz [3] (18.0 dBm)
            * 2427 MHz [4] (18.0 dBm)
            * 2432 MHz [5] (18.0 dBm)
            * 2437 MHz [6] (18.0 dBm)
            * 2442 MHz [7] (18.0 dBm)
            * 2447 MHz [8] (18.0 dBm)
            * 2452 MHz [9] (18.0 dBm)
            * 2457 MHz [10] (18.0 dBm)
            * 2462 MHz [11] (18.0 dBm)
            * 2467 MHz [12] (18.0 dBm) (no IR)
            * 2472 MHz [13] (18.0 dBm) (no IR)
            * 2484 MHz [14] (18.0 dBm) (no IR)
    Band 2:
        Capabilities: 0x1ff
            RX LDPC
            HT20/HT40
            SM Power Save disabled
            RX Greenfield
            RX HT20 SGI
            RX HT40 SGI
            TX STBC
            RX STBC 1-stream
            Max AMSDU length: 3839 bytes
            No DSSS/CCK HT40
        Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
        Minimum RX AMPDU time spacing: 4 usec (0x05)
        HT TX/RX MCS rate indexes supported: 0-15
        VHT Capabilities (0x318001b0):
            Max MPDU length: 3895
            Supported Channel Width: neither 160 nor 80+80
            RX LDPC
            short GI (80 MHz)
            TX STBC
            RX antenna pattern consistency
            TX antenna pattern consistency
        VHT RX MCS set:
            1 streams: MCS 0-9
            2 streams: MCS 0-9
            3 streams: not supported
            4 streams: not supported
            5 streams: not supported
            6 streams: not supported
            7 streams: not supported
            8 streams: not supported
        VHT RX highest supported: 0 Mbps
        VHT TX MCS set:
            1 streams: MCS 0-9
            2 streams: MCS 0-9
            3 streams: not supported
            4 streams: not supported
            5 streams: not supported
            6 streams: not supported
            7 streams: not supported
            8 streams: not supported
        VHT TX highest supported: 0 Mbps
        Bitrates (non-HT):
            * 6.0 Mbps
            * 9.0 Mbps
            * 12.0 Mbps
            * 18.0 Mbps
            * 24.0 Mbps
            * 36.0 Mbps
            * 48.0 Mbps
            * 54.0 Mbps
        Frequencies:
            * 5180 MHz [36] (18.0 dBm) (no IR)
            * 5200 MHz [40] (18.0 dBm) (no IR)
            * 5220 MHz [44] (18.0 dBm) (no IR)
            * 5240 MHz [48] (18.0 dBm) (no IR)
            * 5260 MHz [52] (18.0 dBm) (no IR, radar detection)
            * 5280 MHz [56] (18.0 dBm) (no IR, radar detection)
            * 5300 MHz [60] (18.0 dBm) (no IR, radar detection)
            * 5320 MHz [64] (18.0 dBm) (no IR, radar detection)
            * 5500 MHz [100] (18.0 dBm) (no IR, radar detection)
            * 5520 MHz [104] (18.0 dBm) (no IR, radar detection)
            * 5540 MHz [108] (18.0 dBm) (no IR, radar detection)
            * 5560 MHz [112] (18.0 dBm) (no IR, radar detection)
            * 5580 MHz [116] (18.0 dBm) (no IR, radar detection)
            * 5600 MHz [120] (18.0 dBm) (no IR, radar detection)
            * 5620 MHz [124] (18.0 dBm) (no IR, radar detection)
            * 5640 MHz [128] (18.0 dBm) (no IR, radar detection)
            * 5660 MHz [132] (18.0 dBm) (no IR, radar detection)
            * 5680 MHz [136] (18.0 dBm) (no IR, radar detection)
            * 5700 MHz [140] (18.0 dBm) (no IR, radar detection)
            * 5745 MHz [149] (18.0 dBm) (no IR)
            * 5765 MHz [153] (18.0 dBm) (no IR)
            * 5785 MHz [157] (18.0 dBm) (no IR)
            * 5805 MHz [161] (18.0 dBm) (no IR)
            * 5825 MHz [165] (18.0 dBm) (no IR)
    Supported commands:
         * new_interface
         * set_interface
         * new_key
         * start_ap
         * new_station
         * new_mpath
         * set_mesh_config
         * set_bss
         * authenticate
         * associate
         * deauthenticate
         * disassociate
         * join_ibss
         * join_mesh
         * set_tx_bitrate_mask
         * frame
         * frame_wait_cancel
         * set_wiphy_netns
         * set_channel
         * set_wds_peer
         * probe_client
         * set_noack_map
         * register_beacons
         * start_p2p_device
         * set_mcast_rate
         * connect
         * disconnect
         * set_qos_map
         * set_multicast_to_unicast
    Supported TX frame types:
         * IBSS: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90
0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
         * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90
0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
         * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0
0xb0 0xc0 0xd0 0xe0 0xf0
         * AP/VLAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90
0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
         * mesh point: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80
0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
         * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80
0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
         * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90
0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
         * P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80
0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
    Supported RX frame types:
         * IBSS: 0x40 0xb0 0xc0 0xd0
         * managed: 0x40 0xd0
         * AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
         * AP/VLAN: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
         * mesh point: 0xb0 0xc0 0xd0
         * P2P-client: 0x40 0xd0
         * P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
         * P2P-device: 0x40 0xd0
    software interface modes (can always be added):
         * AP/VLAN
         * monitor
    valid interface combinations:
         * #{ IBSS } <= 1, #{ managed, AP, mesh point } <= 2,
           total <= 2, #channels <= 1, STA/AP BI must match
    HT Capability overrides:
         * MCS: ff ff ff ff ff ff ff ff ff ff
         * maximum A-MSDU length
         * supported channel width
         * short GI for 40 MHz
         * max A-MPDU length exponent
         * min MPDU start spacing
    Device supports TX status socket option.
    Device supports HT-IBSS.
    Device supports SAE with AUTHENTICATE command
    Device supports low priority scan.
    Device supports scan flush.
    Device supports AP scan.
    Device supports per-vif TX power setting
    Driver supports full state transitions for AP/GO clients
    Driver supports a userspace MPM
    Device supports active monitor (which will ACK incoming frames)
    Device supports configuring vdev MAC-addr on create.
    Device supports VHT-IBSS.

Looking at the lines
valid interface combinations:
     * #{ IBSS } <= 1, #{ managed, AP, mesh point } <= 2,
       total <= 2, #channels <= 1, STA/AP BI must match

I assumed it should be able to do what I wanted, since I was able to
do this on my laptop with a builtin Intel WiFi adapter before.

Creating the 2 interfaces for the Netgear A6210 was not a problem.
I simply did this.
iw phy phy0 interface add sta0 type managed
iw phy phy0 interface add ap0 type __ap

wpa_supplicant.conf is very generic.

    # Giving configuration update rights to wpa_cli
    ctrl_interface=/run/wpa_supplicant
    ctrl_interface_group=wifi
    update_config=1

    # AP scanning
    ap_scan=1

    # ISO/IEC alpha2 country code in which the device is operating
    country=GB

    # network section generated by wpa_passphrase
    network={
        ssid="Test"
        psk="testtest"
    }

So with the above configurations, I then attempt to connect with the 2 commands.

    wpa_supplicant -i sta0 -c ./test.conf
    create_ap ap0 sta0 internal password

Everything looks like it is fine. The connection to the Test WiFi
network is fine and I can connect to the internet. The create_ap
command works fine, it shows that the AP is created and enabled.

wpa_supplicant output

    # wpa_supplicant -i sta0 -c ./example.conf
    Successfully initialized wpa_supplicant
    sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
(SSID='Test' freq=2412 MHz)
    sta0: Trying to associate with fc:ec:da:8a:84:de (SSID='Test' freq=2412 MHz)
    sta0: Associated with fc:ec:da:8a:84:de
    sta0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
    sta0: WPA: Key negotiation completed with fc:ec:da:8a:84:de
[PTK=CCMP GTK=CCMP]
    sta0: CTRL-EVENT-CONNECTED - Connection to fc:ec:da:8a:84:de
completed [id=0 id_str=]

create_ap output

    # create_ap ap0 sta0 internal password Config dir:
/tmp/create_ap.ap0.conf.EmWaK62U
    PID: 5027
    command failed: Operation not supported (-95)
    Creating a virtual WiFi interface... ap1 created.
    Sharing Internet using method: nat
    hostapd command-line interface: hostapd_cli -p
/tmp/create_ap.ap0.conf.EmWaK62U/hostapd_ctrl
    Configuration file: /tmp/create_ap.ap0.conf.EmWaK62U/hostapd.conf
    Using interface ap1 with hwaddr 78:d2:94:4a:e0:4c and ssid "internal"
    ap1: interface state UNINITIALIZED->ENABLED
    ap1: AP-ENABLED

So I then try to connect my devices onto "internal" and none of my
devices can connect.

If I did the reverse, which is to create_ap first, then connect to the
wpa_supplicant, the following happens.

create_ap

    # create_ap ap0 sta0 internal password Config dir:
/tmp/create_ap.ap0.conf.BWI2H1Dx
    PID: 8258
    command failed: Operation not supported (-95)
    Creating a virtual WiFi interface... ap1 created.
    Sharing Internet using method: nat
    hostapd command-line interface: hostapd_cli -p
/tmp/create_ap.ap0.conf.BWI2H1Dx/hostapd_ctrl
    Configuration file: /tmp/create_ap.ap0.conf.BWI2H1Dx/hostapd.conf
    Using interface ap1 with hwaddr 78:d2:94:4a:e0:4c and ssid "internal"
    ap1: interface state UNINITIALIZED->ENABLED
    ap1: AP-ENABLED
    ap1: STA 98:01:a7:48:0f:d8 IEEE 802.11: authenticated
    ap1: STA 98:01:a7:48:0f:d8 IEEE 802.11: associated (aid 1)
    ap1: AP-STA-CONNECTED 98:01:a7:48:0f:d8
    ap1: STA 98:01:a7:48:0f:d8 RADIUS: starting accounting session
57A210FFA9AEB7DF
    ap1: STA 98:01:a7:48:0f:d8 WPA: pairwise key handshake completed (RSN)

As you can see, create_ap not only is created, but I manage to connect
a tablet onto the access point.
If I now try to run wpa_supplicant, this now happens.

    # wpa_supplicant -i sta0 -c ./example.conf
    Successfully initialized wpa_supplicant
    sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
(SSID='Test' freq=2412 MHz)
    sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
(SSID='Test' freq=2412 MHz)
    sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
(SSID='Test' freq=2412 MHz)
    sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
(SSID='Test' freq=2412 MHz)
    sta0: CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="Test"
auth_failures=1 duration=10 reason=CONN_FAILED
    sta0: CTRL-EVENT-SSID-REENABLED id=0 ssid="Test"
    sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
(SSID='Test' freq=2412 MHz)
    sta0: CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="Test"
auth_failures=2 duration=23 reason=CONN_FAILED
    sta0: CTRL-EVENT-SSID-REENABLED id=0 ssid="Test"
    sta0: SME: Trying to authenticate with fc:ec:da:8a:84:de
(SSID='Test' freq=2412 MHz)
    sta0: CTRL-EVENT-SSID-TEMP-DISABLED id=0 ssid="Test"
auth_failures=3 duration=46 reason=CONN_FAILED

This will go on forever never being able to authenticate.

Furthermore, there is a case where I can crash the driver.
To do that, what I do is I run wpa_supplicant first. Immediately after
I see it has initialized wpa_supplicant and is trying to authenticate,
I immediately run create_ap on another terminal window. Create_ap will
finish first usually and be able to start the ap. But the wireless
network will not be running. Checking dmesg will show this.

    [ 1692.699658] wpa_supplicant  D    0  2613   2612 0x00004000
    [ 1692.699664] Call Trace:
    [ 1692.699673]  __schedule+0x292/0x710
    [ 1692.699681]  ? work_busy+0x90/0x90
    [ 1692.699686]  schedule+0x33/0xa0
    [ 1692.699693]  schedule_timeout+0x1d3/0x320
    [ 1692.699700]  ? ttwu_do_activate+0x5a/0x70
    [ 1692.699707]  ? work_busy+0x90/0x90
    [ 1692.699713]  wait_for_completion+0xba/0x140
    [ 1692.699718]  ? wake_up_q+0x80/0x80
    [ 1692.699726]  __flush_work+0x18a/0x1c0
    [ 1692.699734]  ? worker_detach_from_pool+0xb0/0xb0
    [ 1692.699740]  __cancel_work_timer+0x136/0x1b0
    [ 1692.699746]  ? schedule_preempt_disabled+0xe/0x10
    [ 1692.699754]  ? hrtimer_try_to_cancel+0x2a/0x110
    [ 1692.699760]  cancel_work_sync+0x10/0x20
    [ 1692.699769]  mt76x02u_stop_pre_tbtt_timer+0x2a/0x40 [mt76x02_usb]
    [ 1692.699777]  mt76x02u_pre_tbtt_enable+0x23/0x40 [mt76x02_usb]
    [ 1692.699791]  mt76x02_mac_set_beacon_enable+0x33/0x2c0 [mt76x02_lib]
    [ 1692.699804]  mt76x02_bss_info_changed+0x107/0x110 [mt76x02_lib]
    [ 1692.699872]  ieee80211_bss_info_change_notify+0xab/0x190 [mac80211]
    [ 1692.699936]  ieee80211_offchannel_stop_vifs+0x175/0x1b0 [mac80211]
    [ 1692.699998]  __ieee80211_start_scan+0x346/0x750 [mac80211]
    [ 1692.700061]  ieee80211_request_scan+0x30/0x50 [mac80211]
    [ 1692.700129]  ieee80211_scan+0x69/0x90 [mac80211]
    [ 1692.700204]  nl80211_trigger_scan+0x5cd/0x740 [cfg80211]
    [ 1692.700215]  genl_family_rcv_msg+0x21c/0x490
    [ 1692.700224]  ? free_one_page+0xbc/0x480
    [ 1692.700233]  genl_rcv_msg+0x4c/0x90
    [ 1692.700239]  ? genl_family_rcv_msg+0x490/0x490
    [ 1692.700247]  netlink_rcv_skb+0x51/0x120
    [ 1692.700254]  genl_rcv+0x28/0x40
    [ 1692.700260]  netlink_unicast+0x1a4/0x250
    [ 1692.700268]  netlink_sendmsg+0x2eb/0x3f0
    [ 1692.700277]  sock_sendmsg+0x63/0x70
    [ 1692.700283]  ____sys_sendmsg+0x200/0x280
    [ 1692.700291]  ___sys_sendmsg+0x88/0xd0
    [ 1692.700297]  ? sock_do_ioctl+0x4d/0x150
    [ 1692.700304]  ? __check_object_size+0x4d/0x1b0
    [ 1692.700310]  ? sock_ioctl+0x34f/0x3c0
    [ 1692.700317]  ? __sys_recvfrom+0xe9/0x160
    [ 1692.700325]  __sys_sendmsg+0x63/0xa0
    [ 1692.700330]  ? __sys_sendmsg+0x63/0xa0
    [ 1692.700339]  __x64_sys_sendmsg+0x1f/0x30
    [ 1692.700347]  do_syscall_64+0x57/0x190
    [ 1692.700355]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
    [ 1692.700362] RIP: 0033:0x7f7020b67b94
    [ 1692.700377] Code: Bad RIP value.
    [ 1692.700382] RSP: 002b:00007ffc2f22d978 EFLAGS: 00000246
ORIG_RAX: 000000000000002e
    [ 1692.700389] RAX: ffffffffffffffda RBX: 000055f6ab3c29f0 RCX:
00007f7020b67b94
    [ 1692.700393] RDX: 0000000000000000 RSI: 00007ffc2f22d9b0 RDI:
0000000000000005
    [ 1692.700398] RBP: 000055f6ab411700 R08: 0000000000000000 R09:
0000000000000000
    [ 1692.700402] R10: 000055f6ab3c0010 R11: 0000000000000246 R12:
000055f6ab3c2900
    [ 1692.700406] R13: 00007ffc2f22d9b0 R14: 0000000000000000 R15:
000055f6ab3c2d48

So I'm sort of arriving at a conclusion that for some reason, this
Netgear A6210 is not able to create both an access point and connect
to a WiFi network at the same time. Yet iw list suggests that the
driver can. Is there something I'm misunderstanding?

Or am I doing something incorrectly? If I am, please do point it out.

Lastly, if there is any information missing and you need, please feel
free to ask and I will do my best to provide it, or reproduce the
issue and provide the information you need.


Best regards,
Chris

ps. Apologies for resending this. I got a rejection notice for one of
the recipients because it contained some html.
